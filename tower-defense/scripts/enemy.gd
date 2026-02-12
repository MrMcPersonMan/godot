extends PathFollow2D
var end = null
var pathNum = 1
@export var type: int
@export var level:int
@export var health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = type * 4 + level - 5 
	$ProgressBar.max_value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.gamePaused:
		progress += delta * 20 * global.gameSpeed
		
	if progress_ratio < 1:
		return
		
	if get_parent() == end:
		global.health -= 1
		global.healthUpdate.emit(global.health)
		queue_free()
		return
		
	pathNum += 1
	reparent(get_parent().next)
	progress = 0
		
func damage(Damage,red):
	$ProgressBar.visible = true
	health -= Damage
	$ProgressBar.value = health
	if health <= 0:
		queue_free()
		return
		
	if red:
		$AnimatedSprite2D.frame = type * 4 - 1
		$Timer.start()
	


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = type * 4 + level - 5
