extends State

@export var idle_state: State
@export var run_state: State
@export var slide_state: State
@export var jump_state: State

func enter() -> void:
    super()

func process_physics(delta: float) -> State:
    return idle_state

#! Verify if is possible to change colliders before doing so