class_name Curator1
extends MarginContainer


static var instance: Curator1


#region Onready Variables

@onready var day_label: RichTextLabel = %DayLabel
@onready var hour_label: RichTextLabel = %HourLabel
@onready var refresh_label: RichTextLabel = %RefreshLabel

@onready var bots: VBoxContainer = %Bots
@onready var steam_games: GridContainer = %SteamGames

@onready var bot_count_label: RichTextLabel = %BotCountLabel

@onready var refactor_label: RichTextLabel = %RefactorLabel
@onready var key_gain_multiplier_label: RichTextLabel = %KeyGainMultiplierLabel
@onready var follower_gain_multiplier_label: RichTextLabel = %FollowerGainMultiplierLabel
@onready var key_value_multiplier_label: RichTextLabel = %KeyValueMultiplierLabel
@onready var bot_log_text_edit: TextEdit = %BotLog

#endregion


#region Ready


func _ready() -> void:
	instance = self
	Clock.instance.day_passed.connect(update_steam_games)
	#Clock.instance.day_passed.connect(update_day_label)
	
	await SteamCuratorsMod.instance.loaded
	
	#update_day_label()
	update_steam_games()
	update_bot_node_ids()
	
	SteamCuratorsMod.currency_get_changed_signal(&"bot").connect(Bot.update_count)
	SteamCuratorsMod.currency_get_changed_signal(&"bot").connect(update_bot_count)
	SteamCuratorsMod.currency_get_changed_signal(&"refactor").connect(Bot.update_refactor_values)
	
	update_bot_count()
	Bot.update_count()
	Bot.update_refactor_values()


#endregion


#region Signals


func _on_bots_gui_input(event: InputEvent) -> void:
	const MAX: int = 10
	if (
		not event is InputEventMouseButton
		or not event.is_pressed()
		or not (
			event.button_index == MOUSE_BUTTON_WHEEL_UP
			or event.button_index == MOUSE_BUTTON_WHEEL_DOWN
		)
	):
		return
	
	var scrolled_up: bool = event.button_index == MOUSE_BUTTON_WHEEL_UP
	var new_index: int = BotNode.top_id + (-1 if scrolled_up else 1)
	
	var max_index := maxi(Bot.count_total - MAX, 0)
	BotNode.top_id = clampi(new_index, 0, max_index)
	update_bot_node_ids()


#endregion


#region Control


func update_bot_node_ids() -> void:
	for node: BotNode in bots.get_children():
		node.id = BotNode.top_id + node.node_index


func update_steam_games() -> void:
	if SteamGame.list.is_empty():
		return
	
	var i: int = 0
	for node: SteamGameNode in steam_games.get_children():
		if i >= SteamGame.list.size():
			node.hide()
		else:
			
			node.steam_game = SteamGame.list[i]
			node.show()
		i += 1


func update_day_label() -> void:
	day_label.text = "Day %s" % SteamCuratorsMod.instance.day


func update_hour_label() -> void:
	hour_label.text = "%s:00" % str(Clock.instance.hour).pad_zeros(2)


func update_bot_count() -> void:
	bot_count_label.text = "%s/%s Bots" % [
		Bot.count_current,
		Bot.count_total
	]


func update_refactor_labels() -> void:
	refactor_label.text = "%s Refactors" % SteamCuratorsMod.currency_get_text(&"refactor")
	key_gain_multiplier_label.text = "Keys Gained [b]x%s" % SteamCuratorsMod.format_number(Bot.refactor_key_gain_multiplier)
	follower_gain_multiplier_label.text = "Followers Gained [b]x%s" % SteamCuratorsMod.format_number(Bot.refactor_follower_gain_multiplier)
	key_value_multiplier_label.text = "Key Value [b]x%s" % SteamCuratorsMod.format_number(Bot.refactor_key_value_multiplier)


func update_bot_log() -> void:
	bot_log_text_edit.text = ""
	for x in Bot.status_log:
		bot_log_text_edit.text += x


#endregion
