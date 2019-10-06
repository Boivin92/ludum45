extends Node2D

var skills = ["Programming", "Art works", "Script writing", "Cooking (thanks!)"]
var progs = ["François Boivin","Cédric Pinard", "Mélanie Ellias"]
var artists = ["Ariane Simard-Leduc", "Olivier Boily"]
var script_writer = ["Marie-Pier Bergeron"]
var feeder = ["François Boivin","Marie-Pier Bergeron"]
var currentNamesToDisplay = []
var skillCounter = 0
var nameCounter = 0

func _ready() -> void:
	set_current_names(skills[0])
	$Names.text = currentNamesToDisplay[nameCounter]
	$Skills.text = skills[skillCounter]
	$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	var next_name = get_next_name(currentNamesToDisplay)
	if next_name:
		$Names.text = next_name
	else:
		var next_skill = get_next_skill()
		set_current_names(next_skill)
		$Skills.text = next_skill
		$Names.text = currentNamesToDisplay[0]
	$AnimationPlayer.play("fade")

func get_next_name(nameArray):
	nameCounter += 1
	if nameCounter < nameArray.size():
		return nameArray[nameCounter]
	else:
		nameCounter = 0
		return
	
func get_next_skill():
	skillCounter += 1
	if skillCounter == skills.size():
		skillCounter = 0
	return skills[skillCounter]
		
func set_current_names(currentSkill : String):
	nameCounter = 0
	match currentSkill:
		"Programming":
			currentNamesToDisplay = progs
		"Art works":
			currentNamesToDisplay = artists
		"Script writing":
			currentNamesToDisplay = script_writer
		"Cooking (thanks!)":
			currentNamesToDisplay = feeder