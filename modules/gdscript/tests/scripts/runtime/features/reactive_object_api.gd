extends RefCounted

var test_object: Object
var signal_count: int = 0

func test():
	test_object = RefCounted.new()
	
	# Test Object methods for reactive properties
	print("Testing Object reactive property methods")
	
	# Test setting a property as reactive
	test_object.set_property_reactive("test_prop", true)
	print("Is test_prop reactive: ", test_object.is_property_reactive("test_prop"))
	
	# Get the signal name for the reactive property
	var signal_name = test_object.get_property_signal_name("test_prop")
	print("Signal name for test_prop: ", signal_name)
	
	# Connect to the reactive signal
	if signal_name != StringName():
		@warning_ignore("return_value_discarded")
		test_object.connect(str(signal_name), _on_property_changed)
	
	# Set the property via metadata (should trigger reactive signal)
	test_object.set_meta("test_prop", "initial_value")
	test_object.set_meta("test_prop", "changed_value")
	
	# Test removing reactive property
	test_object.set_property_reactive("test_prop", false)
	print("Is test_prop reactive after removal: ", test_object.is_property_reactive("test_prop"))
	
	# This should not trigger signal anymore
	test_object.set_meta("test_prop", "final_value")
	
	print("Total signals received: ", signal_count)

func _on_property_changed(old_value, new_value):
	signal_count += 1
	print("Property changed signal: ", old_value, " -> ", new_value)
