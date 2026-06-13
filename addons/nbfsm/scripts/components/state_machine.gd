class_name StateMachine
extends Node

signal state_changed(new_state: State)

@export var initial_state: State

var current_state: State = null


func _ready() -> void:
	current_state = initial_state

	if owner != null:
		await owner.ready

	current_state.enter()


func _input(event: InputEvent) -> void:
	_process_state(current_state.input_update.bind(event))


func _unhandled_input(event: InputEvent) -> void:
	_process_state(current_state.unhandled_input_update.bind(event))


func _process(delta: float) -> void:
	_process_state(current_state.update.bind(delta))


func _physics_process(delta: float) -> void:
	_process_state(current_state.physics_update.bind(delta))


func change_state(new_state: State) -> void:
	if new_state == current_state:
		return

	current_state.exit()
	current_state = new_state
	current_state.enter()

	state_changed.emit(new_state)


func _process_state(state_function: Callable) -> void:
	var new_state: State = state_function.call()

	if new_state != null:
		change_state(new_state)
