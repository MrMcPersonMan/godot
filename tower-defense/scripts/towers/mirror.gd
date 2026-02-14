@tool
extends "res://scripts/towers/tower.gd"
var using = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint() or paused:
		return
		
	targeted = calculateTarget($Area2D)
	
	if len(using) == 0 or not targeted:
		$Line2D.visible = false
		$CPUParticles2D.emitting = false
		return
		
	var d = 0
	for item in using:
		d += item.damage
	
	$Line2D.width_curve.set_point_value(0,len(using))
	targeted.damage(damage * d * _delta ,false)	
	laserAttack(targeted,$Line2D,$CPUParticles2D)
	

func addUser(node):
	using.append(node)
	
func removeUser(node):
	using.erase(node)
