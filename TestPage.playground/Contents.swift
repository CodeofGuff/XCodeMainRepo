import Cocoa


func boolToWord(_ bool: Bool) -> String {
	
	if bool == true {
		return "Yes"
	} else {
		return "No"
	}
	
}

var untrue = boolToWord(false)

print(untrue)


func greet(_ name: String) -> String {
	
	return "Hello \(name) how are you doing today?"
	
	
}

var diane = greet("Diane")

print(diane)
