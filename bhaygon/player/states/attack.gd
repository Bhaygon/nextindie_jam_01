extends State

#? Entrada do state: Run || Idle || Jump || Fall && Botão ataque

# Reduzir movimentação para 0
# Manter o state enquanto o jogador não receber dano
# Caso o jogador receba dano, retorna a Idle
# Caso o jogador não receba dano, retorna ao state Idle ao fim do ataque

signal label_debug_text

@export var idle_state: State

func enter() -> void:
	#print("attack")
	parent.velocity.x = 0
	parent.velocity.y = 0
	label_debug_text.emit("attack")
	super()

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return idle_state
