extends Control

#  title screen help:  https://www.youtube.com/watch?v=xrYJikZrCQ0
# https://youtu.be/ya5BaDzcwkk


func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/Hub_1.tscn");


func _on_QuitButton_pressed():
	get_tree().quit()


