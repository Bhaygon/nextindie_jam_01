class_name State
extends Node

@export var animation_name: String

var run_speed: float = 200
var gravity: int = 1600

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

# super()
func enter() -> void:
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
