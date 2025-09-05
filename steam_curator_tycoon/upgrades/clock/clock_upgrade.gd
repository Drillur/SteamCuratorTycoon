class_name ClockUpgrade
extends Upgrade


func _init(_key: StringName) -> void:
	super(_key)
	applied.changed.connect(update)


func update() -> void:
	var amount_gained: float = (
		0.50 if key == &"xclock_hour_duration1"
		else 0.0
	)
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	Clock.hour_duration -= amount_gained * multiplier
