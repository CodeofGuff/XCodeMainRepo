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


//

var array = [2, 3, 4, 5, 5]
var array2 = [1, 3, 4, 2, 5, 5] 

