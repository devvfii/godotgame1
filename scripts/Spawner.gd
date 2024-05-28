extends Marker2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var spawn_interval_min : float = 5
@export var spawn_interval_max : float = 10

func _ready():
	spawnMob()

func spawnMob():
	get_tree().create_timer(randf_range(spawn_interval_min, spawn_interval_max)).timeout.connect(spawnMob)
	
	var slime = Slime.new_enemy(player)
	add_child(slime)
	
