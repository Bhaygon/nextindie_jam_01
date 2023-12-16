extends State

class_name GroundState
@export var air_state : State

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
		
func jump():
	player.velocity.y =  jump_velocity
	next_state = air_state
func state_process(delta):
	if not player.is_on_floor():
		player.velocity.y += gravity * delta

