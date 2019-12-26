extends KinematicBody2D

export (int) var direction #0 left, 1 right
export (int) var mov
export (int) var vel
var spawn_original

func _ready():
	if(direction == 0):
		mov += (game.level-1) * mov / 6
		mov = -mov
		rotation_degrees = 180

func _physics_process(delta):
	var colisioned_object = move_and_collide(Vector2(mov,0) * vel * delta)
	
	if(colisioned_object != null && colisioned_object.collider.is_in_group("player")):
		colisioned_object.collider.gameover()

func _on_VisibilityNotifier2D_screen_exited():
	global_position = spawn_original.global_position
	if(spawn_original.is_in_group("car_spawn")):
		spawn_original.get_node("Timer").stop()
	else:
		spawn_original.get_parent().get_node("Timer").stop()
