@abstract
class_name State
extends Node


func enter() -> void:
	pass


@warning_ignore("unused_parameter")
func input_update(event: InputEvent) -> State:
	return null


@warning_ignore("unused_parameter")
func unhandled_input_update(event: InputEvent) -> State:
	return null


@warning_ignore("unused_parameter")
func update(delta: float) -> State:
	return null


@warning_ignore("unused_parameter")
func physics_update(delta: float) -> State:
	return null


func exit() -> void:
	pass
