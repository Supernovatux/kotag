extends Control
signal HudOut

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TimeLeft.text = "%02d" % $MatchCountdown.time_left


func _on_match_countdown_timeout():
	hide()
	emit_signal("HudOut")
