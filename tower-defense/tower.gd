extends Node2D

var enemys = null
@export var range: int
@export var damage: int
@export var attackTime:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
		


func _on_timer_timeout() -> void:
	enemys = get_tree().get_nodes_in_group("enemys")
	
	if len(enemys) > 1:
		var furthest = null
		var progress = -1
		var path = -1
		var dist = null
		for enemy in enemys:
			dist = (global_position - enemy.global_position).length()
			if dist <= range:
				if enemy.pathNum > path:
					print("-----")
					print(enemy.pathNum)
					print(path)
					path = enemy.pathNum
					progress = enemy.progress
					furthest = enemy
				elif enemy.pathNum == path:
					if enemy.progress < progress:
						furthest = enemy
						progress = enemy.progress
		if furthest:
			global_position = furthest.global_position
			look_at(furthest.global_position)
