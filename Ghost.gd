extends CharacterBody2D

var SPEED = 100

@onready var attack_timer = $AttackTimer
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D


@onready var player = null
var randomnum
var health = 1000
enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

func _ready():
	velocity = Vector2.ZERO
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	attack_timer.start()

	# Ensure player is assigned after the scene is ready
	player = get_parent().get_node("player")  # Update the path to your player node if necessary

func _physics_process(delta):
	if not player:
		return  # Ensure player is set before proceeding
	if health <= 0:
		collision_shape_2d.disabled = true
		animated_sprite_2d.visible = false
		queue_free()
		return
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
			if (global_position - player.global_position).length() < 26:  # Adjust the distance threshold as needed
				state = HIT
		HIT:
			perform_attack()
			state = SURROUND
			randomnum = randf()

func move(target, delta):
	if (global_position - player.global_position).length() < 150:
		var direction = (target - global_position).normalized()
		var desired_velocity = direction * SPEED
		var steering = (desired_velocity - velocity) * delta * 2.5
		velocity += steering
		move_and_slide()  # Call the function with the velocity argument
func get_circle_position(random):
	var kill_circle_centre = player.global_position
	var radius = 40  # Distance from center to circumference of circle
	var angle = random * PI * 2
	var x = kill_circle_centre.x + cos(angle) * radius
	var y = kill_circle_centre.y + sin(angle) * radius

	return Vector2(x, y)

func perform_attack():
	print("HIT")
	player.hurt_player(6)

func _on_AttackTimer_timeout():
	state = ATTACK
func hurt(x):
	print("ow")
	health -= x
