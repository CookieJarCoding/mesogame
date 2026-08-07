extends Area2D


class_name TileCollision


var hovered_over: bool = false
var draggable: bool = false

#@export var isvisible: bool = false
@onready var north_ray: RayCast2D = $NorthRay
@onready var south_ray: RayCast2D = $SouthRay
@onready var west_ray: RayCast2D = $WestRay
@onready var east_ray: RayCast2D = $EastRay
@onready var rays = [north_ray, south_ray, west_ray, east_ray]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ColorRect.visible = Globals.show_tiles
	#print(Globals.show_tiles)
	
	if ($Collision.global_position.x - $Collision.shape.size.x/2 < get_global_mouse_position().x and get_global_mouse_position().x < $Collision.global_position.x + $Collision.shape.size.x/2) and ($Collision.global_position.y - $Collision.shape.size.y/2 < get_global_mouse_position().y and get_global_mouse_position().y < $Collision.global_position.y + $Collision.shape.size.y/2):
		if not Globals.is_dragging:
			hovered_over = true
			#draggable = true
			#scale = Vector2(1.05, 1.05)
	else:
		if not Globals.is_dragging:
			hovered_over = false
			#draggable = false
			#scale = Vector2(1, 1)
	

	#var item_parent = self.get_parent().get_parent()
	# collide([item_parent.fragile, item_parent.soft, item_parent.liquid_container, item_parent.liquid_risk, item_parent.wrapped])

	# item_properties: Array[bool]
	
	

func collide() -> Array:
	var item_collisions = []

	for ray: RayCast2D in rays:
		if ray.is_colliding():
			var opposite_item
			
			if ray.get_collider().get_parent() == self.get_parent() or not ray.get_collider().get_parent().get_parent().visible:
				# print(ray.get_collider().get_parent().get_parent().name)
				opposite_item = self.get_parent().get_parent()
			else:
				opposite_item = ray.get_collider().get_parent().get_parent()

			if opposite_item is Node2D:
				item_collisions.append(opposite_item)
			else:
				item_collisions.append(null)
		else:
			item_collisions.append(null)
			
	return item_collisions
		

			
