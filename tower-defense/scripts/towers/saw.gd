@tool
extends "res://scripts/towers/tower.gd"
@export var defaultScale:Vector2 = Vector2.ONE
@export var _scaleMult:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	setUpTimer()
	$Timer.timeout.connect(saw)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimatedSprite2D.scale = defaultScale * (1 + (_scaleMult-1)* 2 * (ToweRange))

func saw():
	$AnimationPlayer.current_animation = "spin"

func attack():
	var area = $Area2D
	for enemy in area.get_overlapping_areas():
		enemy.get_parent().damage(damage,true)
