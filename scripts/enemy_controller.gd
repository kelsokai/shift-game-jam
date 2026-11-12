extends CharacterBody2D
var HP = 20
var speed = 200
var damage = 1 


func _ready() -> void:
	#var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	#$AnimatedSprite2D.animation = mob_types.pick_random()
	#$AnimatedSprite2D.play()
	pass

func _physics_process(delta: float) -> void:
	if GlobalVariables.player:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if(GlobalVariables.gravity % 2 == 0):	
			if(global_position.x > GlobalVariables.player.global_position.x):
				velocity.x =  -speed
			
			elif (global_position.x < GlobalVariables.player.global_position.x):
				velocity.x = speed
			else:
				velocity.x = 0
		else:
			if(global_position.y > GlobalVariables.player.global_position.y):
				velocity.y =  -speed
			
			elif (global_position.y < GlobalVariables.player.global_position.y):
				velocity.y = speed
			else:
				velocity.y = 0
		look_at(GlobalVariables.player.position)	
		rotation = round(rotation / (PI / 2)) * (PI / 2)
		move_and_slide()
		var collision = get_last_slide_collision()
		if(collision):
			if(collision.get_collider().is_in_group("player")):
				GlobalVariables.player.hit(damage)


func hit(damage):
	HP -= damage
	if(HP == 0):
		GlobalVariables.score += 20
		queue_free()
