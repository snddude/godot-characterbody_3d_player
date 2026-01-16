class_name Player
extends CharacterBody3D

@export_group("Camera")
@export var sensitivity: float
@export_group("Movement")
@export var walk_speed: float
@export var jump_height: float
@export_subgroup("Acceleration")
@export var floor_accel_rate: float
@export var floor_decel_rate: float
@export var air_accel_rate: float
@export var air_decel_rate: float
@export_group("Nodes")
@export var neck: Node3D

var wish_dir := Vector3.ZERO

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _process(_delta: float) -> void:
	wish_dir = Vector3(Input.get_axis("left", "right"), 0.0, Input.get_axis("forward", "back"))
