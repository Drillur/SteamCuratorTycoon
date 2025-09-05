class_name BotNode
extends MarginContainer


static var top_id: int = 0 ## The id of the BotNode at the top of the list

var node_index: int
var id: int = -1:
	set = set_id

#region Onready Variables

@onready var id_label: RichTextLabel = %IdLabel
@onready var status_label: RichTextLabel = %StatusLabel
@onready var duration_label: RichTextLabel = %DurationLabel

#endregion


#region Ready


func _ready() -> void:
	node_index = get_index()


#endregion


#region Setters


func set_id(new_id: int) -> void:
	if id == new_id:
		return
	if id > -1:
		clear()
	
	id = new_id
	
	setup()


#endregion


#region Control


func setup() -> void:
	id_label.text = "Bot %s" % (id + 1)
	update_status()
	update_duration(0.0)
	Bot.list[id].status_text_changed.connect(update_status)
	Bot.list[id].time_left_changed.connect(update_duration)


func update_status() -> void:
	status_label.text = Bot.list[id].status_text


func update_duration(time_left: float) -> void:
	const TEXT: String = "%ss"
	duration_label.text = TEXT % str(time_left).pad_decimals(2)


func clear() -> void:
	Bot.list[id].status_text_changed.disconnect(update_status)
	Bot.list[id].time_left_changed.disconnect(update_duration)


#endregion
