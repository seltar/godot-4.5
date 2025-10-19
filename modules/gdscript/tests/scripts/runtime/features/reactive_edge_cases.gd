extends RefCounted

@reactive
var counter: int = 0

@reactive
var message: String = "start"

func test():
	@warning_ignore("return_value_discarded")
	counter_changed.connect(_on_counter_changed)
	@warning_ignore("return_value_discarded")
	message_changed.connect(_on_message_changed)
	
	print("Testing multiple assignments:")
	
	# Test rapid successive changes
	counter = 1
	counter = 2
	counter = 3
	
	message = "middle"
	message = "end"
	
	# Test same value assignment (should not trigger)
	print("Assigning same value (should not trigger signal):")
	counter = 3  # Same as current value
	message = "end"  # Same as current value
	
	# Test null/empty assignments
	message = ""
	counter = 0

func _on_counter_changed(old_value, new_value):
	print("Counter: ", old_value, " -> ", new_value)

func _on_message_changed(old_value, new_value):
	print("Message: '", old_value, "' -> '", new_value, "'")
