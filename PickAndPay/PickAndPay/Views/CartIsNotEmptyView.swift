import SwiftUI

struct CartIsNotEmptyView: View {
    @EnvironmentObject var cartManager : CartManager
    var body: some View {
        ScrollView {
            Text("My Cart").bold().font(.largeTitle)
            ForEach(cartManager.items, id: \.productId){ product in
                    ProductRow(product: product)
                }
            VStack {
                HStack{
                        Text("Your cart total is")
                            .bold()
                        Spacer()
                    Text(String(format:"$%.2f", cartManager.total))
                            .bold()
                }.frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text("Payment Options")
                        .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                        .background(.yellow)
                    .cornerRadius(10)
                }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            }
            
        }

    }
    func loadList(){}
}

struct CartIsNotEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CartIsNotEmptyView()
    }
}
