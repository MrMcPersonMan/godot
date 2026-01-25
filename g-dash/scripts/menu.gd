extends Node2D
var screen = 1

signal start
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		screen -= 1
		if screen == 0:
			screen = 4
			$Camera2D.position.x += 1152 * 4
		
	if Input.is_action_just_pressed("right"):
		screen += 1
		if screen == 5:
			screen = 1
			$Camera2D.position.x += -1152 * 4
			
	if Input.is_action_just_pressed("click"):
		start.emit()
		
	$Camera2D.position.x += (((screen-1) * 1152)-$Camera2D.position.x)/20
