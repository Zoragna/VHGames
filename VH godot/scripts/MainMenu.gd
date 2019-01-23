extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar" Menu

var btns
var current_focused_button

const main_btns = {
	"Menu/Start":{
		"down": "Menu/Options",
		"up":"Menu/Quit" 
	},
	"Menu/Options":{
		"down":"Menu/Quit",
		"up":"Menu/Start"
	},
	"Menu/Quit":{
		"down":"Menu/Start",
		"up":"Menu/Options"
	}
}
	
const options_btns = {
	"Options menu/Volume":{
		"down":"Options menu/Retour",
		"up":"Options menu/Retour"
	},
	"Options menu/Retour":{
		"down":"Options menu/Volume",
		"up":"Options menu/Volume"
	}
}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	btns = main_btns
	current_focused_button="Menu/Start"
	get_node(current_focused_button).grab_focus()
	get_node("Menu").visible=true
	get_node("Options menu").visible=false


func _on_Volume_value_changed(value):
	get_node("son").volume_db= value-80

func _on_Start_pressed():
	get_tree().change_scene("res://scene/map.tscn")

func _on_Options_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = true
	current_focused_button="Options menu/Volume"
	get_node(current_focused_button).grab_focus()
	
	btns = options_btns

func _on_Quit_pressed():
	get_tree().quit()

func _on_Retour_pressed():
	get_node("Options menu").visible=false
	get_node("Menu").visible=true
	current_focused_button="Menu/Start"
	get_node(current_focused_button).grab_focus()
	
	btns= main_btns

func change_button(direction):
	print(direction)
	print(current_focused_button)
	print(btns)
	print(btns[current_focused_button])
	print(btns[current_focused_button][direction])
	current_focused_button = btns[current_focused_button][direction]
	get_node(current_focused_button).grab_focus()

func _input(event):
	#get_node(current_focused_button).grab_focus()
	if event is InputEventKey : #&& !event.is_echo() :
		if event.is_action_pressed("ui_down"):
			change_button("down")
		elif event.is_action_pressed("ui_up"):
			change_button("up")
	elif event is InputEventJoypadMotion :
		if get_node("Timer").is_stopped() :
			if get_node("Timer/TimerTimer").is_stopped() :
				if event.axis == JOY_AXIS_1 && event.axis_value > 0.3 :
					change_button("down")
					get_node("Timer").start()
				elif event.axis == JOY_AXIS_1 && event.axis_value < -0.3 :
					change_button("up")
					get_node("Timer").start()

func _on_Quit_focus_entered():
	pass # replace with function body


func _on_Quit_focus_exited():
	pass # replace with function body


func _on_Options_focus_exited():
	pass # replace with function body


func _on_Options_focus_entered():
	pass # replace with function body


func _on_Start_focus_entered():
	pass # replace with function body


func _on_Start_focus_exited():
	pass # replace with function body


func _on_Timer_timeout():
	get_node("Timer/TimerTimer").start()


func _on_TimerTimer_timeout():
	pass # replace with function body
