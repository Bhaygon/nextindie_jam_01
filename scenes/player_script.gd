extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $StateMachine

@export var move_spd : float = 200.0
@export var sneak_spd : float = 140.0

var direction : Vector2 = Vector2.ZERO
var flip = 0

func _physics_process(delta):
	# MOVEMENT
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x != 0 and state_machine.can_move_check():
		if direction.x != flip:
			velocity.x = direction.x * (move_spd * 0.65)
		else:
			velocity.x = direction.x * move_spd
	else:
		velocity.x = move_toward(velocity.x, 0, move_spd)
	move_and_slide()
	update_facing_direction()

#region FUNCTIONS
func update_facing_direction():
	if state_machine.can_flip_check():
		if direction.x > 0:
			sprite_2d.flip_h = false
			flip = 1
		elif direction.x < 0:
			sprite_2d.flip_h = true
			flip = -1
func land():
	pass
#endregion
