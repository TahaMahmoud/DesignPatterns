// Prototype

class SmartPhone {
    
    var name: String
    var manufacture: String
    var color: String
    var capacity: Int
    
    // Designed Initializer
    init(name: String, manufacture: String, color: String, capacity: Int) {
        self.name = name
        self.manufacture = manufacture
        self.color = color
        self.capacity = capacity
        
    }
    
    // Prototype pattern in action
    func clone(name: String? = nil, manufacture: String? = nil, color: String? = nil, capacity: Int? = nil) -> SmartPhone {
        let cloneName = name == nil ? self.name : name!
        let cloneManufacture = manufacture == nil ? self.manufacture : manufacture!
        let cloneColor = color == nil ? self.color : color!
        let cloneCapacity = capacity == nil ? self.capacity : capacity!
        
        return SmartPhone(name: cloneName, manufacture: cloneManufacture, color: cloneColor, capacity: cloneCapacity)
    }
}

var iPhone7Gray16G = SmartPhone(name: "iPhone 7", manufacture: "Apple", color: "Gray", capacity: 16)
var iPhone7Gray64G = iPhone7Gray16G.clone(capacity: 64)
var iPhone7White64G = iPhone7Gray64G.clone(color: "White")
var samsungS8White64G = iPhone7White64G.clone(name: "Samsung S8", manufacture: "Samsung")
var samsungS8Blue64G = samsungS8White64G.clone(color: "Blue")
