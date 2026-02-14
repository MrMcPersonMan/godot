extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func place_tile(node):
	print(node)
	var tower = global.selectedTower
	var cost = tower.getCost()
	if cost > global.money:
		global.noMoney.emit()
		return
		
	global.money -= cost
	global.buy.emit()
	var pos = local_to_map(node.position)
	set_cell(pos,1,Vector2i.ZERO,tower.id)
	tower.instantces += 1
