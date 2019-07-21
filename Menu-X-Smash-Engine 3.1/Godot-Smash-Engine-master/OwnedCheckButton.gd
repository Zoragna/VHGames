extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var colorRect = get_node("ColorRect")
onready var checkButton = get_node("CheckButton")
onready var colorPicker = get_node("ColorPickerButton")

signal owner_set
signal owner_unset

var player = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	colorRect.set_frame_color(Color(random.randi()))
	colorPicker.set_pick_color(colorRect.get_frame_color())

func _on_CheckButton_toggled(button_pressed):
	if button_pressed :
		emit_signal("owner_set", self)
	else :
		emit_signal("owner_unset", self)

func set_player(value):
	player = value

func get_player():
	return player

func _on_ColorPickerButton_color_changed(color):
	colorRect.set_frame_color(color)
