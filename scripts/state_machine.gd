extends Node

class_name CharacterStateMachine

@export var current_state : State
@export var player : CharacterBody2D

var states : Array[State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
			# REFERENCES THE PLAYER THRU EVERY STATE
			child.player = player
		else: 
			push_warning("Child '" + child.name + "' is not of the type State! Silly...")
	

func _physics_process(delta: float) -> void:
	if current_state.next_state != null and current_state.next_state != current_state:
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func can_move_check():
	return current_state.can_move
func can_flip_check():
	return current_state.can_flip
func can_jump_check():
	return current_state.can_jump
func can_sneak_check():
	return current_state.can_sneak

func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent) -> void:
	current_state.state_input(event) 
