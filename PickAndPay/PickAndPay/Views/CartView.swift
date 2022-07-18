//
//  CartView.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager : CartManager
    var body: some View {
        if cartManager.products.count > 0 {
            ScrollView {
                Text("My Cart").bold().font(.largeTitle)
                ForEach(cartManager.products, id: \.productId){ product in
                        ProductRow(product: product)
                    }
                VStack {
                    HStack{
                            Text("Your cart total is")
                                .bold()
                            Spacer()
                            Text(String(format:"$%.2f", cartManager.total))
                                .bold()
                    }.frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        Text("Payment Options")
                            .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                            .background(.yellow)
                        .cornerRadius(10)
                    }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                }
                
            }
            
        }else{
            NavigationView{
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
                        displayText(title: "Login yo your account", w: 300, h: 60)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                    
                    NavigationLink(destination: {
                        SignUpView()
                    }, label: {
                        displayText(title: "Sign Up Now", w: 300, h: 60)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                    

                    NavigationLink(destination: {
                        Catalogue()
                    }, label: {
                        displayText(title: "Continue Shopping", w: 300, h: 60)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })

                    /*NavigationLink(destination: {
                        print("login") //LoginView()
                    }, label: {
                        displayText(title: "Sign in to your account", w: 300, h: 60)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                    NavigationLink(destination: {
                        print("sign up") //LoginView()
                    }, label: {
                        displayText(title: "Sign up now", w: 300, h: 60)
                            .background(.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    })
                    NavigationLink(destination: {
                        print("catalogue") //MenuView()
                    }, label: {
                        displayText(title: "Continue Shopping", w: 300, h: 60)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })*/
                    
                }
                
            }
        }

    }
    @ViewBuilder private func displayText(title: String, w: CGFloat, h: CGFloat) -> some View{
        Text(title)
            .frame(width: w, height: h, alignment: .center)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager(quantity: 0))
    }
}
