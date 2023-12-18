extends VBoxContainer

# Variables =======================================================================================
const sChaoTimer: String = "Chaos Timer: %s"
const sMcGuffin: String = "Destroyed: %s / %s"

@onready var nodeLabelChaosTimer := $ChaosTimer
@onready var nodeLabelMcGuffin := $McGuffinCounter



# General =========================================================================================

func _process(_delta):
	nodeLabelChaosTimer.set_text(sChaoTimer % int(globalScore.fChaosTimer) )
	nodeLabelMcGuffin.set_text(sMcGuffin % [globalScore.anodeRemainingMcGuffins.size(), globalScore.nTotalMcGuffins])
