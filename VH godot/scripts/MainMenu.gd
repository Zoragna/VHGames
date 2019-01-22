extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar" Menu

var options_enable=false
var btns
var current_focused_button
var down=false
var up=false
var right=false
var left=false


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	
	btns= {"Menu/Start":{
		"joy_down": "Menu/Options",
		"joy_up":"Menu/Quit",
		"joy_right": "Menu/Start",
		"joy_left": "Menu/Start" },
		"Menu/Options":{
		"joy_down":"Menu/Quit",
		"joy_up":"Menu/Start",
		"joy_right": "Menu/Options",
		"joy_left": "Menu/Options"}	,
		"Menu/Quit":{
		"joy_down":"Menu/Start",
		"joy_up":"Menu/Options",
		"joy_right": "Menu/Quit",
		"joy_left": "Menu/Quit"}
	}
	
	
	current_focused_button="Menu/Start"
	get_node(current_focused_button).grab_focus()
	get_node("Menu").visible=true
	get_node("Options menu").visible=false


func _on_Volume_value_changed(value):
	get_node("son").volume_db= value-24



func _on_Start_pressed():
	get_tree().change_scene("res://scene/map.tscn")


func _on_Options_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = true
	current_focused_button="Options menu/Volume"
	get_node(current_focused_button).grab_focus()
	
	btns={"Options menu/Volume":{
		"joy_down":"Options menu/Retour",
		"joy_up":"Options menu/Retour",
		"joy_right": "Options menu/Volume",
		"joy_left": "Options menu/Volume"},
		"Options menu/Retour":{
		"joy_down":"Options menu/Volume",
		"joy_up":"Options menu/Volume",
		"joy_right": "Options menu/Retour",
		"joy_left": "Options menu/Retour"}
		}


func _on_Quit_pressed():
	get_tree().quit()


func _on_Retour_pressed():
	get_node("Options menu").visible=false
	get_node("Menu").visible=true
	current_focused_button="Menu/Start"
	get_node(current_focused_button).grab_focus()
	
	btns= {"Menu/Start":{
		"joy_down": "Menu/Options",
		"joy_up":"Menu/Quit",
		"joy_right": "Menu/Start",
		"joy_left": "Menu/Start" },
		"Menu/Options":{
		"joy_down":"Menu/Quit",
		"joy_up":"Menu/Start",
		"joy_right": "Menu/Options",
		"joy_left": "Menu/Options"}	,
		"Menu/Quit":{
		"joy_down":"Menu/Start",
		"joy_up":"Menu/Options",
		"joy_right": "Menu/Quit",
		"joy_left": "Menu/Quit"}
	}




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
	
	if !right:
		if (Input.get_joy_axis(0, JOY_ANALOG_LX) < -0.3 ) :
			get_node(btns[current_focused_button]["joy_right"]).grab_focus()
			current_focused_button=btns[current_focused_button]["joy_right"]
			right=true
	elif right:
		if not (Input.get_joy_axis(0, JOY_ANALOG_LX) < -0.3 ) :
			right=false
	
	if !left:
		if (Input.get_joy_axis(0, JOY_ANALOG_LX) < 0.3 ) :
			get_node(btns[current_focused_button]["joy_left"]).grab_focus()
			current_focused_button=btns[current_focused_button]["joy_left"]
			left=true
	elif left:
		if not (Input.get_joy_axis(0, JOY_ANALOG_LX) < 0.3 ) :
			left=false



