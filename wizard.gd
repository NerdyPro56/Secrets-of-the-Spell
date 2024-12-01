extends StaticBody2D
@onready var player: CharacterBody2D = $"../player"
@onready var textbox: CanvasLayer = $"../Textbox"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer_2: Timer = $Timer2
@onready var interact_1: Area2D = $"../interact1"
@onready var _11_human_damage_3: AudioStreamPlayer = $"11HumanDamage3"
@onready var timer_3: Timer = $Timer3
@onready var e2: Sprite2D = $e
@onready var fire: AudioStreamPlayer = $"../fire"

var e = false
var talking = false
var f = false

var scene = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !scene:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	if talking and (textbox.current_state == textbox.State.FINISHED or textbox.current_state == textbox.State.READY) and e and f:
		fire.stop()
		animation_player.play("wand")
		e = false
		f = false
		timer_3.start()
		print("starting")
func hurt(amount: int):
	print("hurting")
	_11_human_damage_3.play()
	player.cutscene = true
	talking = true
	interact_1.talking = true
	e2.hide()
	textbox.queue_text("Hmph                ")
	textbox.queue_text("Nice try...         ")
	textbox.queue_text("Dodge this!        ")
	f = true
	timer_2.start()

func _on_timer_2_timeout() -> void:
	e = true


func _on_timer_3_timeout() -> void:
	scene = false
