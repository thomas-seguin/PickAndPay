//
//  AccountMenuView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AccountMenuView: View {
    let userDefaults = UserDefaults()
    @EnvironmentObject var authentication: Authentication
    @State private var isShowingMainView = false
    var body: some View {
       
            ZStack{
                NavigationLink(destination: MainTabView(), isActive: $isShowingMainView) { EmptyView()}
                VStack{
                    HStack{
                        Text("Account Settings")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                        Spacer()
                    }
                    HStack{
                        Text("Account")
                            .padding()
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                    NavigationLink(destination: AccountView()){
                        HStack{
                            Text("My Profile")
                                .foregroundColor(.black)
                                .padding(.trailing, 250)
                                .font(.system(size: 20))
                            
                            Image(systemName: "chevron.right")
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                    }
                    
                    NavigationLink(destination: AccountLoginView()){
                        HStack{
                            Text("Login & Security")
                                .foregroundColor(.black)
                                .padding(.trailing, 195)
                                .font(.system(size: 20))
                            
                            Image(systemName: "chevron.right")
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                    }
                    
                    NavigationLink(destination: MangeCardView()){
                        HStack{
                            Text("Manage Credit Cards")
                                .foregroundColor(.black)
                                .padding(.trailing, 150)
                                .font(.system(size: 20))
                            
                            Image(systemName: "chevron.right")
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                    }
                    VStack{
                        NavigationLink(destination: MangeBalanceView()){
                            HStack{
                                Text("Manage Balance")
                                    .foregroundColor(.black)
                                    .padding(.trailing, 180)
                                    .font(.system(size: 20))
                                
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                        }
                        
                        
                        
                        NavigationLink(destination: WishListView()){
                            HStack{
                            Text("Wish List")
                                    .foregroundColor(.black)
                                .padding(.trailing, 250)
                                .font(.system(size: 20))
                                
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                        }
                        NavigationLink(destination: BrowsingHistoryView()){
                            HStack{
                            Text("Browse History")
                                    .foregroundColor(.black)
                                .padding(.trailing, 200)
                                .font(.system(size: 20))
                                
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                        }
                        Button {
                            userDefaults.set(false, forKey: "remember")
                            authentication.isValidated = false
                            //isShowingMainView = true
                        }label: {
                            HStack{
                                Text("Sign Out")
                                   
                                    .padding(.trailing, 260)
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                        }
                    }
                    HStack{
                        Text("Orders")
                            .padding()
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                    NavigationLink(destination: BrowsingHistoryView()){
                        HStack{
                            Text("Order History")
                                .foregroundColor(.black)
                                .padding(.trailing, 200)
                                .font(.system(size: 20))
                            
                            Image(systemName: "chevron.right")
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                    }
                    .offset(y: -20)
                    Spacer()
                }
            }
        }
    }


struct AccountMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AccountMenuView()
    }
}
