import SwiftUI

struct BookDetail: View {
    
    var product:ProductName
    @Binding var cart:[ProductName]
    
    
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
                
                let user = UserSingleton.userData.currentUsername
                
                DBHelper.dbHelper.insertToCart(username: UserSingleton.userData.currentUsername as NSString, productId: self.product.uuid, qty: 1)
                })
    
                {
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

struct BookDetail_Previews: PreviewProvider {
    
    static var product:ProductName = ProductName(uuid: 2, image: Image("hpbookset"), title: "Harry Potter Bookset", price: 90.00, description: "The enduringly popular adventures of Harry, Ron and Hermione have gone on to sell over 500 million copies, be translated into over 80 languages and made into eight blockbuster films. ", reviews: [ReviewBody(name: "John Doe", rating: 4.7, content: "Harry Potter is one of the best book series out there for children and adults alike. My review will not focus on the stories but on the product itself.")])
    
    
    
    @State static var cart:[ProductName] = [ProductName(uuid: 2, image: Image("hpbookset"), title: "Harry Potter Bookset", price: 90.00, description: "The enduringly popular adventures of Harry, Ron and Hermione have gone on to sell over 500 million copies, be translated into over 80 languages and made into eight blockbuster films. ", reviews: [ReviewBody(name: "John Doe", rating: 4.7, content: "Harry Potter is one of the best book series out there for children and adults alike. My review will not focus on the stories but on the product itself.")])]
    

    
    static var previews: some View {
        BookDetail(product: product, cart: $cart);
        
        
    }
}
