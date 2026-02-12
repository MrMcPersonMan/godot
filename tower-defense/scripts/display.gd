extends Control
var selcted = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.buy.connect(_on_cancel)
	global.healthUpdate.connect(healthbar)
	global.moneyUpdate.connect(updateMoney)
	for button in $Panel/VBoxContainer/ScrollContainer/HBoxContainer.get_children():
		button.toggled.connect(_on_button_toggled.bind(button))






func _on_button_toggled(toggled_on: bool, source: BaseButton) -> void:
	if toggled_on:
		$Panel/VBoxContainer/cancel.disabled = false
		for item in $Panel/VBoxContainer/ScrollContainer/HBoxContainer.get_children():
			item.set_pressed_no_signal(false)
		global.selectedTower = source
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
	$Panel/VBoxContainer/Panel2/ProgressBar.value = health
	$Panel/VBoxContainer/Panel2/Label.text = str(health)+"/"+str(global.maxHealth)


func _on_cancel() -> void:
	for item in $Panel/VBoxContainer/ScrollContainer/HBoxContainer.get_children():
		item.set_pressed_no_signal(false)
	global.selectedTower = null
	$Panel/VBoxContainer/cancel.disabled = true

func updateMoney():
	
	$Panel/VBoxContainer/Panel/HBoxContainer/money.text = str(global.money)
