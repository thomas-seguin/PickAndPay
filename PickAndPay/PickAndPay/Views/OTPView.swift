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
    @State private var isShowingContentView = false
    @State private var username: String = ""
    
    var body: some View {
        NavigationView {
           // NavigationLink(destination: ContentView(),isActive: $isShowingContentView){EmptyView()}
            
            VStack {
                Text("Enter In Your 4 Digit Code")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .offset(y: -100)
                    .foregroundColor(.text)
    
                TextField("1234", text: $otpText)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .onChange(of: otpText) { newValue in
                        passed = notificationManager.checkOTP(pass: newValue)
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)

                if passed{
                    Text("passed")
                        .onAppear {
                            notificationManager.goodOTP(username: username)
                            
                        }
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
