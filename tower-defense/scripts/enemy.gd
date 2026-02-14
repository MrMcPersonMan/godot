extends PathFollow2D
var end = null
var pathNum = 1
@export var type:int
@export var level:int
@export var health: float
@export var attackDamage:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = type
	$AnimatedSprite2D.modulate = global.enemyColours[level]
	$ProgressBar.max_value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.gamePaused:
		progress += delta * 20 * global.gameSpeed
		
	if progress_ratio < 1:
		return
		
	if get_parent() == end:
		global.health -= attackDamage
		print("die")
		queue_free()
		return
		
	pathNum += 1
	reparent(get_parent().next)
	progress = 0
		
func damage(DamageTaken,red):
	$ProgressBar.visible = true
	health -= DamageTaken
	$ProgressBar.value = health
	if health <= 0:
		queue_free()
		return
		
	if red:
		$Timer.start()
		$AnimatedSprite2D.modulate = Color.RED


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.modulate = global.enemyColours[level]
