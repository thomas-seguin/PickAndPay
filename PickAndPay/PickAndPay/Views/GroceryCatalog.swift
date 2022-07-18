import SwiftUI

struct GroceryCatalog: View {
    
    @Binding var products:[Product]
    @Binding var cart:[Product]
    @Binding var favorites:[Product]
    
    var body: some View {
        
        var prods: [[Product]] = []
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
                                    GroceryDetail(product: prod, cart: self.$cart, favorites: self.$favorites)
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
                                    GroceryDetail(product: prod, cart: self.$cart, favorites: self.$favorites)
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

struct GroceryCatalog_Previews: PreviewProvider {
    
    @State static var items:[Product] = [Product(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "redshoe", image: Image("redshoe"), title: "Adidas Limited Edition 100P", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
    
    
    
    @State static var cart:[Product] = [Product(uuid: "redshoe", image: Image("redshoe"), title: "Adidas Limited Edition 100P", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This is so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "product123", image: Image("product02"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "product123", image: Image("product03"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "product123", image: Image("product04"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "product123", image: Image("product05"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]),Product(uuid: "product123", image: Image("product06"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [Review(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
    
    @State static var favorites:[Product] = []
    
    static var previews: some View {
        GroceryCatalog(products: $items, cart: $cart, favorites: $favorites)
    }
}
