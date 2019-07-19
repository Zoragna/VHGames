extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Music
var Sfx
# Called when the node enters the scene tree for the first time.
func _init():
	Music = AudioStreamPlayer.new()
	Music.set_bus("Master")
	Music.set_autoplay(true)
	add_child(Music)
	Sfx = AudioStreamPlayer.new()
	Sfx.set_bus("Master")
	Sfx.set_autoplay(true)
	add_child(Sfx)

func _ready():
	pass  #Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func playmusic(music, volume):
	var m = load("res://Sound/Music/" + music)
	Music.set_stream(m)
	Music.set_volume_db(volume)
	Music.play()

func set_song_volume(value):
	Music.set_volume_db(value)


func playsfx(sfx, volume):
	var s = load("res://Sound/SFX/ProtoChar/" + sfx)
	Sfx.set_stream(s)
	Sfx.set_volume_db(volume)
	Sfx.play()

func set_sfx_volume(value):
	Sfx.set_volume_db(value)