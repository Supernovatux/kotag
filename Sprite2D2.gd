extends Sprite2D
func _ready():
	hide()


func _on_character_body_2d_tag(status):
	if status:
		show()
	else:
		hide()
