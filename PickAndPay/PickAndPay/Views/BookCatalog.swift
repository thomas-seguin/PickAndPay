import SwiftUI

struct BookCatalog: View {
    
    @State var products:[ProductName] = [ProductName(uuid: "hpbookset", image: Image("hpbookset"), title: "Harry Potter Book Set", price: 90.00, description: "The enduringly popular adventures of Harry, Ron and Hermione have gone on to sell over 500 million copies, be translated into over 80 languages and made into eight blockbuster films. ", reviews: [ReviewBody(name: "John Smith", rating: 4.7, content: "Harry Potter is one of the best book series out there for children and adults alike. My review will not focus on the stories but on the product itself.")])]
    
    @State var cart:[ProductName] = [ProductName(uuid: "hpbookset", image: Image("hpbookset"), title: "Harry Potter Book Set", price: 90.00, description: "The enduringly popular adventures of Harry, Ron and Hermione have gone on to sell over 500 million copies, be translated into over 80 languages and made into eight blockbuster films. ", reviews: [ReviewBody(name: "John Smith", rating: 4.7, content: "Harry Potter is one of the best book series out there for children and adults alike. My review will not focus on the stories but on the product itself.")])]
    
    var body: some View {
        
        var prods: [[ProductName]] = []
        _ = (products).publisher
            .collect(products.count % 2 == 1 ? (products.count / 2) + 1 : (products.count / 2))
            .collect()
            .sink(receiveValue: { prods = $0 })
        
        
        
        return NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                HStack(alignment: .top, spacing: 10) {
                    if prods.count > 0 {
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(prods[0], id: \.uuid) { prod in
                                NavigationLink(destination:
                                    BookDetail(product: prod, cart: self.$cart)
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
                                    BookDetail(product: prod, cart: self.$cart)
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
            }
            .padding(.bottom, 50)
            .navigationBarTitle("Catalog", displayMode: .inline)
            .navigationBarHidden(true)
        }
        
        
        
    }
}


