extends Node2D
const enemy = preload("res://enemy.tscn")

@export var start:Node
@export var end:Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.speedUpdate.connect(speedUpdate)
	global.gamePause.connect(pauseUpdate)
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var t = enemy.instantiate()
	t.end = end
	start.add_child(t)

func pauseUpdate(toggled:bool):
	$Timer.paused = toggled

func speedUpdate(speed):
	$Timer.wait_time =  2 / speed
