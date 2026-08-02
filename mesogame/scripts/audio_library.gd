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
		$PageFlip.play(0.0)
	elif s == sfx.PLOP_PLOP:
		$PlopPlop.play(0.15)
	elif s == sfx.PLOP_FLAT:
		$Plop_Flat.play(0.5)
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
