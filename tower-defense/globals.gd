extends Node

const game = preload("res://game.tscn")
const display = preload("res://display.tscn")
const menu = preload("res://mainMenu.tscn")

signal healthUpdate(health)
signal mouseUpdate(type:bool)
signal gamePause(toggled:bool)
signal speedUpdate(speed:int)

var health = 100
var gamePaused = false
var gameSpeed = 1
var maxHealth = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gamePause.connect(pauseScript)
	speedUpdate.connect(speedScript)
	add_child(game.instantiate())
	add_child(display.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pauseScript(toggled:bool):
	gamePaused = toggled

func speedScript(speed:int):
	gameSpeed = speed
