@tool
extends Node2D


@export_tool_button("create level") var action = createLevel

func createLevel():
	var template = $template
	var new = template.duplicate(7)
	print(new)
	add_child(new)
	EditorInterface.mark_scene_as_unsaved()
	new.owner = get_tree().edited_scene_root

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
