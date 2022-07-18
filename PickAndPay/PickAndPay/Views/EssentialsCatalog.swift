import SwiftUI

struct EssentialsCatalog: View {
    
    @State var products:[ProductName] = [ProductName(uuid: "cookware", image: Image("cookware"), title: "8 Peice Black Cookware Set", price: 100.00, description: "Loaded with everyday essentials, the collection includes fry pans, sauce pans, and casserole pans.", reviews: [ReviewBody(name: "John Smith", rating: 3.6, content: "We got them today super easy to clean look great and excellent value for the money . And i am so happy with these . Excellent value for the money . And that is often the deciding factor for me as im on a fixed income")])]
    
    @State var cart:[ProductName] = [ProductName(uuid: "cookware", image: Image("cookware"), title: "8 Peice Black Cookware Set", price: 100.00, description: "Loaded with everyday essentials, the collection includes fry pans, sauce pans, and casserole pans.", reviews: [ReviewBody(name: "John Smith", rating: 3.6, content: "We got them today super easy to clean look great and excellent value for the money . And i am so happy with these . Excellent value for the money . And that is often the deciding factor for me as im on a fixed income")])]
    
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
                                    EssentialsDetail(product: prod, cart: self.$cart)
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
                                    EssentialsDetail(product: prod, cart: self.$cart)
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


