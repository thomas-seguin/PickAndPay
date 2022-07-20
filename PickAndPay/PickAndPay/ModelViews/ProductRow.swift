import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager : CartManager
    //var product: Product
    var product: CartItem
    var body: some View {
        HStack(spacing:10){
            Image(product.cartProduct.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .scaledToFit()
            VStack {
                Text(product.cartProduct.productName)
                    .bold()
                //Spacer()
                Text(String(format: "$%.2f", product.cartProduct.price))
            }
            Spacer()
            //addPlus()
            HStack {
                Image(systemName: "minus.rectangle")
                    .resizable()
                    .frame(width: 20, height: 40, alignment: .center)
                    .onTapGesture {
                    //cartManager.quantity -= 1
                        cartManager.removeFromCart(product: product)
                        //cartManager = CartManager()
                }
                
                Text(String(product.quantity))
                    .font(.largeTitle)
                    .frame(width: 20, height: 40, alignment: .center)
                
                Image(systemName: "plus.rectangle")
                    .resizable()
                    .frame(width: 20, height: 40, alignment: .center)
                    .onTapGesture {
                    //cartManager.quantity += 1
                        cartManager.addToCart(product: product)
                        //cartManager = CartManager()
                }
            }
            Image(systemName: "trash")
                .resizable()
                .frame(width: 20, height: 40, alignment: .center)
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.deleteFromCart(product: product)
                    //cartManager = CartManager()
                }
                .padding()
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 1))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
    }

}
