// Decorator Pattern With Proxy Pattern

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

class EmailAbstractDecorator: SMSServiceProtocol {
    
    var emailService: SMSServiceProtocol?
        
    func setService(service: SMSServiceProtocol) {
        emailService = service
    }
    
    func sendSMS(sender: String, receiver: String, message: String) {
        if emailService != nil {
            emailService?.sendSMS(sender: sender, receiver: receiver, message: message)
        }
        else {
            print("Email Service Configuration Not Initialized")
        }
    }

}

class EmailDecorator: EmailAbstractDecorator {
    
    func sendEmailNotification(sender: String, message: String) {
        print("Email Notification Sent")
    }
    
    override func sendSMS(sender: String, receiver: String, message: String) {
        
        super.sendSMS(sender: sender, receiver: receiver, message: message)
        sendEmailNotification(sender: sender, message: message)
        
    }

}


// If you want to use SMSSendSMS Proxy, Use this code
/*
 let smsServiceProxy = SMSServiceProxy()
 for _ in 0 ... 100 {
     smsServiceProxy.sendSMS(sender: "01024514575", receiver: "01024514575", message: "Message Here")
 }
*/

// If you want to use SMSSendSMS With Notification Decorator, Use this code
let smsService: SMSService = SMSService()
var emailDecorator: EmailDecorator = EmailDecorator()
emailDecorator.setService(service: smsService)
emailDecorator.sendSMS(sender: "01024514575", receiver: "01024514575", message: "Message Here")
