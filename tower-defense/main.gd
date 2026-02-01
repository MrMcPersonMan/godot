extends Node2D
var clickPos = Vector2.ZERO
var mouseArea = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.mouseUpdate.connect(mouseChange)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(" click") and mouseArea:
		clickPos = get_global_mouse_position()
	elif Input.is_action_pressed(" click") and mouseArea:
		$Camera2D.position += clickPos - get_global_mouse_position()

func mouseChange(type:bool):
	mouseArea = not type
