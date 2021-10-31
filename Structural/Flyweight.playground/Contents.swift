// Flyweight With FactoryMethod

import Foundation

protocol DiscountCalculator {
    func getDiscount(date: Date, itemID: Int?) -> Double
}

class DayDiscountCalculator: DiscountCalculator {
    
    func getDiscount(date: Date, itemID: Int?) -> Double {
        return 0.15
    }
    
}

class ItemDiscountCalculator: DiscountCalculator {
    
    func getDiscount(date: Date, itemID: Int?) -> Double {
        return 0.10
    }
}

class DiscountFactory {
    
    private var caclulatorsList: [String: DiscountCalculator] = [String: DiscountCalculator]()
    var calculator: DiscountCalculator?
    
    func getDiscountCalculator(calculatorType: String) -> DiscountCalculator {
                
        if caclulatorsList[calculatorType] != nil {
            print("Object Already Exist")
            return caclulatorsList[calculatorType] ?? DayDiscountCalculator()
        }
        else {
            
            print("Object Not Exist -> Create New One")
            
            switch calculatorType {
            case "day":
                calculator = DayDiscountCalculator()
            case "item":
                calculator = ItemDiscountCalculator()
            default:
                calculator = DayDiscountCalculator()
            }
            
            caclulatorsList[calculatorType] = calculator
            
            return calculator ?? DayDiscountCalculator()
        }
        
    }
}

let discountFactory = DiscountFactory()

var calculator1 = discountFactory.getDiscountCalculator(calculatorType: "day")
var discountValue1 = calculator1.getDiscount(date: Date(), itemID: nil)
// Object Not Exist -> Create New One
print(discountValue1)

var calculator2 = discountFactory.getDiscountCalculator(calculatorType: "day")
var discountValue2 = calculator2.getDiscount(date: Date(), itemID: nil)
// Object Already Exist
print(discountValue2)

var calculator3 = discountFactory.getDiscountCalculator(calculatorType: "item")
var discountValue3 = calculator3.getDiscount(date: Date(), itemID: nil)
// Object Not Exist -> Create New One
print(discountValue3)
