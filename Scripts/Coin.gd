extends Area2D

# You can change these to your likings
@export var amplitude := 4
@export var frequency := 5
@onready var sprite_2d = $Sprite2D

var time_passed = 0


func _process(delta):
	coin_hover(delta) # Call the coin_hover function

# Coin Hover Animation
func coin_hover(delta):
	time_passed += delta
	sprite_2d.position.y = amplitude * sin(frequency * time_passed)

# Coin collected
func _on_body_entered(body):
	if body.is_in_group("Player"):
		AudioManager.coin_pickup_sfx.play()
		GameManager.add_score()
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		await tween.finished
		queue_free()
