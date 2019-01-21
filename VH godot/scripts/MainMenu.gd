extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar" Menu

var options_enable=false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	get_node("Menu").visible=true
	get_node("Options menu").visible=false
	get_node("Lobby").visible = false


func _on_Volume_changed():
	get_node("son").volume_db=get_node("Options menu/Volume").value


func _on_Retour_pressed():
	get_node("Options menu").visible=false
	get_node("Lobby").visible = false
	get_node("Menu").visible=true


func _on_Start_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = false
	get_node("Lobby").visible = true


func _on_Options_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = true


func _on_Quit_pressed():
	get_tree().quit()