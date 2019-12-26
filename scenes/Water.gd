extends Area2D

func _ready():
	pass

func _on_Water_body_entered( body ):
	if(body.is_in_group("player")):
		body.in_water = true

func _on_Water_body_exited( body ):
	if(body.is_in_group("player")):
		body.in_water = false
