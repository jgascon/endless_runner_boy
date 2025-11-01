extends Area3D

var collectible_name 
var collectibles


# Instantiate object 
func set_collectible_type(type): 
	collectibles = $Collectible 
	collectible_name = type 
	var collectible_data = Global.collectibles_resources[type] 
	var collectible_resource = collectible_data["scene"] 
	var collectible_item = collectible_resource.instantiate() 
	collectibles.add_child(collectible_item)
	

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"): 
		# apply effect 
		var effect_name = Global.collectibles_resources[collectible_name]["effect"] 
		body.apply_effect(effect_name)
		queue_free()
