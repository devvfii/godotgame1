extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player: CharacterBody2D

func Enter():
	state_name = "Follow"
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 10:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
		
	if direction.length() > 80:
		Transitioned.emit(self, "idle")
