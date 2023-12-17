extends CharacterBody2D


# Destructible object that players must destroy to win.

# Varibles ========================================================================================
@onready var nodeAnimationPlayer:= $AnimationPlayer



# General =========================================================================================

func _ready() -> void:
	globalScore.anodeRemainingMcGuffins.append(self)
	nodeAnimationPlayer.play("Bobbing")



# Destroyed =======================================================================================

# Trigger this function when the player attacks the mcguffin. Use Area2D on layer 4 to detect it, its also in groupMcGuffin.

func Destroy() -> void:
	globalScore.McGuffin_Destroyed(self)
	queue_free()
