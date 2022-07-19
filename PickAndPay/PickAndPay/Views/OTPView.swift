//
//  OTPView.swift
//  PickAndPay
//
//  Created by admin on 7/10/22.
//

import SwiftUI

struct OTPView: View {
    private var msg: String = "1234"
    //8. Observe the notification manager in your SwiftUI view
    @ObservedObject var notificationManager = OTPViewModel()
    @State private var showingAlert = false
    @State var showFootnote = false
    @State var passed: Bool = false
    @State var otpText: String = ""
    @State private var isShowingContentView = false
    @State private var username: String = ""
    @EnvironmentObject var authentication: Authentication
    var body: some View {
     
         NavigationLink(destination: MainTabView(),isActive: $isShowingContentView){EmptyView()}
            
            VStack {
                Text("Enter In Your 4 Digit Code")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .offset(y: -100)
                    .foregroundColor(.black)
    
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
                            authentication.isValidated = true
                            isShowingContentView = true
                            
                            
                        }
                }
                
            }
            .alert("\(notificationManager.otp.otp)", isPresented: $showingAlert){
                Button("OK", role: .cancel){}
            }
            .onAppear {
               showingAlert = true
                
                notificationManager.sendNotif()
            }
        }
        
    }


struct OTPView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        OTPView()
    }
}
