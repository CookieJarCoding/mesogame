extends Node


enum sfx {
	PAGE_FLIP,
	PEN_WRITE,
	PLOP_PLOP,
	PLOP_FLAT,
	LIQUID,
	FRAGILE,
	QUOTA,
	WRONG,
	SWOOSH
}

enum music {
	GAMEPLAY,
	LETTER,
	TITLE
}


func play_sfx(s: sfx):
	if s == sfx.PAGE_FLIP:
		$PageFlip.play(0.3)
	elif s == sfx.PEN_WRITE:
		$PenWrite.play(3)
	elif s == sfx.PLOP_PLOP:
		$PlopPlop.play(0.15)
	elif s == sfx.PLOP_FLAT:
		$PlopFlat.play(0.5)
	elif s == sfx.LIQUID:
		$Liquid.play(2.0)
	elif s == sfx.FRAGILE:
		$Fragile.play(0.6)
	elif s == sfx.QUOTA:
		$Quota.play(0.0)
	elif s == sfx.WRONG:
		$Wrong.play(0.0)
	elif s == sfx.SWOOSH:
		$Swoosh.play(4.0)


func play_music(s: music):
	if s == music.GAMEPLAY and not $GameplayBGM.playing:
		stop_all_music()
		$GameplayBGM.play()
	if s == music.LETTER and not $LetterBGM.playing:
		stop_all_music()
		$LetterBGM.play()
	if s == music.TITLE and not $TitleBGM.playing:
		stop_all_music()
		$TitleBGM.play()


func stop_all_music() -> void:
	$GameplayBGM.stop()
	$LetterBGM.stop()
	$TitleBGM.stop()
