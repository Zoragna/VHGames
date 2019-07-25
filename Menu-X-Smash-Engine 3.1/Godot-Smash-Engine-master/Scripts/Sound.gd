extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Music
var Sfx
var data


func _init():
	load_sound()
	Music = AudioStreamPlayer.new()
	Music.set_bus("Master")
	Music.set_autoplay(true)
	set_song_volume(data["volume"]["music"])
	add_child(Music)
	Sfx = AudioStreamPlayer.new()
	Sfx.set_bus("Master")
	Sfx.set_autoplay(true)
	set_sfx_volume(data["volume"]["sfx"])
	add_child(Sfx)

func load_sound():
	var file = File.new()
	file.open("res://Sound/sound.json", file.READ)
	var text = file.get_as_text()
	var jdata =JSON.parse(text)
	data = jdata.result
	file.close()

func save_sound(type,value):
	var file = File.new()
	file.open("res://Sound/sound.json", file.WRITE)
	data["volume"][type] = value
	file.store_line(JSON.print(data))
	file.close()

func playmusic(music):
	var m = load("res://Sound/Music/" + music)
	Music.set_stream(m)
	Music.play()

func set_song_volume(v):
	Music.set_volume_db(v)
	save_sound("music",v)

func playsfx(sfx):
	var s = load("res://Sound/SFX/ProtoChar/" + sfx)
	var v = Sfx.get_volume_db()
	Sfx.set_stream(s)
	Sfx.set_volume_db(v)
	Sfx.play()

func set_sfx_volume(v):
	Sfx.set_volume_db(v)
	save_sound("sfx",v)
