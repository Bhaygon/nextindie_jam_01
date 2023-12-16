extends Node

class_name State

@export var can_move : bool = true
@export var can_sneak : bool = true
@export var can_jump : bool = true
@export var can_flip : bool = true
@export var jump_velocity : float = -300.0

var player : CharacterBody2D
var next_state : State
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass
	
func on_exit():
	pass
