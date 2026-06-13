class_name Idle
extends PlayerState

@export_group("States")
@export var walk_state: Walk
@export var fall_state: Fall


func physics_update(delta: float) -> PlayerState:
	player.velocity = lerp(
			player.velocity, 
			Vector3.ZERO, 
			1.0 - exp(-player.floor_decel_rate * delta)
	)

	player.move_and_slide()

	if player.wish_dir.length() > 0.0:
		return walk_state
	elif not player.is_on_floor():
		return fall_state
	elif Input.is_action_just_pressed("jump"):
		player.velocity.y = player.get_jump_velocity()
		return fall_state
	else:
		return null
