extends Control

#  title screen help:  https://www.youtube.com/watch?v=xrYJikZrCQ0
# https://youtu.be/ya5BaDzcwkk

func _ready():
	if ResourceLoader.exists(RuntimeGameData.newRuntimeData.save_path):
		$VBoxContainer/ContinueGame.grab_focus()
	else:
		$VBoxContainer/ContinueGame.disabled = true
		$VBoxContainer/NewGame.grab_focus()

func _on_StartButton_pressed():
	RuntimeGameData.newRuntimeGameData = gameData.load_game()
	get_tree().change_scene("res://Levels/Hub_1.tscn");

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_NewGame_pressed():
	get_tree().change_scene("res://Levels/Hub_1.tscn");
