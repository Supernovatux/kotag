extends Area2D

var player_id
const GRAVITY = 200.0
@export var speed = 300
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(200+200*player_id,200+200*player_id)
	show()
	pass # Replace with function body.
func get_player_id():
	return player_id
func set_player_id(id):
	player_id = id;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right{n}".format({"n":player_id})):
		velocity.x += 1
	if Input.is_action_pressed("ui_left{n}".format({"n":player_id})):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down{n}".format({"n":player_id})):
		velocity.y += 1
	if Input.is_action_pressed("ui_up{n}".format({"n":player_id})):
		velocity.y -= 10
	velocity.y += delta * GRAVITY
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


