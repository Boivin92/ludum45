extends Node2D

signal transition_completed()

var must_transition := false
var step : int = 0
export(PackedScene) var flareScene

func _ready() -> void:
	$DialogBox.text = poems[step]
	step += 1
	
export(Array, String, MULTILINE) var poems = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_play_transition"):
		$AnimationPlayer.play("transition" + str(step))

func transition_to_next():
	$AnimationPlayer.play("transition" + str(step))

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if step == poems.size():
		emit_signal("transition_completed")
		return
	
	$DialogBox.bbcode_text = poems[step]
	step += 1

func _on_Grid_matched(match_info) -> void:
	print("Count:" + str(match_info.count) + " Cascades:" + str(match_info.cascade))
	spawn_light_flare(match_info.count + match_info.cascade)
	if match_info.has_type(MatchInfo.Types.Gear):
		must_transition = true

func _on_Grid_cascade_finished() -> void:
	if must_transition:
		transition_to_next()
		must_transition = false

func spawn_light_flare(number : int):
	for i in number:
		var posX = rand_range(200,1400) - 700
		var posY = rand_range(100,800) - 450
		var newFlare = flareScene.instance()
		newFlare.position = Vector2(posX, posY)
		newFlare.set_wait(rand_range(0 , 1.5))
		$Lights.add_child(newFlare)