extends OmniLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.play()
	$AnimationPlayer.play("new_animation")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AudioStreamPlayer3D.playing == false:
		$AudioStreamPlayer3D.play()
