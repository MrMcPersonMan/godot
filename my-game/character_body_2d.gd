extends CharacterBody2D
const speed = 150
const acceleration = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		direction.y += -1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x += -1
	
	if direction.length() == 0:
		velocity *= 0.9
	velocity += direction.normalized() * 5
	if velocity.length() > speed:
		velocity = velocity.normalized() * speed
	move_and_slide()
