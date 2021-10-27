protocol SMSServiceProtocol {
    func sendSMS(sender: String, receiver: String, message: String)
}

class SMSService: SMSServiceProtocol {
    
    init() {
        
    }
    
    func sendSMS(sender: String, receiver: String, message: String) {
        print("\(sender) Sent SMS Successfully")
    }
}


class SMSServiceProxy {
    
    private var smsService: SMSService?
    
    private var sentMessagesCount: [String : Int] = [:]
    
    func sendSMS(sender: String, receiver: String, message: String) {
        
        if smsService == nil {
            smsService = SMSService()
        }
        
        // First SMS From This Sender
        if sentMessagesCount[sender] == nil {
            print("First Time")
            sentMessagesCount[sender] = 1
            smsService?.sendSMS(sender: sender, receiver: receiver, message: message)
        }
        else if sentMessagesCount[sender] ?? 0 < 100 {
            let oldValue = sentMessagesCount[sender] ?? 0
            sentMessagesCount.updateValue(oldValue + 1, forKey: sender)
            smsService?.sendSMS(sender: sender, receiver: receiver, message: message)
        }
        else {
            print("Limit Exceeded")
        }
        
        print(sentMessagesCount)

    }
}

let smsServiceProxy = SMSServiceProxy()
for _ in 0 ... 100 {
    smsServiceProxy.sendSMS(sender: "01024514575", receiver: "01024514575", message: "Message Here")
}
