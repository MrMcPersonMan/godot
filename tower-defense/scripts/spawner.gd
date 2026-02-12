extends Node2D
const enemy = preload("res://scenes/enemy.tscn")


@export var start:Node
@export var end:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.speedUpdate.connect(speedUpdate)
	global.gamePause.connect(pauseUpdate)
	speedUpdate(global.gameSpeed)
	$Timer.start()
	_on_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var t = enemy.instantiate()
	t.end = end
	start.add_child(t)

func pauseUpdate(toggled:bool):
	$Timer.paused = toggled

func speedUpdate(speed):
	$Timer.wait_time =  200 / speed
