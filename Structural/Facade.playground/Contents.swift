// Facade Pattern

class CartItem {
    var id: Int = 0
    var price: Double = 0
    var quntity: Int = 0
    
    init(id: Int, price: Double, quntity: Int) {
        self.id = id
        self.price = price
        self.quntity = quntity
    }
}

class Cart {
    
    private var cartItems: [CartItem] = []
    
    func addItem(cartItem: CartItem) {
        cartItems.append(cartItem)
    }
    
    func removeOneItem(itemID: Int) {
        
        let item = cartItems.filter { $0.id == itemID }.first
        
        if item?.quntity ?? 0 > 0 {
            item?.quntity = item?.quntity ?? 1 - 1
        }
    }
    
    func getItems() -> [CartItem] {
        return cartItems
    }
    
    /* func removeItem(itemID: Int) {
        let item = cartItems.filter { $0.id == itemID } .first
    } */
}

class Inventory {
    
    func isItemAvailable(itemID: Int, quntity: Int) -> Bool {
        return quntity < 100
    }
}

class InventoryOrder {
    
    func createOrder(cart: Cart) {
        cart.getItems()
        print("Order Created Successfully")
    }
    
}

class PurchaseInvoice {
    
    var discount: Double = 0
    var totalAmount: Double = 0
    var netTotal: Double = 0
    
    func createInvoice(cart: Cart, customerName: String) -> PurchaseInvoice {
        let invoice = PurchaseInvoice()
        let items = cart.getItems()
        
        for item in items {
            invoice.totalAmount += Double(item.quntity) * item.price
        }
        
        // Apply Discount
        if items.count > 5 {
            invoice.discount = 20
        }
        
        invoice.netTotal = invoice.totalAmount - invoice.discount

        return invoice
        
    }
}

class PaymentProcessor {
    
    func handlePayment(amount: Double, bankID: String) -> Bool {
        
        if bankID != "" {
            print("Payment Done Successfully")
            return true
        }
        else {
            return false
        }
    }
}

class SMSNotification {
    
    func sendSMS(to: String, msg: String) {
        print("Message Sent Successfully")
    }
}

class PurchaseOrder {
    
    func createOrder(cart: Cart, customerInfo: String) -> Bool {
        
        var isAvailable = true
        
        let inventory = Inventory()
        
        for item in cart.getItems() {
            
            if !inventory.isItemAvailable(itemID: item.id, quntity: item.quntity) {
                isAvailable = false
            }
        }
        
        if isAvailable {
            let inventoryOrder = InventoryOrder()
            inventoryOrder.createOrder(cart: cart)
            
            let purchaseInvoice = PurchaseInvoice()
            let invoice = purchaseInvoice.createInvoice(cart: cart, customerName: customerInfo)
            
            let paymentProcessor = PaymentProcessor()
            paymentProcessor.handlePayment(amount: invoice.netTotal, bankID: "acc=123456789")
            
            let smsService = SMSNotification()
            smsService.sendSMS(to: "01012345678", msg: "Order Created Successfully")
            
            return true
        }
        else {
            return false
        }

    }
}

// Client [Request Order]

var cart = Cart()
cart.addItem(cartItem: CartItem(id: 1, price: 10, quntity: 3))
cart.addItem(cartItem: CartItem(id: 2, price: 30, quntity: 5))
cart.addItem(cartItem: CartItem(id: 3, price: 50, quntity: 4))

var purchaseOrder = PurchaseOrder()
purchaseOrder.createOrder(cart: cart, customerInfo: "Name: Taha, Bank: 123456789, Phone: 01012345678")
