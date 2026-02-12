@tool
extends "res://scripts/towers/tower.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		setUpTimer($Timer)
		$Timer.timeout.connect(fireGun)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		targeted = calculateTarget($Area2D)
		if targeted:
			look_at(targeted.global_position)


func fireGun():
	if targeted:
		$CPUParticles2D.restart()
		targeted.damage(damage,true)
		
