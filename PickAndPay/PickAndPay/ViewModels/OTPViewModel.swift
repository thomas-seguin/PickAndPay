import Foundation
import SwiftUI
class OTPViewModel: ObservableObject {
    let userDB = DBHelper.dbHelper
    let userDefault = UserDefaults()
    @Published var passed: Bool = false
    @Published var otp = OTP()
    var notifs = [Notification]()
    
    init() {
        print("IN OTP")
        print(userDB.getUser(username: getUsername() as NSString))
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                //print("notifs permited")
            } else {
                print("notifs not permit")
            }
        }
    }
    
    func getUsername() -> String {
        return userDefault.string(forKey: "username") ?? "unkown"
    }
    
    func sendNotif(){
        
        otp.otp = String(Int.random(in: 1000..<9999))
        print(otp.otp)
        let content = UNMutableNotificationContent()
        content.title = "OTP"
        content.subtitle = "from PickAndPay App"
        content.body = "your OTP is \(otp.otp)"
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "otpNotif", content: content, trigger: trigger)
        
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
    
    func goodOTP(username: String){
        userDB.updateVerifyUser(verified: 1, username: getUsername() as NSString)
    }
}
