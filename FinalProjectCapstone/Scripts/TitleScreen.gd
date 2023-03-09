extends Control

#  title screen help:  https://www.youtube.com/watch?v=xrYJikZrCQ0


func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/test_level1.tscn");


func _on_QuitButton_pressed():
	get_tree().quit()


