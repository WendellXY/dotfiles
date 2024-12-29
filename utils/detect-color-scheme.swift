import Foundation

let dict = UserDefaults.standard.persistentDomain(forName: UserDefaults.globalDomain)
if let style = dict?["AppleInterfaceStyle"] as? String {
	print("\(style.lowercased())")
} else {
	print("light")
}
