extends Node

const game = preload("res://scenes/main scenes/game.tscn")
const display = preload("res://scenes/main scenes/display.tscn")
const menu = preload("res://scenes/main scenes/mainMenu.tscn")


signal mouseUpdate(type:bool)
signal noMoney()
signal buy()
signal levelComplete(type:int)

signal moneyUpdate()
var money:int = 100:
	set(value):
		money = value
		moneyUpdate.emit(money)

signal selectedTowerUpdate()
var selectedTower:Node = null:
	set(value):
		selectedTower = value
		selectedTowerUpdate.emit(selectedTower)
		
var maxHealth = 50

signal healthUpdate(health)
var health = maxHealth:
	set(value):
		if value <= 0:
			health = 0
			levelComplete.emit(-1)
		else:
			health = value
		healthUpdate.emit(health)

signal gamePause(toggled:bool)
var gamePaused = false:
	set(value):
		gamePaused = value
		gamePause.emit(gamePaused)

signal speedUpdate(speed:int)
var gameSpeed = 1:
	set(value):
		speedUpdate.emit(value)
		gameSpeed = value

@export var enemyColours:Array[Color] = [Color.BURLYWOOD,Color.DARK_GREEN,Color.GOLD]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(display.instantiate())
