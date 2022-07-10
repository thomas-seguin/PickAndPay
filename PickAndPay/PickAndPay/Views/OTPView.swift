//
//  OTPView.swift
//  PickAndPay
//
//  Created by admin on 7/10/22.
//

import SwiftUI

struct OTPView: View {
    //8. Observe the notification manager in your SwiftUI view
       @ObservedObject var notificationManager = OTPViewModel()
       
       @State var showFootnote = false
       @State var passed: Bool = false
    @State var otpText: String = ""
       
       var body: some View {
           NavigationView {
               VStack {
                   Text("Enter in your OTP")
                   TextField("123456789", text: $otpText)
                       .onChange(of: otpText) { newValue in
                           passed = notificationManager.checkOTP(pass: newValue)
                       }
                   if passed{
                   Text("passed")
                   } else {
                       Text("failed")
                   }

               }
               .onAppear {
                   notificationManager.sendNotif()
               }
           }
       }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
