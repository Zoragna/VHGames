extends Node2D

const PORT        = 4129
const MAX_PLAYERS = 8

var peers_connected = {}
var peers_done = []

var port = PORT
var chosen_stage = null
var host_ip = null

var info = { 
	"name" : "Johnson Magenta",
	"color" : Color8(255, 0, 255)
}

func switch_to_host():
	get_node("BeforeConnection").queue_free()
	get_node("Hosting").show()

func _ready():
	# Host / Peers
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	
	#Peer
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_failed")
	get_tree().connect("server_disconnected", self, "_host_disconnected")

func hosting_add_label(info, id) :
	var label = load("res://Scenes/PeerName.tscn").instance()
	label.set_name(str(id))
	label.text = info["name"]
	label.set("custom_colors/font_color", info["color"])
	get_node("Hosting/HBoxContainer/VBoxContainer").add_child( label )

func hosting_remove_label(id):
	get_node("Hosting/HBoxContainer/VBoxContainer/"+str(id)).queue_free()

func _init_as_host():
	var peer = NetworkedMultiplayerENet.new()
	var res = peer.create_server(port, MAX_PLAYERS)
	
	if res == OK :
		print("Server created")
	else :
		if res == ERR_ALREADY_IN_USE :
			print("Server : already in use")
		elif res == ERR_CANT_CREATE :
			print("Server can't be created")
		queue_free()

	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	
	var me = load("res://Player.tscn").instance()
	me.set_name("1")     # spawn players with their respective names
	get_tree().get_root().add_child(me)
	
	peers_connected[1] = info
	
	hosting_add_label(info, 1)

func _init_as_peer(ip):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, PORT)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)

func _peer_connected(id):
	var str_id = str(id)
	print('Peer ' + str_id + ' connected !')
	
	var new_client = load("res://Player.tscn").instance()
	new_client.set_name(str_id)     # spawn players with their respective names
	get_tree().get_root().add_child(new_client)
	
	peers_connected[id] = new_client

func _peer_disconnected(id):
	var str_id = str(id)
	print('Peer ' + str_id + ' disconnected')
	
	get_tree().get_root().get_node(str_id).queue_free()
	hosting_remove_label(id)
	
	peers_connected.erase(id)
	peers_done.erase(id)

func print_message(color, pseudo, message):
	get_node("Hosting/HBoxContainer/VSplitContainer/RichTextLabel").append_bbcode("[b][color="+color+"]"+pseudo+"[/color][/b] : "+message+"\n")

func submit_receive_message(id, message):
	if get_tree().is_network_server():
		for peer_id in peers_connected.keys() :
			if peer_id != 1:
				rpc_id(peer_id, "receive_message", id, message)

remote func receive_message(id, message) :
	var pseudo = peers_connected[id]["name"]
	var color = "#"+peers_connected[id]["color"].to_html(false)
	print("RECEIVED " + pseudo + ":" + message)
	print_message(color, pseudo, message)
	submit_receive_message(id, message)

func send_message(message):
	print("SENDING " + info["name"] + ":" + message)
	if get_tree().is_network_server():
		print_message("#"+info["color"].to_html(false), info["name"], message)
		submit_receive_message(1, message)
	else:
		rpc_id(1, "receive_message", get_tree().get_network_unique_id(), message)

func set_stage(stage_path):
	if get_tree().is_network_server():
		chosen_stage = stage_path

remote func register_player(id, info):
	print("Registering from "+str(get_tree().get_network_unique_id())+" peer #"+str(id)+" whose name is "+info["name"])
	# Store the info
	peers_connected[id] = info
	hosting_add_label(info, id)
	# If I'm the server, let the new guy know about existing players
	send_info(id)
	
remote func update_player(id, info):
	peers_connected[id] = info
	get_node("Hosting/HBoxContainer/VBoxContainer/"+str(id)).text = id["name"]
	send_info(id)

func send_info(id):
	if get_tree().is_network_server():
		# Send my info to new player
		rpc_id(id, "register_player", 1, info)
		# Send the info of existing players
		for peer_id in peers_connected:
			rpc_id(id, "register_player", peer_id, peers_connected[peer_id])

remote func pre_configure_game():
	get_tree().set_pause(true) # Pre-pause
	
	var selfPeerID = get_tree().get_network_unique_id()
	
	# Load world (not yet)
	var stage = load(chosen_stage).instance()
	get_node("/root").add_child(stage)
	
	# Load my player
	var my_player = preload("res://Player.tscn").instance()
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	get_node("/root/world/players").add_child(my_player)
	    
	# Load other players
	for p in peers_connected:
		var player = preload("res://Player.tscn").instance()
		player.set_name(str(p))
		get_node("/root/world/players").add_child(player)
		
	# Tell server (remember, server is always ID=1) that this peer is done pre-configuring
	rpc_id(1, "done_preconfiguring", selfPeerID)
	
remote func done_preconfiguring(who):
	# Here is some checks you can do, as example
	assert(get_tree().is_network_server())
	assert(who in peers_connected) # Exists
	assert(not who in peers_done) # Was not added yet
	assert(chosen_stage != null)
	
	peers_done.append(who)
	
	if peers_done.size() == peers_connected.size():
		rpc("post_configure_game")

remote func post_configure_game():
    get_tree().set_pause(false)
    # Game starts now!

func _connected_ok():
	print("Connected Ok !")
	rpc("register_player", get_tree().get_network_unique_id(), info)

func _connected_failed():
	print("Can't connect to host ("+host_ip+")")
	
func _host_disconnected():
	print("Host disconnected you")
	
func update_info():
	if get_tree().has_meta("network_peer") :
		rpc_id(1, "update_player", info)

func set_name(name):
	info["name"] = name
	update_info()

func set_color(color):
	info["color"] = color
	update_info()
	
func set_ip(ip):
	host_ip = ip

func hosting():
	get_node("BeforeConnection").visible = false
	get_node("Hosting").visible = true

func _on_ConnectButton_pressed():
	var ip = get_node("BeforeConnection/VBox/HBox/Host/HostIPLine").text
	print("Connecting to "+ip)
	if ip.split(':').size() == 2 :
		port = ip.split(':')[1]
	_init_as_peer(ip)
	hosting()

func _on_HostButton_pressed():
	_init_as_host()
	hosting()

func _on_Retour_pressed():
	get_node("BeforeConnection").visible = true
	get_node("Hosting").visible = false

func _on_ColorPickerButton_color_changed( color ):
	 set_color(color)

func _on_LineEdit_text_changed( new_text ):
	set_name(new_text)


func _on_PortEdit_text_changed( new_text ):
	print("Port chosen "+new_text)
	port = int(new_text)

func _on_Messaging_text_entered( new_text ):
	send_message(new_text)
	get_node("Hosting/HBoxContainer/VSplitContainer/TextEdit").text = ""
