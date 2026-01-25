extends Node2D

const level = preload("res://scenes/level.tscn")
const menu = preload("res://scenes/menu.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(menu.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
