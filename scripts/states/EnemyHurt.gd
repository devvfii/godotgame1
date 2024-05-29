extends State
class_name EnemyHurt

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player: CharacterBody2D
var direction: Vector2

func Enter():
	state_name = "Hurt"
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(delta: float):
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, 4.5)

func _on_hurt_box_was_hurt(attack):
	direction = attack.direction
	enemy.velocity = direction.normalized() * move_speed
