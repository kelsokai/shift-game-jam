extends Node
var score = 0
var health = 4
var player = null
var invulnerable = false
var gravity = 0
func game_over():
	pass
	
func new_game():
	gravity = 0
	health = 4
	score = 0
	invulnerable = false
