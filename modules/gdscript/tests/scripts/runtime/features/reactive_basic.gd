extends RefCounted

@reactive
var health: int = 100

@reactive  
var name: String = "Player"

@reactive
var position: Vector2 = Vector2.ZERO

var signal_received_count = 0
var last_old_value = null
var last_new_value = null

func test():
	# Connect to the reactive signals
	@warning_ignore("return_value_discarded")
	health_changed.connect(_on_health_changed)
	@warning_ignore("return_value_discarded")
	name_changed.connect(_on_name_changed) 
	@warning_ignore("return_value_discarded")
	position_changed.connect(_on_position_changed)
	
	# Test integer property change
	health = 75
	
	assert(signal_received_count == 1, "Signal should have been received once")
	
	name = "Hero"

	assert(signal_received_count == 2, "Signal should have been received twice")
	
	# Test Vector2 property change
	position = Vector2(10, 20)

	assert(signal_received_count == 3, "Signal should have been received three times")

func _on_health_changed(old_value, new_value):
	signal_received_count += 1
	last_old_value = old_value
	last_new_value = new_value

func _on_name_changed(old_value, new_value):
	signal_received_count += 1
	last_old_value = old_value 
	last_new_value = new_value

func _on_position_changed(old_value, new_value):
	signal_received_count += 1
	last_old_value = old_value
	last_new_value = new_value
