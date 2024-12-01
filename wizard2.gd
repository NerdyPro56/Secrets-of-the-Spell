extends CharacterBody2D  # Or KinematicBody2D if you're using Godot 3.x
@onready var player: CharacterBody2D = $"../player"
@onready var textbox: CanvasLayer = $"../Textbox"
@onready var _11_human_damage_3: AudioStreamPlayer = $"11HumanDamage3"
@onready var _08_human_charge_1: AudioStreamPlayer = $"08HumanCharge1"
@onready var timer_2: Timer = $Timer2

# Movement variables
@export var speed: float = 150
var health: int = 4000  # Example health value
var direction: Vector2 = Vector2.ZERO
var cutscene = true
@onready var change_direction_timer: Timer = $ChangeDirectionTimer
var counter = 0
var shield = true
var done = false
func _ready():
	# Start the timer to switch directions
	change_direction_timer.start()

func _physics_process(delta):
	# Move in the current direction
	if !cutscene:
		velocity = direction * speed
		move_and_slide()

func hurt(damage: int):
	if damage == 20 and shield:
		counter += 1
		textbox.queue_text("Ow! My shield!        ")
		_08_human_charge_1.play()
	if counter == 5 and !done:
		done = true
		textbox.queue_text("NOO! My shield is gone! Good thing the knight sucks at using magic            ")
		shield = false
	if damage == 1000 and shield:
		textbox.queue_text("You can't defeat me! I have a shield against magic!       ")
	if (damage == 1000 or damage == 20) and !shield:
		health -= damage
		_11_human_damage_3.play()
	if health <= 0:
		textbox.queue_text("Well done... You have proven yourself worthy          ")
		textbox.queue_text("I am a weak wizard who can only run. take my spells          ")
		Engine.time_scale = 0.1
		timer_2.start()

func _on_change_direction_timer_timeout() -> void:
	# Randomly pick a new direction
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()


func _on_timer_timeout() -> void:
	speed = 100


func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
