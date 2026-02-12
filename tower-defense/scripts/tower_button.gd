extends Button

@export var towerName:String
@export var cost:Array[int] = [1,3,6,10]
@export var costIncrease:int = 5
@export var towerNode:Node
@export var id:int

var instantces = 0:
	set(value):
		instantces = value
		$cost.text = str(getCost())
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


	
func getCost():
	if instantces < len(cost):
		return cost[instantces]
	else:
		return cost[-1] + costIncrease * (instantces - len(cost) + 1)
		
