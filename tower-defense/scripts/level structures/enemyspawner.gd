extends Node2D

@export_enum("regular","fast","strong","healing","5","6") var EnemyType: int
@export var enemyLevel:int
@export var attackdamage:int
@export var health:int
@export var amount:int
@export_enum("total time","interval time") var type
@export var time:float
@export var route:Node2D

signal done

const enemy = preload("res://scenes/enemy.tscn")

var intervalTime:float
var spawned:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.speedUpdate.connect(updateSpeed)
	global.gamePause.connect(pauseUpdate)
	
	if type:
		intervalTime = time
	else:
		intervalTime = time/amount
	$timer.waitTime = intervalTime

func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var t = enemy.instantiate()
	t.type = EnemyType
	t.level = enemyLevel
	t.health = health
	t.attackDamage = attackdamage
	t.end = route.end
	route.start.add_child(t)
	spawned += 1
	if spawned >= amount:
		$timer.stop()
		done.emit(self)

func start():
	$timer.start(intervalTime)
	spawned = 0

func updateSpeed(speed):

	$timer.timeScale = speed

func pauseUpdate(paused):
	$timer.paused = paused
	
