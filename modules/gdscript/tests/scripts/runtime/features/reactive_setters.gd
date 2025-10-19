extends RefCounted

@reactive
var _internal_value: int = 0

var value: int:
	get:
		return _internal_value
	set(new_val):
		_internal_value = new_val

@reactive  
var computed_internal_value: int:
	get:
		return _internal_value * 2
	set(new_val):
		@warning_ignore("integer_division")
		_internal_value = new_val / 2

@reactive  
var computed_setter_value: int:
	set(new_val):
		@warning_ignore("integer_division")
		value = new_val * 2

var signal_count = 0

func test():
	@warning_ignore("return_value_discarded")
	_internal_value_changed.connect(_on_internal_value_changed)
	@warning_ignore("return_value_discarded")
	computed_internal_value_changed.connect(_on_computed_value_changed)
	@warning_ignore("return_value_discarded")
	computed_setter_value_changed.connect(_on_computed_value_changed)
	
	computed_internal_value = 20

	assert(signal_count == 1, "Computed internal value signal should have been triggered")

	computed_setter_value = 40

	assert(signal_count == 2, "Computed setter value signal should have been triggered")

	_internal_value = 15

	assert(signal_count == 3, "Internal value signal should have been triggered")

func _on_internal_value_changed(_old_value, _new_value):
	signal_count += 1

func _on_computed_value_changed(_old_value, _new_value):
	signal_count += 1
