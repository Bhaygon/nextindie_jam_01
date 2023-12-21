extends State

@export var fall_state: State
@export var jump_state: State
@export var run_state: State

@export var attack_state: State
@export var special_state: State
@export var crouch_state: State

func enter() -> void:
	#print("idle")
	super()
	parent.velocity.x = 0

func process_physics(delta: float) -> State:
	#todo Crouch
	if Input.is_action_just_pressed("crouch"):
		return crouch_state
	#todo Attack
	if Input.is_action_just_pressed("attack"):
		return attack_state
	#todo Special
	if Input.is_action_just_pressed("special"):
		return special_state
	# Move
	if Input.is_action_pressed('left') or Input.is_action_pressed('right'):
		return run_state
	# Jump
	if Input.is_action_just_pressed("jump"):
		parent.jump_buffer_timer.start()
		if parent.is_on_floor():
			return jump_state
	var jump = not parent.jump_buffer_timer.is_stopped()
	if jump and (parent.is_on_floor() or not parent.coyote_timer.is_stopped()):
		parent.jump_buffer_timer.stop()
		parent.coyote_timer.stop()
		return jump_state
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	# Fall
	if not parent.is_on_floor():
		return fall_state
	return null
