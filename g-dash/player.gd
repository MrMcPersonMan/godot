extends CharacterBody2D

const cameraMin = 312
const SPEED = 300.0
const JUMP_VELOCITY = -1257.24444
var  startingPos = 0
var cameraPos = 0
var mode = 1
var worldGrav = 1
var modeGrav = 1
const trail = preload("res://trail.tscn")
var t = null
var line = null

func _ready() -> void:
	startingPos = position
	cameraPos = $Camera2D.global_position.y
	$AnimatedSprite2D.frame = mode - 1
	if mode == 5:
		t = trail.instantiate()
		line = t.get_node("Line2D")
		add_child(t)
	
func _physics_process(delta: float) -> void:
	
	get_node("/root/Node2D/StaticBody2D").position.x = position.x
	velocity.x = 10.4 * 64 
	
	velocity += get_gravity() * delta * worldGrav * modeGrav

	if mode == 1:
		if not is_on_floor():
			$CPUParticles2D.speed_scale = 0
			$AnimatedSprite2D.rotation += delta * 9
		else:
			$CPUParticles2D.speed_scale = 1
			$AnimatedSprite2D.rotation = round($AnimatedSprite2D.rotation * 4 / TAU)* TAU * 0.25
			
		if Input.is_action_pressed("click") and touchingGround():
			velocity.y = JUMP_VELOCITY
	
		
	if  mode == 2:
		$AnimatedSprite2D.rotation = atan(velocity.y/velocity.x)
		if Input.is_action_pressed("click"):
			modeGrav = -0.3
		else:
			modeGrav = 0.3
	
	if  mode == 3:
		if Input.is_action_just_pressed("click"):
			velocity.y = JUMP_VELOCITY
		
	if mode == 4:
		$AnimatedSprite2D.rotation += delta * 4 * modeGrav * worldGrav
		if Input.is_action_just_pressed("click") and touchingGround():
			modeGrav *= -1
		
	
	if mode == 5:
		$AnimatedSprite2D.rotation = atan(velocity.y/velocity.x)
		line.set_point_position(line.get_point_count()-1,position)
		if Input.is_action_just_pressed("click") or Input.is_action_just_released("click"):
			line.add_point(position)
		if Input.is_action_pressed("click"):
			modeGrav = -1
		else:
			modeGrav = 1
		velocity.y = velocity.x * modeGrav * worldGrav
	
	if mode == 6:
		$AnimatedSprite2D.rotation = atan(velocity.y/velocity.x)
		if Input.is_action_just_pressed("click"):
			modeGrav *= -1
			
	if mode == 7:
		if Input.is_action_just_pressed("click") and touchingGround():
			print("===========")
			modeGrav *= -1
			move_and_collide(Vector2(0,10000*modeGrav))
			

	move_and_slide()
	
	if is_on_wall() or (mode == 5 and touchingGround()):
		if mode == 5:
			t.queue_free()
			t = trail.instantiate()
			line = t.get_node("Line2D")
			add_child(t)
		position = startingPos
		velocity = Vector2.ZERO
		worldGrav = 1
		modeGrav = 1
		
	updateCamera()
	
	
	
func updateCamera():
	$Camera2D.global_position.y = cameraPos
	if $Camera2D.position.y > 100:
		$Camera2D.position.y += (90 - $Camera2D.position.y)/10
		print((90-$Camera2D.position.y))
		cameraPos = $Camera2D.global_position.y
		
	elif $Camera2D.position.y < -100:
		$Camera2D.position.y += (-90 - $Camera2D.position.y)/10
		print((-90 - $Camera2D.position.y))
		cameraPos = $Camera2D.global_position.y

func touchingGround():
	if modeGrav*worldGrav == 1:
		return is_on_floor()
	else:
		return is_on_ceiling()
	

	





func _on_color_picker_button_color_changed(color: Color, source: ColorPickerButton) -> void:
	$CPUParticles2D.color = source.color
