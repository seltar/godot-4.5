extends RefCounted

class_name ReactiveBase

@reactive
var base_value: int = 42

func test():
	print("Base class test")
	@warning_ignore("return_value_discarded")
	base_value_changed.connect(_on_base_value_changed)
	
	print("Initial base_value: ", base_value)
	base_value = 100
	
	var derived = ReactiveDerived.new()
	derived.test_inheritance()

func _on_base_value_changed(old_value, new_value):
	print("Base value changed: ", old_value, " -> ", new_value)

class ReactiveDerived extends ReactiveBase:
	@reactive
	var derived_value: String = "test"
	
	func test_inheritance():
		print("Derived class test")
		
		# Connect to both base and derived signals
		@warning_ignore("return_value_discarded")
		base_value_changed.connect(_on_base_inherited_changed)
		@warning_ignore("return_value_discarded")
		derived_value_changed.connect(_on_derived_value_changed)
		
		print("Initial derived_value: ", derived_value)
		print("Initial inherited base_value: ", base_value)
		
		# Test changing inherited reactive property
		base_value = 200
		
		# Test changing derived reactive property  
		derived_value = "modified"
		
	func _on_base_inherited_changed(old_value, new_value):
		print("Base inherited value changed: ", old_value, " -> ", new_value)
		
	func _on_derived_value_changed(old_value, new_value):
		print("Derived value changed: ", old_value, " -> ", new_value)
