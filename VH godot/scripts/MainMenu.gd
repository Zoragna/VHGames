extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar" Menu

var options_enable=false
var btns
var current_focused_button
var down=false
var up=false


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	
	btns= {"Menu/Start":{
		"joy_down": "Menu/Options",
		"joy_up":"Menu/Quit" },
		"Menu/Options":{
		"joy_down":"Menu/Quit",
		"joy_up":"Menu/Start"}	,
		"Menu/Quit":{
		"joy_down":"Menu/Start",
		"joy_up":"Menu/Options"
		}
	}
	
	current_focused_button="Menu/Start"
	get_node(current_focused_button).grab_focus()
	get_node("Menu").visible=true
	get_node("Options menu").visible=false


func _on_Volume_changed():
	get_node("son").volume_db=get_node("Options menu/Volume").value



func _on_Start_pressed():
	get_tree().change_scene("res://scene/map.tscn")


func _on_Options_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_Retour_pressed():
	get_node("Options menu").visible=false
	get_node("Menu").visible=true



func _input(event):
	get_node(current_focused_button).grab_focus()
	if !down:
		if (Input.get_joy_axis(0, JOY_ANALOG_LY) >0.3 ) :
			get_node(btns[current_focused_button]["joy_down"]).grab_focus()
			current_focused_button=btns[current_focused_button]["joy_down"]
			down=true
	elif down:
		if not (Input.get_joy_axis(0, JOY_ANALOG_LY) >0.3):
			down=false
	
	if !up:
		if (Input.get_joy_axis(0, JOY_ANALOG_LY) < -0.3 ) :
			get_node(btns[current_focused_button]["joy_up"]).grab_focus()
			current_focused_button=btns[current_focused_button]["joy_up"]
			up=true
	elif up:
		if not (Input.get_joy_axis(0, JOY_ANALOG_LY) < -0.3 ) :
			up=false

