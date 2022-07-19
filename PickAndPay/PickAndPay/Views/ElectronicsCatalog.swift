import SwiftUI

struct ElectronicsCatalog: View {
    
    
    @State var products:[ProductName] = [ProductName(uuid: 2, image: Image("tv"), title: "80' LG 8K LCD TV", price: 1200.00, description: "LG 8K NanoCell TV NANO99 is our best 8K LED TV. It’s four times the resolution of 4K across 33+ million pixels. ", reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")]), ProductName(uuid: 3, image: Image("PS5"), title: "80' LG 8K LCD TV", price: 1200.00, description: "LG 8K NanoCell TV NANO99 is our best 8K LED TV. It’s four times the resolution of 4K across 33+ million pixels. ", reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")])]
    
    @State var cart:[ProductName] = [ProductName(uuid: 2, image: Image("tv"), title: "80' LG 8K LCD TV", price: 1200.00, description: "LG 8K NanoCell TV NANO99 is our best 8K LED TV. It’s four times the resolution of 4K across 33+ million pixels. ", reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")])]
    
    
    var body: some View {
        
        var prods: [[ProductName]] = []
        _ = (products).publisher
            .collect(products.count % 2 == 1 ? (products.count / 2) + 1 : (products.count / 2))
            .collect()
            .sink(receiveValue: { prods = $0 })
        
        
        
        return
       
            ScrollView(.vertical, showsIndicators: true) {
                HStack(alignment: .top, spacing: 10) {
                    if prods.count > 0 {
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(prods[0], id: \.uuid) { prod in
                                NavigationLink(destination:
                                    ElectronicsDetail(product: prod, cart: self.$cart)
                                        .padding(.horizontal, 16)
                                        
                                ) {
                                    ProductCell(product: prod)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    if prods.count == 2 {
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(prods[1], id: \.uuid) { prod in
                                NavigationLink(destination:
                                    ElectronicsDetail(product: prod, cart: self.$cart)
                                        .padding(.horizontal, 16)
                                ) {
                                    ProductCell(product: prod)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    if prods.count == 0 {

                        VStack(alignment: .center, spacing: 4) {
                            Spacer()
                            Image(systemName: "bag.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.gray)
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding(.bottom, 20)
                                //.font(Font.system(size: 16, weight: .bold, design: .rounded))
                            Text("No Products To Display")
                                .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                    }
                    
                }
                .padding()
            }.onAppear(){
                var prods = DBHelper.dbHelper.searchProducts(searchParameter: "PS4")
                var thing : ProductName
                
                for i in prods{
                    thing = ProductName.init(uuid: 0, image: Image(i.productImage), title: i.productName, price: i.price, description: i.description, reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")])
                    products.append(thing)
                }
                 prods = DBHelper.dbHelper.searchProducts(searchParameter: "Xbox Series S")
                
                
                for i in prods{
                    thing = ProductName.init(uuid: 0, image: Image(i.productImage), title: i.productName, price: i.price, description: i.description, reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")])
                    products.append(thing)
                }
                prods = DBHelper.dbHelper.searchProducts(searchParameter: "Xbox Series X")
               
               
               for i in prods{
                   thing = ProductName.init(uuid: 0, image: Image(i.productImage), title: i.productName, price: i.price, description: i.description, reviews: [ReviewBody(name: "Jim Smith", rating: 5.0, content: "I been wanting to buy this tv for months maybe a full year even! I got a call 1 hour after purchasing it and was delievered to me within a hr after that call... all setup up a hour after that too... so.. the tv i wanted.. i got everything i could have asked for.. thank you very much!")])
                   products.append(thing)
               }
                
                
            }
        
    }
        
}


