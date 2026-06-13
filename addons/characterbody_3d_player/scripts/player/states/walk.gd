class_name Walk
extends PlayerState

@export_group("States")
@export var idle_state: Idle
@export var fall_state: Fall


func physics_update(delta: float) -> PlayerState:
	var direction: Vector3 = (player.neck.global_basis * player.wish_dir).normalized()

	player.velocity.x = lerp(
			player.velocity.x, 
			direction.x * player.walk_speed, 
			1.0 - exp(-player.floor_accel_rate * delta)
	)
	player.velocity.z = lerp(
			player.velocity.z, 
			direction.z * player.walk_speed, 
			1.0 - exp(-player.floor_accel_rate * delta)
	)

	player.move_and_slide()

	if player.wish_dir.length() == 0.0:
		return idle_state
	elif not player.is_on_floor():
		return fall_state
	elif Input.is_action_just_pressed("jump"):
		player.velocity.y = player.get_jump_velocity()
		return fall_state
	else:
		return null
