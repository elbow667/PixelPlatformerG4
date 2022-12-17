extends Area2D

@export_file("*.tscn") var target_level_path: String = ""

var player = false

func go_to_next_room():
	Transitions.play_exit_transition()
	get_tree().paused = true
	await Transitions.transition_completed
	Transitions.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene_to_file(target_level_path)
	
func _process(_delta):
	if not player: return
	if not player.is_on_floor(): return
	if Input.is_action_just_pressed("enter_door"):
		if target_level_path.is_empty(): return
		MusicPlayer.stop_music()
		go_to_next_room()
		
func _on_body_entered(body):
	if not body is Player: return
	player = body
	if target_level_path.is_empty(): return


func _on_body_exited(body):
	if not body is Player: return
	player = null
	
