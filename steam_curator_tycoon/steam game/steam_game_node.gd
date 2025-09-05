class_name SteamGameNode
extends MarginContainer


var steam_game: SteamGame:
	set = set_steam_game

#region Onready Variables

@onready var name_label: RichTextLabel = %NameLabel
@onready var price_label: RichTextLabel = %PriceLabel
@onready var emailed_checkbox: CheckBox = %EmailedCheckbox
@onready var reviewed_checkbox: CheckBox = %ReviewedCheckbox
@onready var keys_checkbox: CheckBox = %KeysCheckbox
@onready var follower_label: RichTextLabel = %FollowerLabel
@onready var days_until_release_label: RichTextLabel = %DaysUntilReleaseLabel
@onready var declined_container: MarginContainer = %DeclinedContainer
@onready var highlight: Panel = %Highlight

#endregion


#region Ready


func _ready() -> void:
	Clock.instance.day_passed.connect(update_days_until_release)


#endregion


#region Setters


func set_steam_game(new_game: SteamGame) -> void:
	if steam_game:
		if steam_game == new_game:
			return
		clear()
	steam_game = new_game
	setup()


#endregion


#region Control


func setup() -> void:
	name_label.text = steam_game.name
	price_label.text = "$" + SteamCuratorsMod.format_number(steam_game.price)
	follower_label.text = SteamCuratorsMod.format_number(steam_game.followers) + " Followers"
	
	highlight.modulate = steam_game.color
	declined_container.modulate = steam_game.color
	
	steam_game.state_changed.connect(update_ui)
	steam_game.review_written_changed.connect(update_ui)
	steam_game.state_changed.connect(update_keys)
	steam_game.keys_changed.connect(update_keys)
	update_ui()
	update_keys()
	update_days_until_release()
	
	steam_game.node = self
	show()


func update_days_until_release() -> void:
	if not steam_game:
		return
	const TEXT: String = "%s Days Until Release"
	var day_text: String = SteamCuratorsMod.format_number(steam_game.days_until_release)
	days_until_release_label.text = TEXT % day_text


func update_ui() -> void:
	emailed_checkbox.button_pressed = steam_game.state >= SteamGame.State.DECLINED
	reviewed_checkbox.button_pressed = 	steam_game.review_written
	keys_checkbox.button_pressed = (
		steam_game.state > SteamGame.State.DECLINED
		and steam_game.keys == 0
		and steam_game.keys_in_use == 0
	)
	
	highlight.visible = steam_game.state > SteamGame.State.DECLINED
	
	declined_container.visible = steam_game.state == SteamGame.State.DECLINED
	modulate.a = 0.5 if declined_container.visible else 1.0


func update_keys() -> void:
	if steam_game.state < SteamGame.State.AWAITING_REVIEW:
		const TEXT: String = "No Keys Yet"
		keys_checkbox.text = TEXT
	
	elif steam_game.keys > 0 or steam_game.keys_in_use > 0:
		const TEXT: String = "%s Keys Left"
		keys_checkbox.text = TEXT % SteamCuratorsMod.format_number(steam_game.keys)
	
	else:
		const TEXT: String = "Keys Used"
		keys_checkbox.text = TEXT


func clear() -> void:
	steam_game.state_changed.disconnect(update_ui)
	steam_game.keys_changed.disconnect(update_keys)
	steam_game.state_changed.disconnect(update_keys)
	steam_game.review_written_changed.disconnect(update_ui)
	steam_game.node = null
	hide()


#endregion
