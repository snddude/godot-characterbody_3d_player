class_name Fall
extends PlayerState


func physics_update(delta: float) -> void:
	var direction: Vector3 = (player.neck.global_basis * player.wish_dir).normalized()
	var rate: float = player.air_accel_rate if direction.length() > 0.0 else player.air_decel_rate

	player.velocity.x = lerp(
			player.velocity.x,
			direction.x * player.walk_speed,
			1.0 - exp(-rate * delta)
	)
	player.velocity.z = lerp(
			player.velocity.z,
			direction.z * player.walk_speed,
			1.0 - exp(-rate * delta)
	)

	player.velocity.y += player.get_scaled_gravity().y * delta

	player.move_and_slide()

	if player.is_on_floor() and player.velocity.y <= 0.0:
		if player.get_platform_velocity().length() > 0.0: # This fixed weird sliding when landing
			player.velocity = Vector3.ZERO                # on a moving platform.

		finished.emit(IDLE)
