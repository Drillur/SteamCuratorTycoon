class_name BotWeight
extends Upgrade


func _init(_key: StringName) -> void:
	super(_key)
	applied.changed.connect(update)


func update() -> void:
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	match key:
		&"bot_email_weight1":
			Bot.email_weight_obvious_fake -= 10.0 * multiplier
			Bot.email_weight_lacking -= 7.5 * multiplier
			Bot.email_weight_standard -= 5.0 * multiplier
			Bot.email_weight_good -= 2.5 * multiplier
		&"bot_review_weight1":
			Bot.review_weight_harmful -= 10.0 * multiplier
			Bot.review_weight_useless -= 7.5 * multiplier
			Bot.review_weight_standard -= 5.0 * multiplier
			Bot.review_weight_insightful -= 2.5 * multiplier
