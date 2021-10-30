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
    
    func getDiscountCalculator(calculatorType: String) ->DiscountCalculator {
        
        var calculator: DiscountCalculator?
        
        var caclulatorsList: [String: DiscountCalculator]?
        
        print(caclulatorsList)
        
        if caclulatorsList?[calculatorType] != nil {
            print("Object Already Exist")
            return caclulatorsList?[calculatorType] ?? DayDiscountCalculator()
        }
        else {
            
            print("Object Not Exist -> Create New One")
            
            switch calculatorType {
            case "day":
                calculator = DayDiscountCalculator()
                caclulatorsList?[calculatorType] = calculator
                break
            case "item":
                calculator = ItemDiscountCalculator()
                caclulatorsList?[calculatorType] = calculator
                break
            default:
                calculator = DayDiscountCalculator()
                caclulatorsList?[calculatorType] = calculator
                break
            }
            
        }
        
        return calculator ?? DayDiscountCalculator()
    }
}

let discountFactory = DiscountFactory()
var calculator1 = discountFactory.getDiscountCalculator(calculatorType: "day")
var discountValue1 = calculator1.getDiscount(date: Date(), itemID: nil)

print(discountValue1)

var calculator2 = discountFactory.getDiscountCalculator(calculatorType: "day")
var discountValue2 = calculator2.getDiscount(date: Date(), itemID: nil)

print(discountValue2)
