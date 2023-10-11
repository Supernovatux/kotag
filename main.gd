extends Node2D
signal summon(id,con)
# Called when the node enters the scene tree for the first time.
func _ready():
	$WinerScreen.hide()
	Input.connect("joy_connection_changed",_joy_connection_changed_callback)
	for i in Input.get_connected_joypads():
		if not Input.get_joy_name(i).contains("Touchpad"):
			print(Input.get_joy_name(i))
			$World.add_players(i)
	pass # Replace with function body.
func _joy_connection_changed_callback(device,con):
	if not Input.get_joy_name(device).contains("Touchpad"):
		print(Input.get_joy_name(device))
		call_deferred("emit_signal","summon",device,con)
	return
func _process(_delta):
	pass


func _on_world_loser(id):
	$World.hide()
	$WinerScreen/Label.text = str(id)
	$WinerScreen.show()
