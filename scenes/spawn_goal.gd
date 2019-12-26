extends Node


func _ready():
	randomize()
	var result = randi()%10+1
	var newgoal = get_tree().get_nodes_in_group("main")[0].goal.instance()
	newgoal.global_position = get_node(String(result)).global_position
	get_tree().get_nodes_in_group("level")[0].call_deferred("add_child", newgoal)
