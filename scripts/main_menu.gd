extends Node


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/game_board.tscn")
