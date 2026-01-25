extends CharacterBody2D
const speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node("/root/main/player")
	$RayCast2D.add_exception(player)
	$RayCast2D2.add_exception(player)
	$RayCast2D3.add_exception(player)
	$RayCast2D4.add_exception(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_node("/root/main/player")
	
	$RayCast2D.target_position = player.position + Vector2(40,0)
	$RayCast2D2.target_position = player.position + Vector2(-40,0)
	$RayCast2D3.target_position = player.position + Vector2(0,40)
	$RayCast2D4.target_position = player.position + Vector2(0,-40)
	
	var see = not($RayCast2D.is_colliding() and $RayCast2D2.is_colliding() and $RayCast2D3.is_colliding() 
	and $RayCast2D4.is_colliding())
	
	if see:
		var path = player.position - position
		velocity = path.normalized() * speed
		move_and_slide()
	
