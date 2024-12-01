extends CharacterBody2D  # Or KinematicBody2D if you're using Godot 3.x
@onready var player: CharacterBody2D = $"../player"

# Movement variables
@export var speed: float = 100
var health: int = 1  # Example health value
var direction: Vector2 = Vector2.ZERO

@onready var change_direction_timer: Timer = $ChangeDirectionTimer

func _ready():
	# Start the timer to switch directions
	change_direction_timer.start()

func _physics_process(delta):
	# Move in the current direction
	velocity = direction * speed
	move_and_slide()

func _on_ChangeDirectionTimer_timeout():
	# Randomly pick a new direction
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()

func hurt(damage: int):
	health -= damage
	if health <= 0:
		drop_key()
		queue_free()  # Remove the bat from the scene

func drop_key():
	player.keys.append("key")
