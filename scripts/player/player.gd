class_name Player

extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var sprite = $Sprite2D
@onready var raycast_on_feet = $RayCast2D

func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
