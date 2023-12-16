extends State

#? Entrada do state: Run || Idle || Jump || Fall && Botão Special

# Reduzir movimentação para 0
# Manter o state até o fim do ataque
# Ignorar qualquer dano

signal label_debug_text

@export var idle_state: State

func enter() -> void:
    label_debug_text.emit("special")
    super()

func process_physics(delta: float) -> State:
    return idle_state