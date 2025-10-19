extends Node

@reactive
static var global_counter: int = 0

func test():
	@warning_ignore("return_value_discarded")
	global_counter_changed.connect(_on_global_counter_changed)
	
	# Test static property change
	global_counter = 42
	

func _on_global_counter_changed(old_value, new_value):
	print("Static global_counter changed: ", old_value, " -> ", new_value)
