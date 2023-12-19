#? Entrada do state: Run, Idle, Slide

extends State

@export var idle_state: State
@export var run_state: State
@export var slide_state: State
@export var jump_state: State
@export var fall_state: State
signal label_debug_text

@export var speed_multiplier: float = 0.6

func enter() -> void:
    label_debug_text.emit("crouch")
    #print("crouch")
    parent.crouch_shape.disabled = false
    parent.standing_shape.disabled = true
    super()

func leave_crouch(new_state: State): #todo Switch hitboxes
    parent.crouch_shape.disabled = true
    parent.standing_shape.disabled = false
    label_debug_text.emit("leave crouch")
    return new_state

func can_leave_crouch() -> bool: #todo verify space for hitboxes
    return true

func process_physics(delta: float) -> State:
    # Move
    var right = Input.is_action_pressed("right")
    var left = Input.is_action_pressed("left")
    if right:
        parent.velocity.x = run_speed * speed_multiplier
        parent.sprite.flip_h = false
    if left:
        parent.velocity.x = -run_speed * speed_multiplier
        parent.sprite.flip_h = true
    # Animation
    if not right and not left:
        parent.animation_player.stop()
    else:
        parent.animation_player.play()
    # Leave crouch
    if Input.is_action_just_pressed("crouch") and (not right and not left) and can_leave_crouch():
        return leave_crouch(idle_state)
    # Jump
    if Input.is_action_just_pressed("jump"):
        parent.jump_buffer_timer.start()
        if parent.is_on_floor() and can_leave_crouch():
            return leave_crouch(jump_state)
    var jump = not parent.jump_buffer_timer.is_stopped()
    if jump and (parent.is_on_floor() or not parent.coyote_timer.is_stopped()) and can_leave_crouch():
        parent.jump_buffer_timer.stop()
        parent.coyote_timer.stop()
        return leave_crouch(jump_state)
    parent.velocity.y += gravity * delta
    parent.move_and_slide()
    # Slide
    if Input.is_action_just_pressed("slide") and can_leave_crouch():
        return leave_crouch(slide_state)
    # Fall
    if not parent.is_on_floor() and can_leave_crouch():
        parent.coyote_timer.start() # Coyote timer only on the start of a fall
        return leave_crouch(fall_state)
    return null