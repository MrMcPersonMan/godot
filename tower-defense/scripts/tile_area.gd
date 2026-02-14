extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.selectedTowerUpdate.connect(update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event is InputEventMouseButton or not event.button_index == MOUSE_BUTTON_LEFT or not event.is_pressed():
		return
	
	if global.selectedTower:
		get_parent().place_tile(self)
	else:
		pass

func update(tower):
	if tower:
		$Polygon2D.visible = true
	else:
		$Polygon2D.visible = false
