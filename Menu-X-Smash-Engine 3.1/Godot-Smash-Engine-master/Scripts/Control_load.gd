extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Constants
const INPUT_ACTIONS = [ "ui_up", "ui_down", "ui_left", "ui_right", "jump", 'shield', 'attack', 'special', 'grab', 'cstick_up','cstick_down','cstick_left','cstick_right' ]
const CONFIG_FILE = "res://input.cfg"

# Member variables
var action # To register the action the UI is currently handling
var button # Button node corresponding to the above action
var deadzone = 0.3
var deadzone_flag = false
# Load/save input mapping to a config file
# Changes done while testing the demo will be persistent, saved to CONFIG_FILE

func load_config():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err: # Assuming that file is missing, generate default config
		for action_name in INPUT_ACTIONS:
			var action_list = InputMap.get_action_list(action_name)
			# There could be multiple actions in the list, but we save the first one by default
			var new_event = InputEventKey.new()
			if len(action_list) > 0:
				new_event.scancode = action_list[0].scancode
			config.set_value("input", action_name, new_event)
		config.save(CONFIG_FILE)
	else: # ConfigFile was properly loaded, initialize InputMap
		for action_name in config.get_section_keys("input"):
			var value = config.get_value("input", action_name)
			for old_event in InputMap.get_action_list(action_name):
				InputMap.action_erase_event(action_name, old_event)
			InputMap.action_add_event(action_name, value)
			
			# Create a new event object based on the saved scancode

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	load_config()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
