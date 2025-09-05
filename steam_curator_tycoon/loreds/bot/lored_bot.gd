class_name BotLORED
extends LORED


#region Init


func _init(_key: StringName) -> void:
	super(_key)


#endregion


#region Jobs


func _can_start_job(job: Job, _maximum_cost: Dictionary = {}) -> bool:
	if job.key == &"deploy" and Bot.is_count_full():
		return false
	elif job.key == &"refactor" and not Bot.is_count_full():
		return false
	return super(job, _maximum_cost)


#func _get_job_output(job: Job, _get_type: GetType) -> Dictionary:
	#var result := {}
	#
	#match job.key:
		#&"deploy":
			#result[&"bot"] = Big.new(Big.ONE)
		#_:
			#return super(job, _get_type)
	#
	#return result


#endregion
