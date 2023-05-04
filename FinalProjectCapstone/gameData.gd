extends Resource

#https://gdscript.com/solutions/how-to-save-and-load-godot-game-data/
#https://www.youtube.com/watch?v=wSq1QJ-g91M
#https://www.youtube.com/watch?v=TGdQ57qCCF0
#https://kidscancode.org/godot_recipes/4.x/basics/file_io/#:~:text=Saving%20Resources&text=Godot%20saves%20all%20its%20data,ResourceSaver%20and%20ResourceLoader%20Godot%20classes.
#help with saving and loading

class_name gameData

const save_path = "./saves/playerGameData.tres"

export var rollEnable = false

export var doubleJumpEnable = false

export var level1Rank = "F"
#possible ranks are F (impossible to get during gameplay), D, C, B, A, and S. # of deaths required for each rank varies on the level end object 
export var level2Rank = "F"
export var level3Rank = "F"
export var level4Rank = "F"
export var level5Rank = "F"
export var level6Rank = "F"
export var level7Rank = "F"
export var level8Rank = "F"
export var level9Rank = "F"
export var level10Rank = "F"


static func save_game(passedIn):
	ResourceSaver.save(save_path, passedIn)
	
static func load_game() -> Resource:
	if ResourceLoader.exists(save_path):
		return load(save_path)
	return null
