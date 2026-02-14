extends Node2D

var subwaveNode = null
var waveNode = null
var spawners = []
var numWaves = null
var numSubWaves = null

var wave = -1:
	set(value):
		wave = value
		if wave == numWaves:
			global.levelComplete.emit(1)
			return
		waveNode = get_child(0).get_node("waves").get_child(wave)
		numSubWaves = len(waveNode.get_children())
		subwave = 0
	
var subwave = -1:
	set(value):
		subwave = value
		if subwave == numSubWaves:
			wave += 1
			return
		
		subwaveNode = waveNode.get_child(subwave)
		spawners = subwaveNode.get_children()
		for item in spawners:
			item.start()
			item.done.connect(nodeDone)

func nodeDone(node):
	spawners.erase(node)
	if len(spawners) == 0:
		subwave += 1
	
func startLevel():
	wave = 0
	numWaves = len(get_child(0).get_node("waves").get_children())

func _ready() -> void:
	startLevel()
