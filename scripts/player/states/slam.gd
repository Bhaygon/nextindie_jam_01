extends State

#? Entrada do state: (Jump || Fall) && Botão Slam && Distancia do chão > X

# Manter o state enquanto o jogador estiver no ar
# Ao encostar no chão (is_on_floor) executar a o ataque
# Ao finalizar a animação, retornar para Idle
#! VERIFICAR SE HÁ INIMIGOS ABAIXO ANTES DE USAR SLAM

signal label_debug_text

@export var idle_state: State
@export var slam_force: int = 8000
var slam_gravity: int

var landing: bool
var landed: bool

var tw: Tween

func enter() -> void:
	label_debug_text.emit("slam")
	parent.velocity.x = 0
	landing = false
	landed = false
	increase_speed()
	super()

func increase_speed():
	slam_gravity = 0
	tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUINT)
	tw.tween_property(self, "slam_gravity", gravity + slam_force, 0.1)

func land():
	landing = true
	#! RAYCAST CONDITION GO HERE
	parent.animation_player.play("slam_end")
	await parent.animation_player.animation_finished
	landed = true

func process_physics(delta: float) -> State:
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
	# Gravity
	parent.velocity.y += slam_gravity * delta
	parent.move_and_slide()
	# Retorna ao cair
	if (parent.is_on_floor() and not landing):
		land()
	if landed:
		tw.stop()
		return idle_state
	return null
