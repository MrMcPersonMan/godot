@tool
extends "res://scripts/towers/tower.gd"

var NewTargetedMirror = null
var TargetedMirror = null
var state = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#setUpArea()
	#setUpArea()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	calculateState()
	if state == null:
		$Line2D.visible = false
		$CPUParticles2D.emitting = false
		return
		
	if state == "enemy":
		laserAttack(targeted,$Line2D,$CPUParticles2D)
		targeted.damage(damage * _delta,false)
		return
	
	if state == "relay":
		laserAttack(TargetedMirror,$Line2D,$CPUParticles2D)
		return
	
	
	
func calculateState():
	targeted = calculateTarget($Area2D)
	if targeted:
		setState("enemy")
		return
	
	var mirrors = $mirrorArea.get_overlapping_areas()
	
	if len(mirrors) == 0:
		setState(null)
	
	NewTargetedMirror = null
	for mirror in mirrors:
		if mirror.get_parent().targeted:
			NewTargetedMirror = mirror.get_parent()
			break
	
	if not NewTargetedMirror:
		setState(null)
		return
	
	if NewTargetedMirror == TargetedMirror:
		setState("relay")
		return
	
	if state != "relay":
		TargetedMirror = NewTargetedMirror
		setState("relay")
		return
		
	updateMirror(TargetedMirror,NewTargetedMirror)
	TargetedMirror = NewTargetedMirror
	

func setState(newState):
	if newState == state:
		return
	
	if newState == "relay":
		state = "relay"
		updateMirror(null,TargetedMirror)
		return
	
	if state == "relay":
		updateMirror(TargetedMirror,null)
	
	state = newState

func updateMirror(old = null,new = null):

	if new:
		new.addUser(self)
	if old:
		old.removeUser(self)
