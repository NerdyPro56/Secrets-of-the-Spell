extends Node2D
var done = false
@onready var textbox: CanvasLayer = $Textbox
@onready var dark_fight_music_boss_2_252590: AudioStreamPlayer = $"Dark-fight-music-boss-2-252590"
@onready var player: CharacterBody2D = $player
@onready var wizardy: Sprite2D = $wizardy
@onready var timer: Timer = $Timer
@onready var wizard: CharacterBody2D = $wizard
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var golem: CharacterBody2D = $Golem
@onready var golem_2: CharacterBody2D = $Golem2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.queue_text("Hint: spells are powerful but charge is slow")
	player.finale = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body == player and !done:
		player.cutscene = true
		done = true
		wizardy.visible = true
		textbox.queue_text("Not so fast!      ")
		textbox.queue_text("If you wanna escape you have to go through me first!          ")
		textbox.queue_text("how dare you steal my spells!          ")
		timer.start()
	

func _on_timer_timeout() -> void:
	golem.range2 = 500
	golem_2.range2 = 500
	wizard.cutscene = false
	player.cutscene = false
	wizardy.visible = false
	dark_fight_music_boss_2_252590.play()
	collision_shape_2d.disabled = false
