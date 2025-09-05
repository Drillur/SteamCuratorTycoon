class_name ChartLimit
extends Upgrade


func _init(_key: StringName) -> void:
	super(_key)
	applied.changed.connect(update)


func update() -> void:
	var amount_gained: int = data[key].get("Effect", 1)
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	SteamGame.add_total_count(amount_gained * multiplier)
