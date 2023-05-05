extends Spatial

export (String) var level_name = "";
var scaleModif = 0.05;
var portal_enabled = false;
var enable_grow = false;
export var deathsC = 7
export var deathsB = 5
export var deathsA = 3
export var deathsS = 1
export var levelVariable = "level1Rank"
onready var portalArea = $Area
onready var endScreen = $"../HUD/EndScreen"
onready var endScreenAnim = $"../HUD/EndScreen/AnimationPlayer"
onready var rankLabel = $"../HUD/EndScreen/rankLabel"
onready var deathCount = $"../HUD".deathCount
onready var playerAudio = $"../Player/MovingPlayer/AudioStreamPlayer"
onready var audioWooHoo = preload("res://Sounds/VoiceClips/player_woohoo.ogg")

export var portalAllowed = true

# https://www.youtube.com/watch?v=2yPdNEhfBGw level switcher help
# Called when the node enters the scene tree for the first time.
func _ready():
	portal_enabled = false;
	enable_grow = false;
	portalArea.scale.x = 0
	portalArea.scale.y = 0
	portalArea.scale.z = 0
	endScreenAnim.get_animation("LevelComplete").set_loop(false)

func _physics_process(delta):
	deathCount = $"../HUD".deathCount
	if portalAllowed == true:
		portalArea.rotation.y += 0.2
		if enable_grow == true:
			portalArea.scale.y += scaleModif
			portalArea.scale.x += scaleModif
			portalArea.scale.z += scaleModif
			if portalArea.scale.y > 1:
				portal_enabled = true
				scaleModif = 0
			elif portalArea.scale.y <= 0:
				scaleModif = 0.05
	

func _on_Area_body_entered(body):
	if portalAllowed == true:
		if body is KinematicBody:
			print("it has occured");
			if deathCount < deathsS:
				RuntimeGameData.runTimeData.set(levelVariable, "S")
			elif deathCount < deathsA:
				RuntimeGameData.runTimeData.set(levelVariable, "A")
			elif deathCount < deathsB:
				RuntimeGameData.runTimeData.set(levelVariable, "B")
			elif deathCount < deathsC:
				RuntimeGameData.runTimeData.set(levelVariable, "C")
			else:
				RuntimeGameData.runTimeData.set(levelVariable, "D")
			
			get_tree().paused = true
			playerAudio.stop()
			playerAudio.stream = audioWooHoo
			playerAudio.stream.loop = false
			playerAudio.play()
			rankLabel.text = "Rank: " + str(RuntimeGameData.runTimeData.get(levelVariable))
			endScreenAnim.play("LevelComplete")
			$"../HUD/EndScreen/Continue".grab_focus()


func _on_Area2_body_entered(body):
	if portalAllowed == true:
		if body is KinematicBody:
			print("area entered, effect should grow.")
			enable_grow = true
	
