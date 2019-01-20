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

func _process(delta):
	if options_enable==true :
		get_node("Options menu").visible=true
		get_node("Menu").visible=false
	else :
		get_node("Menu").visible=true
		get_node("Options menu").visible=false



func _on_Quit_button_down():
	get_tree().quit()


func _on_Start_button_down():
	get_tree().change_scene("res://scene/map.tscn")



func _on_Options_button_down():
	options_enable=true



func _on_Retour_button_down():
	options_enable=false


func _on_Volume_changed():
	get_node("son").volume_db=get_node("Options menu/Volume").value
