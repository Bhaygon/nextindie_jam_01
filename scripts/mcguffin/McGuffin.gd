class_name McGuffin
extends StaticBody2D


# Destructible object that players must destroy to win.

# Variables =======================================================================================
var nodeSpriteDestroyed = null
var nodeSpriteIntact = null



# General =========================================================================================

func _ready() -> void:
	# GETTING SPRITES
	for node in self.get_children():
		if node.name == "SpriteDestroyed": nodeSpriteDestroyed = node
		elif node.name == "SpriteIntact": nodeSpriteIntact = node
	if ! nodeSpriteDestroyed || ! nodeSpriteIntact:
		push_error("ERROR: McGuffin '%s' lacks either a destroyed or an intact sprite, or both. It may be misnamed." % self.name)
		# should be named "spriteDestroyed" and "spriteIntact" exactly
		self.queue_free()
	
	# SETTING SPRITE VISIBILITY
	if nodeSpriteDestroyed && nodeSpriteIntact: 
		nodeSpriteDestroyed.hide()
		nodeSpriteIntact.show()
	
	# ADDING TO globalScore
		globalScore.anodeRemainingMcGuffins.append(self)
		globalScore.nTotalMcGuffins += 1
	
	# ADDING TO GROUPS / SETTING COLLISION LAYERS
		self.add_to_group("groupMcGuffin")
		self.set_collision_layer_value(4, true)
		self.set_collision_mask_value(4, true)



# Destroyed =======================================================================================

# Trigger this function when the player attacks the mcguffin. Use Area2D on layer 4 to detect it, its also in groupMcGuffin.

func Destroy() -> void:
	nodeSpriteDestroyed.show()
	nodeSpriteIntact.hide()
	globalScore.McGuffin_Destroyed(self)
