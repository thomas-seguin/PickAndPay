import SwiftUI

struct FashionDetail: View {
    
    var product:ProductName
    @Binding var cart:[ProductName]
    //@Binding var favorites:[ProductName]
    
   // @State private var showShareSheet = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                product.image
                .resizable()
                .scaledToFill()
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(Font.system(size: 19, weight: .semibold, design: .rounded))
                }
                
                        
                    }
                    Spacer()
//                    Button(action: {
//                        self.showShareSheet = !self.showShareSheet
//                    }) {
//                        Image(systemName: "square.and.arrow.up")
//                        .foregroundColor(Color.black)
//                        .frame(width: 40, height: 40, alignment: .center)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(10)
//                    }
                    Spacer()
                    Spacer()
            
                    Button(action: {
                        if self.cart.contains(where: { (prod) -> Bool in
                            prod.uuid == self.product.uuid
                        }) {
                            self.cart.removeAll { (prod) -> Bool in
                                prod.uuid == self.product.uuid
                            }
                        } else {
                            self.cart.append(self.product)
                        }
                    }) {
                        if self.cart.contains(where: { (prod) -> Bool in
                            prod.uuid == self.product.uuid
                        }) {
                            HStack(alignment: .center, spacing: 20) {
                                Text("IN YOUR CART")
                                Image(systemName: "checkmark")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                            .background(Color.gray)
                            .cornerRadius(10)
                        } else {
                            HStack(alignment: .center, spacing: 20) {
                                Text("ADD TO CART")
                                Image(systemName: "cart.fill")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                            .background(Color(red: 111/255, green: 115/255, blue: 210/255))
                            .cornerRadius(10)
                        }
                        
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
                Text(product.description)
                    .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                
                Divider()
                
                // Review Overview Block
                VStack {
                    Text("Reviews")
                        .font(Font.system(size: 19, weight: .semibold, design: .rounded))
                    Text("\(product.reviews.count) review\(product.reviews.count == 1 ? "" : "s")")
                        .font(Font.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.gray)
                }
//                RatingBlock(rating: product.rating, primaryColor: Color.yellow, secondaryColor: Color.gray)
                Divider()
                
                // Individual Review Blocks
                VStack {
                    ForEach(self.product.reviews.indices) { i in
                        HStack{
                            Text("\(self.product.reviews[i].name)")
                                .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                            Spacer()
//                            RatingBlock(rating: self.product.reviews[i].rating, primaryColor: Color.yellow, secondaryColor: Color.gray)
                        }
                        Text("\(self.product.reviews[i].content)")
                    }
                }
            }
           // .padding(.top, 16)
           // .padding(.bottom, 70)
        }
//        .sheet(isPresented: $showShareSheet) {
//            ShareSheet(activityItems: ["\(self.product.title) - $\(String(format: "%.2f", self.product.price)) | \(self.product.description.prefix(100))..."])
//        }
   // }
//}

struct FashionDetail_Previews: PreviewProvider {
    
    static var product:ProductName = ProductName(uuid: "redshoe", image: Image("redshoe"), title: "Red Nike Air Force 1", price: 200.00, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo vel fringilla est ullamcorper eget. Faucibus scelerisque eleifend donec pretium vulputate sapien. Luctus accumsan tortor posuere ac ut consequat semper.", reviews: [ReviewBody(name: "John Doe", rating: 5.0, content: "Cool shoes and they're red")])
    
    
    
    @State static var cart:[ProductName] = [ProductName(uuid: "redshoe", image: Image("redshoe"), title: "Red Nike Air Force 1", price: 200.00, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo vel fringilla est ullamcorper eget. Faucibus scelerisque eleifend donec pretium vulputate sapien. Luctus accumsan tortor posuere ac ut consequat semper.", reviews: [ReviewBody(name: "John Doe", rating: 5.0, content: "Cool shoes and they're red")])]
    

    
    static var previews: some View {
        FashionDetail(product: product, cart: $cart);
        
        
    }
}
