extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar" Menu

var btns
var current_focused_button

var current_panel

const main_btns = {
	"Menu/Smash":{
		"down": "Menu/Start",
		"up":"Menu/Quit" 
	},
	"Menu/Start":{
		"down": "Menu/Options",
		"up":"Menu/Smash" 
	},
	"Menu/Options":{
		"down":"Menu/Quit",
		"up":"Menu/Start"
	},
	"Menu/Quit":{
		"down":"Menu/Smash",
		"up":"Menu/Options"
	}
}
	
const options_btns = {
	"Options menu/Volume Musique":{
		"down":"Options menu/Volume Effets",
		"up":"Options menu/Retour"
	},
	"Options menu/Volume Effets":{
		"down":"Options menu/Commandes",
		"up":"Options menu/Volume Musique"
	},
	"Options menu/Commandes":{
		"down":"Options menu/Retour",
		"up":"Options menu/Volume Effets"
	},
	"Options menu/Retour":{
		"down":"Options menu/Volume Musique",
		"up":"Options menu/Commandes"
	}
}

const controls_btns = {
	"controls_ui/Node/bindings/ui_up/Button":{
		"down":"controls_ui/Node/bindings/ui_down/Button",
		"up":"controls_ui/Node/bindings/grab/Button",
		"right":"controls_ui/Node/bindings/cstick_up/Button",
		"left":"controls_ui/Node/bindings/cstick_up/Button"
	},
	"controls_ui/Node/bindings/ui_down/Button":{
		"down":"controls_ui/Node/bindings/ui_left/Button",
		"up":"controls_ui/Node/bindings/ui_up/Button",
		"right":"controls_ui/Node/bindings/cstick_down/Button",
		"left":"controls_ui/Node/bindings/cstick_down/Button"
	},
	"controls_ui/Node/bindings/ui_left/Button":{
		"down":"controls_ui/Node/bindings/ui_right/Button",
		"up":"controls_ui/Node/bindings/ui_down/Button",
		"right":"controls_ui/Node/bindings/cstick_left/Button",
		"left":"controls_ui/Node/bindings/cstick_left/Button"
	},
	"controls_ui/Node/bindings/ui_right/Button":{
		"down":"controls_ui/Node/bindings/jump/Button",
		"up":"controls_ui/Node/bindings/ui_left/Button",
		"right":"controls_ui/Node/bindings/cstick_right/Button",
		"left":"controls_ui/Node/bindings/cstick_right/Button"
	},
	"controls_ui/Node/bindings/jump/Button":{
		"down":"controls_ui/Node/bindings/shield/Button",
		"up":"controls_ui/Node/bindings/ui_right/Button",
		"right":"controls_ui/Node/bindings/Retour_b",
		"left":"controls_ui/Node/bindings/Retour_b"
	},
	"controls_ui/Node/bindings/shield/Button":{
		"down":"controls_ui/Node/bindings/attack/Button",
		"up":"controls_ui/Node/bindings/jump/Button",
		"right":"controls_ui/Node/bindings/Retour_b",
		"left":"controls_ui/Node/bindings/Retour_b"
	},
	"controls_ui/Node/bindings/attack/Button":{
		"down":"controls_ui/Node/bindings/special/Button",
		"up":"controls_ui/Node/bindings/shield/Button",
		"right":"controls_ui/Node/bindings/Retour_b",
		"left":"controls_ui/Node/bindings/Retour_b"
	},
	"controls_ui/Node/bindings/special/Button":{
		"down":"controls_ui/Node/bindings/grab/Button",
		"up":"controls_ui/Node/bindings/attack/Button",
		"right":"controls_ui/Node/bindings/Retour_b",
		"left":"controls_ui/Node/bindings/Retour_b"
	},
	"controls_ui/Node/bindings/grab/Button":{
		"down":"controls_ui/Node/bindings/ui_up/Button",
		"up":"controls_ui/Node/bindings/special/Button",
		"right":"controls_ui/Node/bindings/Retour_b",
		"left":"controls_ui/Node/bindings/Retour_b"
	},
	"controls_ui/Node/bindings/cstick_up/Button":{
		"down":"controls_ui/Node/bindings/cstick_down/Button",
		"up":"controls_ui/Node/bindings/Retour_b",
		"right":"controls_ui/Node/bindings/ui_up/Button",
		"left":"controls_ui/Node/bindings/ui_up/Button"
	},
	"controls_ui/Node/bindings/cstick_down/Button":{
		"down":"controls_ui/Node/bindings/cstick_left/Button",
		"up":"controls_ui/Node/bindings/cstick_up/Button",
		"right":"controls_ui/Node/bindings/ui_down/Button",
		"left":"controls_ui/Node/bindings/ui_down/Button"
	},
	"controls_ui/Node/bindings/cstick_left/Button":{
		"down":"controls_ui/Node/bindings/cstick_right/Button",
		"up":"controls_ui/Node/bindings/cstick_down/Button",
		"right":"controls_ui/Node/bindings/ui_left/Button",
		"left":"controls_ui/Node/bindings/ui_left/Button"
	},
	"controls_ui/Node/bindings/cstick_right/Button":{
		"down":"controls_ui/Node/bindings/Retour_b",
		"up":"controls_ui/Node/bindings/cstick_left/Button",
		"right":"controls_ui/Node/bindings/ui_right/Button",
		"left":"controls_ui/Node/bindings/ui_right/Button"
	},
	"controls_ui/Node/bindings/Retour_b":{
		"down":"controls_ui/Node/bindings/cstick_up/Button",
		"up":"controls_ui/Node/bindings/cstick_right/Button",
		"right":"controls_ui/Node/bindings/jump/Button",
		"left":"controls_ui/Node/bindings/jump/Button"
	}
}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	btns = main_btns

	current_panel = "Menu"

	current_focused_button="Menu/Smash"
	get_node(current_focused_button).grab_focus()
	get_node("Menu").visible=true
	get_node("Options menu").visible=false
	get_node("Lobby").visible = false
	get_node("controls_ui").visible = false
	
	get_node("/root/Audio_Manager").playmusic('Music/Menu','music',0.8)



