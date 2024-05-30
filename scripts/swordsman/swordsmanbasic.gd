extends AnimatedSprite2D

@export var player : CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var hitbox1 = $HitBox1
@onready var hitbox2 = $HitBox2
@onready var cooldown = $Cooldown

var status := true

var direction : Vector2
var attackObj1 := Attack.new()
var attackObj2 := Attack.new()

func _ready():
	#hitbox1.disabled = true
	#hitbox2.disabled = true
	
	attackObj1.basedamage = 40
	attackObj2.basedamage = 50
	
	hitbox1.loadAttack(attackObj1)
	hitbox2.loadAttack(attackObj2)
	
func activate(aim_direction):
	if status:
		rotation = aim_direction.angle() + PI/2
		animation_player.play("basic")
		visible = true
		status = false
		cooldown.start()
	else:
		print("attack on cooldown")

func _physics_process(delta):
	global_position = player.global_position

func _on_cooldown_timeout():
	status = true


func _on_animation_player_animation_finished(anim_name):
	visible = false
