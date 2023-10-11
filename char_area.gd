extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func disconnect_signal():
	disconnect("area_entered",get_parent()._on_area_2d_area_entered)
func connect_signal():
	if not area_entered.is_connected(get_parent()._on_area_2d_area_entered):
		connect("area_entered",get_parent()._on_area_2d_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
