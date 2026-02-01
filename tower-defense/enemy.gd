extends PathFollow2D
var end = null
var pathNum = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.gamePaused:
		progress += delta * 20 * global.gameSpeed
	if progress_ratio >= 1:
		if get_parent() == end:
			global.health -= 1
			global.healthUpdate.emit(global.health)
			queue_free()
		else:
			pathNum += 1
			reparent(get_parent().next)
			progress = 0
	
