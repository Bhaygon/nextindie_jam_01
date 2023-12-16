extends State

class_name AirState

@export var ground_state : State

func state_process(delta):
	if player.is_on_floor():
		next_state = ground_state
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
