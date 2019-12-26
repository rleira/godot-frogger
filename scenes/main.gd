extends Node

export (PackedScene) var car1
export (PackedScene) var car2
export (PackedScene) var car3
export (PackedScene) var car4
export (PackedScene) var car5
export (PackedScene) var log1
export (PackedScene) var goal

func _ready():
	randomize()
	$Music.play()