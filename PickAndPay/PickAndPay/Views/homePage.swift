//
//  SwiftUIView.swift
//  PickAndPay
//
//  Created by James Suresh on 2022-07-04.
//

import SwiftUI
let colors : [Color] = [.red,.blue,.green, .blue]
struct tiles {
    var id : Int
    var title : String
}
struct homeView: View {
    
    let categories : [tiles] = [
        tiles(id: 0, title: "Electronics"),
        tiles(id: 1, title: "Books"),
        tiles(id: 2, title: "Grocery"),
        tiles(id: 3, title: "Home Supplies"),
        tiles(id: 4, title: "Fashion")
    ]

   
    @State var searchText = ""
    var body: some View {
        
        NavigationView{
            VStack{
                
                  
                 
                TextField("Search", text: $searchText)
                
                HStack{
                    ForEach(categories, id: \.id)
                    {tiles in
                        tileView(thisTile: tiles)
                    }
                }
                
                tabView().frame(height: 200)
                
                
                HStack{
                    options()
                        .frame(width: UIScreen.main.bounds.width/2)
                    Spacer()
                    signIn()
                    
                }
                videoView()
                Spacer()
            }
            
            .navigationBarTitle(Text("Categories"))
            
        }
            
            
                
    }
        
        
}

struct tabView: View{
    var body: some View{
    TabView{
        ForEach(colors.indices, id: \.self){index in
            colors[index]
            
        }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
}
}

struct options: View {
    var body : some View {
        VStack{
            HStack{
                
                VStack {
                    Rectangle().frame(width: 40, height: 40, alignment: .center)
                    Text("ShopPay")
                }
                
                VStack {
                    Rectangle().frame(width: 40, height: 40, alignment: .center)
                    Text("QR")
                }
                Spacer()
        }
            HStack{
                VStack {
                    Rectangle().frame(width: 40, height: 40, alignment: .center)
                    Text("Gift Card")
                }
                
                VStack {
                    Rectangle().frame(width: 40, height: 40, alignment: .center)
                    Text("Track ")
                }
                Spacer()
                
        }
        }
    }
}
struct signIn: View {
    @State var isSignInActive = false
    @State var isSignUpActive = false
    var body : some View {
        
        VStack{
            Text("Welcome")
                .bold()
            Text("Sign in for your best experiernce")
                .padding(.bottom)
            NavigationLink( destination: LoginView(), isActive: $isSignInActive)
            {
                Button("Sign In"){
                    self.isSignInActive = true
                }
            }
            NavigationLink( destination: SignUpView(), isActive: $isSignUpActive)
            {
                Button("Create an Account"){
                    self.isSignUpActive = true
                    
                }
                
            }
            
        }
    }
}

struct tileView: View {
    let thisTile : tiles
    var body : some View {
        VStack{
            Rectangle().frame(width: 20, height: 20, alignment: .center)
            Text(thisTile.title)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
        
    }
}
