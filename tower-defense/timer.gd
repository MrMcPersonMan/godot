extends Node2D

signal timeout()

@export var waitTime:float = 1
@export var oneShot:bool = false
@export var timeScale:float = 1
@export var running:bool = false

var paused:bool = false
var progress:float = 0:
	set(value):
		progress = value
		if progress >= waitTime:
			timeout.emit()
			if oneShot:
				running = false
				progress = waitTime
			else:
				progress = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  running and waitTime > 0 and not paused:
		progress += delta*timeScale

func start(time = null):
	if time:
		waitTime = timeScale
	progress = 0
	running = true
	
func stop():
	running = false
