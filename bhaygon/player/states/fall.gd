extends State

@export var idle_state: State
@export var run_state: State
@export var jump_state: State

@export var slam_state: State
#@export var attack_state: State
#@export var special_state: State

@export var extra_gravity = 300

func enter() -> void:
	#print("fall")
	super()

func process_physics(delta: float) -> State:
	#todo Slam
	if Input.is_action_just_pressed("slam") and not parent.down_distance_raycast.is_colliding():
		return slam_state
	#todo Attack
	#if Input.is_action_just_pressed("attack"):
	#    return attack_state
	#todo Special
	#if Input.is_action_just_pressed("special"):
	#    return special_state
	# Move
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	parent.velocity.x = 0 # Remove to maintain velocity
	if right: 
		parent.velocity.x = run_speed
		parent.sprite.flip_h = false
	if left:
		parent.velocity.x = -run_speed
		parent.sprite.flip_h = true
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
	# Gravity
	parent.velocity.y += (gravity + extra_gravity) * delta
	parent.move_and_slide()
	# Floor
	if parent.is_on_floor():
		# destroying mcguffins
		for node in parent.slam_area.get_overlapping_bodies():
			if node.get_groups().has("groupMcGuffin"):
				node.Destroy()
		if right or left:
			return run_state
		return idle_state
	return null
