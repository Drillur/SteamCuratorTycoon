class_name ChartUpdate
extends Upgrade


func _init(_key: StringName) -> void:
	super(_key)
	applied.changed.connect(update)


func update() -> void:
	var multiplier: float = 1.0 if applied.is_true() else -1.0
	SteamGame.refresh_rate_stage += multiplier
	SteamGame.update_refresh_rate_stage()
