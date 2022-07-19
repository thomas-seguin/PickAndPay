//
//  CartIsEmptyView.swift
//  PickAndPay
//
//  Created by admin on 7/19/22.
//

import SwiftUI

struct CartIsEmptyView: View {
    @EnvironmentObject var cartManager : CartManager
    var body: some View {

                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                        
                        Text("PickAndPay cart is empty")
                            .bold()
                            .font(.title)
                        
                        NavigationLink(destination: {
                            LoginView()
                        }, label: {
                            displayText(title: "Sign in to your account", w: 300, h: 60)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)})
                        
                        NavigationLink(destination: {
                            SignUpView()
                        }, label: {
                            displayText(title: "Sign up now", w: 300, h: 60)
                            .background(.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)})
                        
                        NavigationLink(destination: {
                            homeView()
                        }, label: {
                            displayText(title: "Continue Shopping", w: 300, h: 60)
                                .background(.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        })
                    }
                    
                

        }
        @ViewBuilder private func displayText(title: String, w: CGFloat, h: CGFloat) -> some View{
            Text(title)
                .frame(width: w, height: h, alignment: .center)
        }
}

struct CartIsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CartIsEmptyView()
    }
}
