extends RefCounted

# This should cause a parser error - @reactive on function
@reactive
func invalid_function():
	pass

func test():
	print("This should not run due to parser error")
