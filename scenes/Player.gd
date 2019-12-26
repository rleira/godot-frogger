extends KinematicBody2D

export (int) var mov #Cuanto mide cada bloque en el que se movera
var velocity = Vector2()
var player_position = Vector2()
var in_water = false
var in_log = false
var log_velocity

func _ready():
	pass

func _physics_process(delta):
	
	check_water()
	
	if(!get_node("AnimationPlayer").is_playing()):
		if(Input.is_action_just_pressed("key_w")):
			velocity.y = -mov / get_node("AnimationPlayer").get_animation("jump").length
			rotation_degrees = 0
			get_node("AnimationPlayer").play("jump")
			player_position = global_position
			player_position.y -= mov
		elif(Input.is_action_just_pressed("key_s")):
			velocity.y = mov / get_node("AnimationPlayer").get_animation("jump").length
			rotation_degrees = 180
			get_node("AnimationPlayer").play("jump")
			player_position = global_position
			player_position.y += mov
		elif(Input.is_action_just_pressed("key_a")):
			rotation_degrees = 270
			velocity.x = -mov / get_node("AnimationPlayer").get_animation("jump").length
			get_node("AnimationPlayer").play("jump")
			player_position = global_position
			player_position.x -= mov
		elif(Input.is_action_just_pressed("key_d")):
			rotation_degrees = 90
			velocity.x = mov / get_node("AnimationPlayer").get_animation("jump").length
			get_node("AnimationPlayer").play("jump")
			player_position = global_position
			player_position.x += mov
	
	var collisioned_object = move_and_collide(velocity * delta)
	
	if(collisioned_object != null && collisioned_object.collider.is_in_group("car")):
		gameover()
		
func gameover():
	game.level = 1
	get_tree().reload_current_scene()


func check_water():
	if(in_water && !in_log && !get_node("AnimationPlayer").is_playing()):
		gameover()
	elif(in_water && in_log && !get_node("AnimationPlayer").is_playing()):
		velocity.x = log_velocity

func _on_AnimationPlayer_animation_finished( anim_name ):
	if(anim_name == "jump"):
		velocity.x = 0
		velocity.y = 0
		
		if(in_log):
			global_position.y = player_position.y
		else:
			global_position = player_position

func _on_VisibilityNotifier2D_screen_exited():
	gameover()
