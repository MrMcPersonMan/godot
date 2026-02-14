@tool()
extends Node2D

var enemyAreas = null
var targeted = null

@export var areas: Array[Node]
@export var timer:Node
@export var damage: int
@export var attackTime:int
@export var cost: int
var paused:bool = false

@export var ToweRange: int:
	set(value):
		print("edited")
		ToweRange = value
		TowerRangeP = value * 1024 + 512
		for area in areas:
			area.get_node("CollisionShape2D").shape.radius = TowerRangeP

var TowerRangeP:int

func _ready() -> void:
	global.gamePause.connect(pauseUpdate)
	paused = global.gamePaused
	print(paused)

func setUpTimer():
	timer.wait_time = attackTime
	timer.start()

func calculateTarget(area):
	enemyAreas = area.get_overlapping_areas()
	if len(enemyAreas) < 1:
		return null
	
	var enemy = null
	var furthest = null     
	var progress = -1
	var path = -1
	for Area in enemyAreas:
		enemy = Area.get_parent()
		if enemy.pathNum > path:
			path = enemy.pathNum
			progress = enemy.progress
			furthest = enemy
		elif enemy.pathNum == path:
			if enemy.progress > progress:
				furthest = enemy
				progress = enemy.progress
	
	return furthest
	
	
func laserAttack(target,line,particles):
	line.visible = true
	line.points[1] = to_local(target.global_position)
	particles.position = to_local(target.global_position)
	particles.emitting = true

func pauseUpdate(pause):
	paused = pause
	timer.paused = pause
	print(paused)
