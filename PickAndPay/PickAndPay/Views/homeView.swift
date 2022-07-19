//
//  SwiftUIView.swift
//  PickAndPay
//
//  Created by James Suresh on 2022-07-04.
//

import SwiftUI
let userDefauts = UserDefaults()
let colors : [Color] = [.red,.blue,.green, .blue]
let previewLinks : [String] = ["EssentialsAd", "RingAd", "PrimeVideo"]

struct tiles {
    var id : Int
    var title : String
}

struct homeView: View {
    @EnvironmentObject var authentication: Authentication
    let categories : [tiles] = [
        tiles(id: 0, title: "Electronics"),
        tiles(id: 1, title: "Books"),
        tiles(id: 2, title: "Grocery"),
        tiles(id: 3, title: "Essential"),
        tiles(id: 4, title: "Fashion")
    ]

   
    @State var searchText = ""
    var body: some View {
        ZStack{
            //Color.background.
        ScrollView{
            
        VStack{
//            Rectangle()
//                .frame(width: UIScreen.main.bounds.width, height: 200)
        ZStack{
            //Image("MargoFlipped").resizable().frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height, alignment: .top)
                
        
            
                

            VStack{
                
                  
                 
                TextField("Search", text: $searchText)
                ZStack{
                    VStack{
                        HStack{
                            ForEach(categories, id: \.id)
                            {tiles in
                                tileView(thisTile: tiles)
                            }
                        }
                        tabView().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.63333, alignment: .top)
                    }
                }
                
                
                
                
                HStack{
                    options()
                        .frame(width: UIScreen.main.bounds.width/2)
                    Spacer()
                    if(!authentication.isValidated)
                    {
                    signIn()
                    }
                    else{
                        signOut()
                    }
                    
                }
                videoView().frame( height: 400)
                Spacer()
            }
                
            }
            //.navigationBarTitle(Text("Home"))
            
        }
        }
    }
    }
    }
        
        


struct tabView: View{
    var body: some View{
    TabView{
        ForEach(previewLinks.indices, id: \.self){index in
            Image(previewLinks[index]).resizable()
            
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
                    Image("pay").resizable().frame(width: 40, height: 40)
                    Text("ShopPay")
                        .foregroundColor(.text)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                }
                
                VStack {
                    Image("qr").resizable().frame(width: 40, height: 40)
                    Text("QR")
                        .foregroundColor(.text)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                }
                Spacer()
            }.padding()
            HStack{
                VStack {
                    Image("giftcard").resizable().frame(width: 40, height: 40)
                    Text("Gift Card")
                        
                    .foregroundColor(.text)
                    .font(.system(size: 17, weight: .regular, design: .rounded))                }
                
                VStack {
                    Image("track").resizable().frame(width: 40, height: 40)
                    Text("Track ")
                        
                        .foregroundColor(.text)
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    
                }
                Spacer()
                
            }.padding()
        }
    }
}
struct signIn: View {
    @State var isSignInActive = false
    @State var isSignUpActive = false
    var body : some View {
        
        VStack(alignment: .center){
            Text("Welcome")
                .foregroundColor(.text)
                .font(.system(size: 17, weight: .bold, design: .rounded))
               
            Text("Sign in for your best experiernce")
                .foregroundColor(.text)
                .font(.system(size: 17, design: .rounded))
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
        .frame(width: UIScreen.main.bounds.width/2)
        
    }
}

struct signOut: View {
    @EnvironmentObject var authentication: Authentication
    @State var isSignOutActive = false
    var body : some View {
        
        VStack(alignment: .center){
            Text("Welcome")
                .foregroundColor(.text)
                .font(.system(size: 17, weight: .bold, design: .rounded))
               
            Text(userDefauts.string(forKey: "username")!)
                .foregroundColor(.text)
                .font(.system(size: 17, design: .rounded))
                .padding(.bottom)
            Button("Sign Out"){
                authentication.isValidated = false
            }
            
        }
        .frame(width: UIScreen.main.bounds.width/2)
        
    }
}

struct tileView: View {
    let thisTile : tiles
    @State var a = false
    var body : some View {
       
        VStack{
            Image(thisTile.title.lowercased())
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .onTapGesture {
                    a.toggle()
                   }
           
            NavigationLink( "", destination: FashionCatalog(), isActive: $a)
            
            Text(thisTile.title)
                .foregroundColor(.text)
                .font(.system(size: 17, weight: .regular, design: .rounded))
        }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
        
    }
}
