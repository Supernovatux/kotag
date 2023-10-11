extends Node2D
signal loser(id)
@export var player_scene: PackedScene

var players = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func add_players(id):
	var pl = player_scene.instantiate()
	pl.set_player_id(id)
	players.append(pl)
	var right_action_event: InputEventJoypadMotion
	var right_action:String
	right_action = "ui_right{n}".format({"n":id})
	pl.add_action(right_action)
	InputMap.add_action(right_action)
	right_action_event = InputEventJoypadMotion.new()
	right_action_event.device = id
	right_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
	right_action_event.axis_value =  1.0 # <---- right
	InputMap.action_add_event(right_action, right_action_event)
	var left_action_event: InputEventJoypadMotion
	var left_action:String
	left_action = "ui_left{n}".format({"n":id})
	InputMap.add_action(left_action)
	left_action_event = InputEventJoypadMotion.new()
	left_action_event.device = id
	left_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
	left_action_event.axis_value =  -1.0 # <---- right
	InputMap.action_add_event(left_action, left_action_event)
	var up_action_event: InputEventJoypadButton
	var up_action:String
	up_action = "ui_up{n}".format({"n":id})
	InputMap.add_action(up_action)
	up_action_event = InputEventJoypadButton.new()
	up_action_event.device = id
	up_action_event.button_index = JOY_BUTTON_A
	InputMap.action_add_event(up_action, up_action_event)
	var down_action_event: InputEventJoypadMotion
	var down_action:String
	down_action = "ui_down{n}".format({"n":id})
	InputMap.add_action(down_action)
	down_action_event = InputEventJoypadMotion.new()
	down_action_event.device = id
	down_action_event.axis = JOY_AXIS_LEFT_Y # <---- horizontal axis
	down_action_event.axis_value =  1.0 # <---- down
	InputMap.action_add_event(down_action, down_action_event)
	pl.add_action(left_action)
	pl.add_action(up_action)
	pl.add_action(down_action)
	var boost_action_event: InputEventJoypadButton
	var boost_action:String
	boost_action = "ui_boost{n}".format({"n":id})
	InputMap.add_action(boost_action)
	boost_action_event = InputEventJoypadButton.new()
	boost_action_event.device = id
	boost_action_event.button_index = JOY_BUTTON_B
	pl.add_action(boost_action)
	InputMap.action_add_event(boost_action, boost_action_event)
	add_child(pl)
func remove_player(id):
	for i in players.size():
		if players[i].get_player_id() == id:
			players[i].remove()
			players.remove_at(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_main_summon(id, con):
	if con:
		add_players(id)
	else:
		remove_player(id)


func _on_make_catcher_timeout():
	var rand_int:int = randi() % players.size()
	players[rand_int].set_tagged(true)

func declare_loser():
	for i in players:
		if i.get_tagged() == true:
			emit_signal("loser",i.get_player_id())
	

func _on_hud_hud_out():
	declare_loser()
