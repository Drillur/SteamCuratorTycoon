class_name BotLimit
extends Upgrade


func _init(_key: StringName) -> void:
	super(_key)
	applied.changed.connect(update)


func update() -> void:
	var amount_gained: float = data[key].get("Effect", 0.0)
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	Bot.add_total_count(roundi(amount_gained * multiplier))
