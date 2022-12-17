extends Node

const level_1 = preload("res://Music/Intro Theme.mp3")
const level_2 = preload("res://Music/Worldmap Theme.mp3")


# sound_player.tscn needs to be an autoload for this to work

@onready var audioPlayers: = $AudioPlayers

func play_music(music):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = music
			audioStreamPlayer.play()
			break
			
func stop_music():
	for audioStreamPlayer in audioPlayers.get_children():
		if audioStreamPlayer.playing:
			audioStreamPlayer.stop()
			break
