class_name Clock
extends RefCounted


signal day_passed
signal hour_passed

static var instance: Clock
static var hour_duration: float = 1.0

var hour: int = 0


#region Init


func _init() -> void:
	instance = self
	process_time()


#endregion


#region Control


func process_time() -> void:
	while true:
		await SteamCuratorsMod.instance.get_tree().create_timer(hour_duration).timeout
		
		hour += 1
		
		if hour >= 24:
			hour = 0
			day_passed.emit()
		hour_passed.emit()


#endregion


#region Get Values





#endregion
