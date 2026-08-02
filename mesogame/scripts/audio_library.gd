extends Node


enum sfx {
	SWOOSH
}


func play_sfx(s: sfx):
	if s == sfx.SWOOSH:
		$Swoosh.play(4.0)
