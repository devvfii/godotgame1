extends Node2D

@onready var sprite = $Sprite

@export var maxDistance : int 

var direction : Vector2
var mousepos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mousepos = get_global_mouse_position()
	direction = global_position.direction_to(mousepos)
	
	sprite.offset = Vector2(0, -clamp(global_position.distance_to(mousepos), 3, maxDistance))
	sprite.rotation = direction.angle() + PI/2
