extends RefCounted

# This should cause a parser error - @reactive on static variable
@reactive
static var invalid_static: int = 0

func test():
	print("This should not run due to parser error")
