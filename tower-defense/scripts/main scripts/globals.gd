extends Node

const game = preload("res://scenes/main scenes/game.tscn")
const display = preload("res://scenes/main scenes/display.tscn")
const menu = preload("res://scenes/main scenes/mainMenu.tscn")

signal healthUpdate(health)
signal mouseUpdate(type:bool)
signal gamePause(toggled:bool)
signal speedUpdate(speed:int)
signal noMoney()
signal buy()
signal selectedTowerUpdate()
signal moneyUpdate()

var money:int = 100:
	set(value):
		money = value
		moneyUpdate.emit()
		
var selectedTower:Node = null:
	set(value):
		selectedTower = value
		selectedTowerUpdate.emit()
var health = 100
var gamePaused = false
var gameSpeed = 1
var maxHealth = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gamePause.connect(pauseScript)
	speedUpdate.connect(speedScript)
	add_child(display.instantiate())

func pauseScript(toggled:bool):
	gamePaused = toggled

func speedScript(speed:int):
	gameSpeed = speed
