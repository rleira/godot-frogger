extends Position2D

var velocity
export (int) var dir

func _ready():
	randomize()
	velocity = randi()%5
	set_timer()
	get_node("Timer").start()
	generate_log()

func set_timer():
	match(velocity):
		0:
			get_node("Timer").wait_time = 5
		1:
			get_node("Timer").wait_time = 6
		2:
			get_node("Timer").wait_time = 7
		3:
			get_node("Timer").wait_time = 8
		4:
			get_node("Timer").wait_time = 9

func generate_log():
	var newt1 = get_tree().get_nodes_in_group("main")[0].log1.instance()
	get_tree().get_nodes_in_group("level")[0].call_deferred("add_child", newt1)
	if(dir == 0):
		newt1.global_position = global_position
		newt1.direction = 1
		newt1.spawn_original = self
	else:
		newt1.global_position = get_node("log_spawni").global_position
		newt1.spawn_original = get_node("log_spawni")

func _on_Timer_timeout():
	generate_log()
