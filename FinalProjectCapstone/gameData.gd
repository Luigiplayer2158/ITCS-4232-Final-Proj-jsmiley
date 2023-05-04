extends Resource

#https://gdscript.com/solutions/how-to-save-and-load-godot-game-data/
#https://www.youtube.com/watch?v=wSq1QJ-g91M
#https://www.youtube.com/watch?v=TGdQ57qCCF0
#https://kidscancode.org/godot_recipes/4.x/basics/file_io/#:~:text=Saving%20Resources&text=Godot%20saves%20all%20its%20data,ResourceSaver%20and%20ResourceLoader%20Godot%20classes.
#help with saving and loading


class_name gameData

const save_path = "./saves/playerGameData.tres"

export var rollEnable = false

export var doubleJumpEnable = true

export var level1 = {
	"deaths": 0,
	"collectables": 0,
	"time": "0:00",
	"rank": "F"	
}

static func save_game(passedIn):
	ResourceSaver.save(save_path, passedIn)
	
static func load_game() -> Resource:
	if ResourceLoader.exists(save_path):
		return load(save_path)
	return null
