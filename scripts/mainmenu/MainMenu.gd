extends CanvasLayer

# Variables =======================================================================================
const plLevelTest:= preload("res://bhaygon/level1.tscn")
const plPlayer:= preload("res://bhaygon/player2.tscn")

@onready var anodeParentChildren: Array = self.get_parent().get_children() # Contains references to the children of Main.

@onready var nodeMain:= self.get_parent()

var nodeLevel = weakref(null)
var nodePlayer = weakref(null)



# General =========================================================================================

func _ready() -> void:
	globalMusic.Start_Music(globalMusic.dnodeMusic.nodeMusicMenu)
	Show_Menu()



# Show / Hide Menu ================================================================================

func Show_Menu() -> void:
	for node in anodeParentChildren:
		if node == self: node.show()
		elif node.has_method("hide"): node.hide()


func Hide_Menu() -> void:
	for node in anodeParentChildren:
		if node == self: node.hide()
		elif node.has_method("hide"): node.show()



# Signals =========================================================================================

func _on_button_play_pressed():
	# RESETTING TIMER / MUSIC
	globalScore.Reset_Timer()
	globalMusic.Start_Music(globalMusic.dnodeMusic.nodeMusicStealth)
	
	# LOAD LEVEL
	if nodeLevel.get_ref(): nodeLevel.get_ref().queue_free()
	nodeLevel = weakref(plLevelTest.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE) )
	nodeMain.add_child(nodeLevel.get_ref() )
	
	# LOAD PLAYER
	if nodePlayer.get_ref(): nodePlayer.get_ref().queue_free()
	nodePlayer = weakref(plPlayer.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE) )
	nodeMain.add_child(nodePlayer.get_ref() )
	
	# HIDE MENU
	Hide_Menu()


func _on_button_credits_pressed():
	pass


func _on_button_exit_pressed():
	get_tree().quit()
