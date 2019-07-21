extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var OwnedCheckButton = preload("res://Scenes/OwnedCheckButton.tscn")
var n_selectables = 0
var characters_path = "res://Scenes/Characters/"
onready var grid_selectables = get_node("GridContainer")
onready var player_container = get_node("HBoxContainer")

var characters_selectable_spritesheet = preload("res://Sprites/ProtoChar/Stand.png")

var n_player = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	var files = list_files_in_directory(characters_path)
	var tscn_files = []
	for file in files :
		if file.ends_with(".tscn") :
			tscn_files.append(file.replace(".tscn",""))
	n_selectables = tscn_files.size()
	grid_selectables.set_columns(n_selectables)
	for file in tscn_files :
		var charac_button = TextureButton.new()
		charac_button.connect("pressed", self, "on_character_pressed", [charac_button, file])
		charac_button.set_normal_texture(characters_selectable_spritesheet)
		grid_selectables.add_child(charac_button)
	for id in Input.get_connected_joypads() :
		add_player(id)
	for child in player_container.get_children():
		child.connect("owner_set",self,"on_owner_set",[child])
		child.connect("owner_unset",self,"on_owner_unset",[child])

func _input(event):
	print(event.device)

func on_character_pressed(button, file_name):
	print(file_name)

func on_owner_set(ownedCheckButton):
	pass

func on_owner_unset(ownedCheckButton):
	pass

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func add_player(value=""):
	var button = OwnedCheckButton.instance()
	button.set_player(value)
	player_container.add_child(button)

func remove_player():
	player_container.remove_child(player_container.get_children()[-1])

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()
    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with("."):
            files.append(file)
    return files

func _on_Button2_pressed():
	add_player()

func _on_Button3_pressed():
	remove_player()

func _on_Button4_pressed():
	get_tree().change_scene("res://Scenes/Instancing_Test.tscn")
