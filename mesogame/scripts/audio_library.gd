extends Node


enum sfx {
	PAGE_FLIP,
	PLOP_PLOP,
	PLOP_FLAT,
	LIQUID,
	FRAGILE,
	QUOTA,
	WRONG,
	SWOOSH
}


func play_sfx(s: sfx):
	if s == sfx.PAGE_FLIP:
		pass
	elif s == sfx.PLOP_PLOP:
		pass
	elif s == sfx.PLOP_FLAT:
		pass
	elif s == sfx.LIQUID:
		pass
	elif s == sfx.FRAGILE:
		pass
	elif s == sfx.QUOTA:
		pass
	elif s == sfx.WRONG:
		pass
	elif s == sfx.SWOOSH:
		$Swoosh.play(4.0)
