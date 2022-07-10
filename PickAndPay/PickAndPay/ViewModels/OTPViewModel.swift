import Foundation
import SwiftUI
class OTPViewModel: ObservableObject {
    @Published var passed: Bool = false
    @Published var otp = OTP()
    var notifs = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("notifs permited")
            } else {
                print("notifs not permit")
            }
        }
    }
    
    func sendNotif(){
        otp.otp = String(Int.random(in: 1000..<9999))
        let content = UNMutableNotificationContent()
        content.title = "OTP"
        content.subtitle = "from PickAndPay App"
        content.body = "your OTP is \(otp.otp)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "demoNotif", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("sent")
    }
    
    func checkOTP(pass: String) -> Bool {
        if pass == otp.otp{
            return true
        } else {
            return false
        }
    }
}
