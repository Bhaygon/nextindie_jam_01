extends CanvasLayer

# Variables =======================================================================================
@onready var anodeParentChildren: Array = self.get_parent().get_children() # Contains references to the children of Main.



# General =========================================================================================

func _ready() -> void:
	Show_Menu()



# Show / Hide Menu ================================================================================

func Show_Menu() -> void:
	for node in anodeParentChildren:
		if node == self: node.show()
		else: node.hide()


func Hide_Menu() -> void:
	for node in anodeParentChildren:
		if node == self: node.hide()
		else: node.show()



# Signals =========================================================================================

func _on_button_play_pressed():
	Hide_Menu()


func _on_button_credits_pressed():
	pass


func _on_button_exit_pressed():
	get_tree().quit()
