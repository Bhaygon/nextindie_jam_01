class_name Player

extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var sprite = $Sprite2D
@onready var crouch_shape = $CrouchShape
@onready var standing_shape = $StandingShape

# Raycasts / Areas
@onready var slam_area = $SlamArea

@onready var crouch_raycast1 = $CrouchRaycast1
@onready var crouch_raycast2 = $CrouchRaycast2
@onready var crouch_raycast3 = $CrouchRaycast3
@onready var down_distance_raycast = $DownDistanceRaycast

func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
