extends ReferenceRect

@onready var timer = $SpinTimer
@onready var sprite = $QuarterCircleSprite2D
@onready var texture = $QuarterCircleTextureRect

func _ready():
	if self.visible:
		$SpinTimer.start()

func _on_spin_timer_timeout():
	sprite.rotate(deg_to_rad(20))
	texture.rotation_degrees += 20
