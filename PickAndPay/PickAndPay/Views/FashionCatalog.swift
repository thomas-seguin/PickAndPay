import SwiftUI

struct FashionCatalog: View {
    
    @State var products:[ProductName] = [ProductName(uuid: 1, image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [ReviewBody(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
    
    
    @State var cart:[ProductName] = [ProductName(uuid: 1, image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [ReviewBody(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
    
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
                                    FashionDetail(product: prod, cart: self.$cart)
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
                                    FashionDetail(product: prod, cart: self.$cart)
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
            
        
        
        
    }


//struct FashionCatalog_Previews: PreviewProvider {
//
////    @State static var items:[ProductName] = [ProductName(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [ReviewBody(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")]
//
//    @State static var items:[ProductName] = [ProductName(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [ReviewBody(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
//
//    @State static var cart:[ProductName] = [ProductName(uuid: "redshoe", image: Image("redshoe"), title: "Nike Air Force 1", price: 200.00, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.", reviews: [ReviewBody(name: "John Smith", rating: 5.0, content: "This are so good! Best purchase I've made in a long time. Soooo slick!")])]
//
//
//    static var previews: some View {
//      //  FashionCatalog(products: $items, cart: $cart)
//    }
//}
}
