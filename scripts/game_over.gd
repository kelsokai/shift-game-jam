extends Control


	


func _on_play_again_pressed() -> void:
	GlobalVariables.new_game()
	get_tree().reload_current_scene()
	hide() # Replace with function body.
