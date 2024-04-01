extends Node


const LAWNMOWER_START = 'start'
const LAWNMOWER_LOOP = 'loop'
const LAWNMOWER_IMPACT = 'impact'
const PICKUP_SOUND = 'pickup'


var SOUNDS = {
	LAWNMOWER_START : preload("res://audio/lawnmower/start.wav"),
	LAWNMOWER_LOOP : preload("res://audio/lawnmower/loop.wav"),
	LAWNMOWER_IMPACT : preload("res://audio/lawnmower/impact.wav"),
	PICKUP_SOUND : preload("res://audio/new_powerup.wav")
}


func play_clip(player: AudioStreamPlayer2D, clip_key: String):
	if SOUNDS.has(clip_key) == false:
		print('audio clip: ',clip_key,' not found')
		return
	player.stream = SOUNDS[clip_key]
	player.play()
