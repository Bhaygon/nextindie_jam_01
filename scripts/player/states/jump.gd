extends State

@export var fall_state: State
@export var idle_state: State
@export var run_state: State

@export var slam_state: State
@export var attack_state: State
@export var special_state: State

@export var jump_force: int = -300
@export var extra_gravity = 200

func enter() -> void:
    #print("jump")
    super()
    parent.velocity.y = jump_force

func process_physics(delta: float) -> State:
    #todo Slam
    if Input.is_action_just_pressed("slam"): #todo Also see distance from ground before using slam
        return slam_state
    #todo Attack
    if Input.is_action_just_pressed("attack"):
        return attack_state
    #todo Special
    if Input.is_action_just_pressed("special"):
        return special_state
    # Move
    var right = Input.is_action_pressed("right")
    var left = Input.is_action_pressed("left")
    parent.velocity.x = 0 # Remove to maintain velocity
    if parent.velocity.y > 0:
        return fall_state
    if right: 
        parent.velocity.x = run_speed
        parent.sprite.flip_h = false
    if left:
        parent.velocity.x = -run_speed
        parent.sprite.flip_h = true
    # Gravity
    var extra = 0
    if not Input.is_action_pressed("jump"):
        extra = extra_gravity
    parent.velocity.y += (gravity + extra) * delta
    parent.move_and_slide()
    # Floor
    if parent.is_on_floor():
        if right or left:
            return run_state
        return idle_state
    return null