func _on_Volume_value_changed(value):
	get_node("/root/Audio_Manager").set_song_volume(value)
	#get_node("son").volume_db= (value-79)/100
	
func _on_Volume_Effets_value_changed(value):
	get_node("/root/Audio_Manager").set_sfx_volume(value)


func _on_Options_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = true
	
	current_panel = "Options"
	
	current_focused_button="Options menu/Volume Musique"
	get_node(current_focused_button).grab_focus()

	btns = options_btns


func _on_Start_pressed():
	get_node("Menu").visible = false
	get_node("Options menu").visible = false
	get_node("Lobby").visible = true

func _on_Quit_pressed():
	get_tree().quit()

func _on_Retour_pressed():
	get_node("Options menu").visible=false
	get_node("Menu").visible=true
	get_node("Lobby").visible = false
	
	current_panel = "Menu"
	
	current_focused_button="Menu/Smash"
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
		elif current_panel == "Commandes" :
			if event.is_action_pressed("ui_right") :
				change_button("right")
			if event.is_action_pressed("ui_left") :
				change_button("left")
	elif event is InputEventJoypadMotion :
		if get_node("Timer").is_stopped() :
			if get_node("Timer/TimerTimer").is_stopped() :
				if event.axis == JOY_AXIS_1 && event.axis_value > 0.3 :
					change_button("down")
					get_node("Timer").start()
				elif event.axis == JOY_AXIS_1 && event.axis_value < -0.3 :
					change_button("up")
					get_node("Timer").start()
				elif current_panel == "Commandes" :
					if event.axis == JOY_AXIS_0 && event.axis_value > 0.3 :
						change_button("right")
						get_node("Timer").start()
					if event.axis == JOY_AXIS_0 && event.axis_value < -0.3:
						change_button("left")
						get_node("Timer").start()
	elif current_panel == "Options" :
		if event is InputEventKey :
			if current_focused_button == "Options menu/Volume Musique" :
				if event.is_action_pressed("ui_left"):
					get_node("Options menu/Volume Musique").value += 1
				elif event.is_action_pressed("ui_right"):
					get_node("Options menu/Volume Musique").value -= 1
			if current_focused_button == "Options menu/Volume Effets" :
				if event.is_action_pressed("ui_left"):
					get_node("Options menu/Volume Effets").value += 1
				elif event.is_action_pressed("ui_right"):
					get_node("Options menu/Volume Effets").value -= 1
			if event.is_action_pressed("ui_down"):
				change_button("down")
			elif event.is_action_pressed("ui_up"):
				change_button("up")

func _on_Quit_focus_entered():
	pass # replace with function body

	btns= main_btns

func _on_Quit_focus_exited():
	pass # replace with function body


func _on_Options_focus_exited():
	pass # replace with function body


func _on_Start_focus_entered():
	pass # replace with function body


func _on_Start_focus_exited():
	pass # replace with function body


func _on_Timer_timeout():
	get_node("Timer/TimerTimer").start()


func _on_TimerTimer_timeout():
	pass # replace with function body



func _on_Commandes_pressed():
	get_node("controls_ui").visible=true
	get_node("Options menu").visible=false
	current_panel="Commandes"
	
	current_focused_button="controls_ui/Node/bindings/ui_up/Button"
	get_node(current_focused_button).grab_focus()

	btns = controls_btns


func _on_Smash_pressed():
	get_tree().change_scene("res://Scenes/Instancing_Test.tscn")
	pass # replace with function body



func _on_Retour_b_pressed():
	get_node("controls_ui").visible=false
	get_node("Options menu").visible=true
	
	current_panel="Options"
	
	current_focused_button="Options menu/Volume Musique"
	get_node(current_focused_button).grab_focus()

	btns = options_btns
	pass # replace with function body
