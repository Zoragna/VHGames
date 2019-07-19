extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#get_node("/root/Audio_Manage/AudioStreamPlayer").play('Music/Menu')
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	
	if Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene("res://Scenes/Instancing_Test.tscn")
		#get_node("/root/global").goto_scene("res://Scenes/Instancing_Test.tscn")
		#get_tree().change_scene
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
