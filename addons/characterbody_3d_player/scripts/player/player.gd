class_name Player
extends CharacterBody3D

@export_group("Camera")
@export var sensitivity: float
@export_group("Movement")
@export var walk_speed: float
@export var gravity_scale: float = 1.0
@export var jump_height: float
@export_subgroup("Acceleration")
@export var floor_accel_rate: float
@export var floor_decel_rate: float
@export var air_accel_rate: float
@export var air_decel_rate: float
@export_group("Nodes")
@export var neck: Node3D
@export var head: Node3D

var wish_dir := Vector3.ZERO


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		neck.rotation_degrees.y -= deg_to_rad(event.relative.x * sensitivity)
		head.rotation_degrees.x -= deg_to_rad(event.relative.y * sensitivity)
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90.0, 90.0)


func _process(_delta: float) -> void:
	wish_dir = Vector3(Input.get_axis("left", "right"), 0.0, Input.get_axis("forward", "back"))


func get_scaled_gravity() -> Vector3:
	return get_gravity() * gravity_scale
