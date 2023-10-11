extends CharacterBody2D
signal tag(status)
var tagged = false
var actions = []
var boost = 1
var player_id
var pass_signal = false
const SPEED = 700.0
const JUMP_VELOCITY = -550.0
var double_jump = 0
var screen_size
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func get_player_id():
	return player_id
func set_player_id(id):
	player_id = id;
func add_action(act):
	actions.append(act)
func get_tagged():
	return self.tagged
func set_pass(val):
	pass_signal = val
func set_tagged(tg:bool):
	self.tagged = tg;
	$TagArea/TagShape.shape
	print(self.tagged," from tg ",player_id)
	emit_signal("tag",tg)
	#if tg:
	#	$Area2D.connect_signal()
	#else:
	#	$Area2D.disconnect_signal()

func remove():
	for i in actions:
		InputMap.erase_action(i)
	queue_free()
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(200+200*player_id,200+200*player_id)
	show()
	$Label.text = str(player_id)
	pass # Replace with function body.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		double_jump = 0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up{n}".format({"n":player_id})) and double_jump==0:
		velocity.y = JUMP_VELOCITY
		double_jump=1
	elif Input.is_action_just_pressed("ui_up{n}".format({"n":player_id})) and double_jump==1:
		velocity.y += JUMP_VELOCITY
		double_jump=2
	if Input.is_action_pressed("ui_right{n}".format({"n":player_id})):
		velocity.x = 1*SPEED
	elif Input.is_action_pressed("ui_left{n}".format({"n":player_id})):
		velocity.x = -1*SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("ui_boost{n}".format({"n":player_id})) and boost:
		velocity.x = velocity.x*10
		velocity.y = velocity.y*2
		if get_tagged():
			boost -=0.5
		else:
			boost -= 1
	move_and_slide()
 


func _on_area_2d_area_entered(area):
	if pass_signal:
		pass_signal = false
		return
	print(self.get_tagged(),"On area entered ",player_id)
	if self.get_tagged():
		self.set_tagged(false)
		var pr_char = area.get_parent()
		pr_char.set_pass(true)
		pr_char.set_tagged(true)
	else:
		var pr_char = area.get_parent()
		if pr_char.get_tagged():
			self.set_tagged(true)
			pr_char.set_pass(true)
			pr_char.set_tagged(false)




func _on_re_boost_timeout():
	if boost < 3:
		boost +=1


func _on_kill_count_timeout():
	print("123")
