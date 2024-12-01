extends CharacterBody2D
@onready var player: CharacterBody2D = $"."
@onready var spell: Area2D = $spell
@onready var collision_shape_2d2: CollisionShape2D = $spell/CollisionShape2D
@onready var mixkit_cinematic_laser_gun_thunder_1287: AudioStreamPlayer = $"Mixkit-cinematic-laser-gun-thunder-1287"
@onready var point_light_2d: PointLight2D = $PointLight2D

const SPEED = 130.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_sound_1: AudioStreamPlayer = $sounds/attackSound1
@onready var attack_sound_2: AudioStreamPlayer = $sounds/attackSound2
@onready var stronk: Timer = $stronk
@onready var hurt_sound: AudioStreamPlayer = $sounds/hurt_sound
@onready var death_timer: Timer = $death_timer
@onready var health: TextureProgressBar = $CanvasLayer/health
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var bow = false
@export var sword = true
@export var spells = false
var keys: Array = []  # List of keys the player holds
var dead = false
var maxHealth = 100
var currentHealth: int = maxHealth
var level2start = false
var cutscene = false
var oof = false
var finale = false
func _process(delta: float) -> void:

	if !spells:
		point_light_2d.visible = false
	else:
		point_light_2d.visible = true
	if level2start:
		animated_sprite.play("level2cut")
	health.value = currentHealth
	if currentHealth <= 0 && !dead:
		death()
	if cutscene:
		health.hide()
	else:
		health.show()
func _ready() -> void:
	health.value = maxHealth
	animation_player.play("RESET")
func _physics_process(delta):
	# Handle attack
	# If attacking, do not process movement
	if is_attacking() || cutscene || is_cutscene() || dead || oof:
		# Prevent movement during attack
		velocity.x = 0
		return
	if Input.is_action_just_pressed("bow") and bow:
		attack2()
	if Input.is_action_just_pressed("attack") and sword:
		attack()
	if Input.is_action_just_pressed("spell") and spells:
		attack3()
	# Get vertical input (if you still want to allow vertical movement)
	var directiony = Input.get_axis("up", "down")
	# Adjust vertical movement if needed (you can remove this part if not needed)
	velocity.y = directiony * SPEED if directiony != 0 else 0

	# Get horizontal movement input
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		animated_sprite.flip_h = 1
	if direction == 1:
		animated_sprite.flip_h = 0
	# Flip the sprite based on direction

	# Play animations based on movement input
	if direction == 0 && directiony == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

	# Apply horizontal movement
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func attack():
	print("attacking")
	attack_sound_1.play()
	if (animated_sprite.flip_h == true):
		animation_player.play("melee_flip")
	else:
		animation_player.play("melee")
func attack2():
	print("attacking2")
	if (animated_sprite.flip_h == true):
		animation_player.play("bow")
	else:
		animation_player.play("bow")
	
func attack3():
	print("attacking3")
	animation_player.play("spell")
	mixkit_cinematic_laser_gun_thunder_1287.play()
func is_attacking() -> bool:
	# Check if the attack animation is currently playing
	return (animation_player.is_playing() and
	(animation_player.current_animation == "melee" or animation_player.current_animation == "melee_flip" or 
	animation_player.current_animation == "bow" or animation_player.current_animation == "bow_flip" or animation_player.current_animation == "spell"))
func is_cutscene() -> bool:
	return level2start
func hurt_player(damage_amount):
	if damage_amount<100:
		if stronk.is_stopped() and not cutscene:
			oof = true
			animated_sprite.play("hurt")
			hurt_sound.play()
			currentHealth -= damage_amount
			print(currentHealth)
			stronk.start()
	else:
		if not cutscene:
			currentHealth -= damage_amount
func death():
	dead = true
	animated_sprite.play("death")
	print("You died!")
	Engine.time_scale = 0.1
	collision_shape_2d.queue_free()
	death_timer.start()


func _on_stronk_timeout() -> void:
	oof = false


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	var _reload = get_tree().reload_current_scene()

func has_key(key: String) -> bool:
	return key in keys

func use_key(key: String):
	if key in keys:
		keys.erase(key)


func _on_spell_body_entered(body) -> void:
	if body is CharacterBody2D and body != player:
		if body.has_method("hurt"):
			body.hurt(1000)
		spell.visible = false
		collision_shape_2d2.disabled = true
