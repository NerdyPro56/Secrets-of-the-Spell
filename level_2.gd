extends Node2D
@onready var player: CharacterBody2D = $player
@onready var timer: Timer = $Timer
@onready var high_pitched_ringing_88473: AudioStreamPlayer = $"High-pitched-ringing-88473"
@onready var atmosphere_dark_fantasy_dungeon_synthpiano_verse_248215: AudioStreamPlayer = $"Atmosphere-dark-fantasy-dungeon-synthpiano-verse-248215"
@onready var delay: Timer = $delay
@onready var textbox: CanvasLayer = $Textbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.level2start = true
	high_pitched_ringing_88473.play()
	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.stop()
	player.level2start = false
	high_pitched_ringing_88473.stop()
	delay.start()


func _on_delay_timeout() -> void:
	delay.stop()
	atmosphere_dark_fantasy_dungeon_synthpiano_verse_248215.play()


func _on_learn_attack_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		textbox.queue_text("Space or Left Click to attack")


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
