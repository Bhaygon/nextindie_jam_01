extends State

#? Entrada do state: Run && Botão Slide, manter direção do Run

# Iniciar com um impulso de X
# Continuar no state enquanto a velocidade for maior que a velocidade de corrida normal
# Retornar ao state Idle quando a velocidade for reduzida o suficiente

@export var slide_speed: float = 800
@export var min_speed: float = 100
var speed: float
var dir_right: bool

signal label_debug_text

@export var idle_state: State
@export var jump_state: State
@export var crouch_state: State

var tw: Tween

func enter() -> void:
	#print("slide")
	label_debug_text.emit("slide")
	# Can never change direction while sliding
	dir_right = parent.velocity.x > 0
	increase_speed()
	speed = slide_speed
	super()

func increase_speed():
	tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "speed", 0, 0.5)

func process_physics(delta: float) -> State:
	#todo Crouch
	if Input.is_action_just_pressed("crouch") and abs(parent.velocity.x) < run_speed * 2: # Cannot crouch if too fast
		tw.stop()
		return crouch_state
	# Move
	if dir_right: 
		parent.velocity.x = speed
	else:
		parent.velocity.x = -speed
	#! Verify if it is possible to get out of the slide state, if not, go to crouch state if speed is too low or do nothing if speed is still enough
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
	# Return to when too slow
	if abs(parent.velocity.x) < min_speed:
		tw.stop()
		return idle_state
	return null
