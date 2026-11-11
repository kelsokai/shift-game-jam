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
			print(velocity)
		if(global_position.x > GlobalVariables.player.global_position.x):
			velocity.x =  -speed
			
		elif (global_position.x < GlobalVariables.player.global_position.x):
			velocity.x = speed
		else:
			velocity.x = 0
		
		move_and_slide()
		var collision = get_last_slide_collision()
		if(collision):
			if(collision.get_collider().is_in_group("player")):
				GlobalVariables.health -= 1


func hit(damage):
	HP -= damage
	if(HP == 0):
		GlobalVariables.score += 5
		queue_free()
