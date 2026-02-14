extends Node2D

const breakDamages = [0.66,0.33,0.0001,0,0]
var breakLevel = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.healthUpdate.connect(healthUpdate)
	$AnimatedSprite2D.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func next_costume():
	$AnimatedSprite2D.frame = breakLevel
	print("next")
	
func healthUpdate(health):
	print(health)
	print(breakDamages[breakLevel] *  global.maxHealth )
	while breakDamages[breakLevel] *  global.maxHealth > health:
		breakLevel += 1
		$AnimationPlayer.play("first break")
