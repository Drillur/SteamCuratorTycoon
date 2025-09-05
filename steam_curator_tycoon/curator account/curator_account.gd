class_name CuratorAccount
extends Resource


static var instance: CuratorAccount

@export var name: String = _CuratorAccountName.get_random_name()
@export var followers: int = 0


#region Init


func _init() -> void:
	instance = self
	Clock.instance.hour_passed.connect(gain_followers_passively)


#endregion


#region Control


## Called from Clock.hour_passed
func gain_followers_passively() -> void:
	const MINIMUM_REQUIRED_FOR_ANYTHING_TO_HAPPEN: int = 2_500
	if followers < MINIMUM_REQUIRED_FOR_ANYTHING_TO_HAPPEN:
		return
	
	var gain: int = roundi(float(followers) * randf_range(0.00001, 0.0002))
	if gain > 0:
		followers += gain


#endregion
