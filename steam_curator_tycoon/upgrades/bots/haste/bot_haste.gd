class_name BotHaste
extends Upgrade


var sell_duration: float = 0.0
var review_duration: float = 0.0
var email_duration: float = 0.0
var idle_duration: float = 0.0


func _init(_key: StringName) -> void:
	super(_key)
	match _key:
		&"bot_haste6":
			idle_duration = -0.1875
			email_duration = -0.375
			review_duration = -0.75
			sell_duration = -1.125
		&"bot_haste5":
			sell_duration = -1.5
			review_duration = -1.0
			email_duration = -0.5
			idle_duration = -0.25
		&"bot_haste3":
			sell_duration = -3.0
			review_duration = -2.0
			email_duration = -1.0
			idle_duration = -0.5
		&"bot_haste1", &"bot_haste2", &"bot_haste4":
			sell_duration = -3.0
			review_duration = -2.0
			email_duration = -1.0
	applied.changed.connect(update)


func update() -> void:
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	Bot.sell_duration += sell_duration * multiplier
	Bot.review_duration += review_duration * multiplier
	Bot.email_duration += email_duration * multiplier
	Bot.idle_duration += idle_duration * multiplier
	Bot.update_durations()
