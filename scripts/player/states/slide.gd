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

func enter() -> void:
	label_debug_text.emit("slide")
	# Can never change direction while sliding
	dir_right = parent.velocity.x > 0
	increase_speed()
	speed = slide_speed
	super()

func increase_speed():
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "speed", 0, 0.5)

func process_physics(delta: float) -> State:
	# Move
	if dir_right: 
		parent.velocity.x = speed
	else:
		parent.velocity.x = -speed
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	# Return to when too slow
	if abs(parent.velocity.x) < min_speed:
		return idle_state
	return null
