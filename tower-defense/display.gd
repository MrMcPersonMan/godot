extends Control
var selcted = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.healthUpdate.connect(healthbar)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_toggled(toggled_on: bool, source: BaseButton) -> void:
	if toggled_on:
		for item in $Panel/VBoxContainer/ScrollContainer/HBoxContainer.get_children():
			item.set_pressed_no_signal(false)
		source.set_pressed_no_signal(true)
	else:
		source.set_pressed_no_signal(true)

	


func _on_mouse_changed(extra_arg_0: bool) -> void:
	global.mouseUpdate.emit(extra_arg_0)


func _on_pause(toggled_on: bool) -> void:
	global.gamePause.emit(toggled_on)


func _on_x2speed_toggled(toggled_on: bool) -> void:
	if toggled_on:
		global.speedUpdate.emit(2)
	else:
		global.speedUpdate.emit(1)
		
func healthbar(health):
	$Panel/VBoxContainer/Control/ProgressBar.value = health
	$Panel/VBoxContainer/Control/Label.text = str(health)+"/"+str(global.maxHealth)
