var file = File.new()
var const_file = file.open("res://Scripts/constantes.json",file.READ)
var menu = load("res://scripts/MainMenu.gd").new()

func get_const_menu(test):
	test = "YES"