extends Node

#Defining Constants
#Stage
var WALL = 'Wall'
var FLOOR = 'Floor'
var PLATFORM = 'Platform'

#States
var STAND #= 'stand'
var DASH #= 'dash'
var RUN #= 'run'
var CROUCH #= 'crouch'
var LANDING #= 'landing'
var JUMP_SQUAT #= 'jump_squat'
var SHORT_HOP #= 'short_hop'
var FULL_HOP #= 'full_hop'
var SKID #= 'skid'
var AIR #= 'air'
var AIR_DODGE #= 'air_dodge'
var FREE_FALL #= 'free_fall'
var WALLJUMPLEFT #= 'wall_jump_left'
var WALLJUMPRIGHT #= 'wall_jump_right'
var LEDGE_CATCH #= 'ledge_catch'
var LEDGE_HOLD #= 'ledge_hold'
var LEDGE_ROLL_FAST #= 'ledge_roll_fast'
var LEDGE_CLIMB_FAST #= 'ledge_climb_fast'
var LEDGE_JUMP_FAST #= 'ledge_jump_fast'
var LEDGE_ROLL_SLOW #= 'ledge_climb_slow'
var LEDGE_CLIMB_SLOW #= 'ledge_climb_slow'
var LEDGE_JUMP_SLOW #= 'ledge_jump_slow'
var NAIR #= 'nair'
var FAIR #= 'fair'
var UAIR #= 'uair'
var BAIR #=  'bair'
var DAIR #=  'dair'
var TUMBLE #=  'tumble'

var const_dict

var current_scene = null
var p1_device = null
#Device,AxisX,AxisY,Keyboard


func _ready():
	init_const()
	var root = get_tree().get_root()
	p1_device = {'device':0,'axisx':0,'axisy':0,'keyboard':false,'joypad':true}
	current_scene = root.get_child( root.get_child_count() -1 )

func init_const():
	var file = File.new()
	file.open("res://Scripts/constantes.json",file.READ)
	var const_text = file.get_as_text()
	var const_parse = JSON.parse(const_text)
	const_dict = const_parse.result
	
	STAND = const_dict["const"]["states"]['STAND']
	DASH = const_dict["const"]["states"]['DASH']
	RUN = const_dict["const"]["states"]['RUN']
	CROUCH = const_dict["const"]["states"]['CROUCH']
	LANDING = const_dict["const"]["states"]['LANDING']
	JUMP_SQUAT = const_dict["const"]["states"]['JUMP_SQUAT']
	SHORT_HOP = const_dict["const"]["states"]['SHORT_HOP']
	FULL_HOP = const_dict["const"]["states"]['FULL_HOP']
	SKID = const_dict["const"]["states"]['SKID']
	AIR = const_dict["const"]["states"]['AIR']
	AIR_DODGE = const_dict["const"]["states"]['AIR_DODGE']
	FREE_FALL = const_dict["const"]["states"]['FREE_FALL']
	WALLJUMPLEFT = const_dict["const"]["states"]['WALL_JUMP_LEFT']
	WALLJUMPRIGHT = const_dict["const"]["states"]['WALL_JUMP_RIGHT']
	LEDGE_CATCH = const_dict["const"]["states"]['LEDGE_CATCH']
	LEDGE_HOLD = const_dict["const"]["states"]['LEDGE_HOLD']
	LEDGE_ROLL_FAST = const_dict["const"]["states"]['LEDGE_ROLL_FAST']
	LEDGE_CLIMB_FAST = const_dict["const"]["states"]['LEDGE_CLIMB_FAST']
	LEDGE_JUMP_FAST = const_dict["const"]["states"]['LEDGE_JUMP_FAST']
	LEDGE_ROLL_SLOW = const_dict["const"]["states"]['LEDGE_CLIMB_SLOW']
	LEDGE_CLIMB_SLOW = const_dict["const"]["states"]['LEDGE_CLIMB_SLOW']
	LEDGE_JUMP_SLOW = const_dict["const"]["states"]['LEDGE_JUMP_SLOW']
	NAIR = const_dict["const"]["states"]['NAIR']
	FAIR = const_dict["const"]["states"]['FAIR']
	UAIR = const_dict["const"]["states"]['UAIR']
	BAIR =  const_dict["const"]["states"]['BAIR']
	DAIR =  const_dict["const"]["states"]['DAIR']
	TUMBLE =  const_dict["const"]["states"]['TUMBLE']


func goto_scene(path):

    # This function will usually be called from a signal callback,
    # or some other function from the running scene.
    # Deleting the current scene at this point might be
    # a bad idea, because it may be inside of a callback or function of it.
    # The worst case will be a crash or unexpected behavior.

    # The way around this is deferring the load to a later time, when
    # it is ensured that no code from the current scene is running:

    call_deferred("_deferred_goto_scene",path)


func _deferred_goto_scene(path):

    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene
    var s = ResourceLoader.load(path)

    # Instance the new scene
    current_scene = s.instance()

    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene( current_scene )