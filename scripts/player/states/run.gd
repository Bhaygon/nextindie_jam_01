extends State

@export var fall_state: State
@export var jump_state: State
@export var idle_state: State

@export var slide_state: State
@export var attack_state: State
@export var special_state: State

func enter() -> void:
	super()

func process_physics(delta: float) -> State:
	#todo Slide
	if Input.is_action_just_pressed("slide"):
		return slide_state
	#todo Attack
	if Input.is_action_just_pressed("attack"):
		return attack_state
	#todo Special
	if Input.is_action_just_pressed("special"):
		return special_state
	# Move
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	if right: 
		parent.velocity.x = run_speed
		parent.sprite.flip_h = false
	if left:
		parent.velocity.x = -run_speed
		parent.sprite.flip_h = true
	if not right and not left:
		return idle_state;
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
		parent.coyote_timer.start() # Coyote timer only on the start of a fall
		return fall_state
	return null
