import SwiftUI

struct CartIsNotEmptyView: View {
    @EnvironmentObject var cartManager : CartManager
    @State var showAlert = false
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
                    NavigationLink(destination: AddCardView()){
                    Text("Payment Options")
                        .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                        .background(.yellow)
                    .cornerRadius(10)
                }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                    Button{
        
                        showAlert = true
                        
                    }label:{Text("Place Order")}
                    
                        .alert("Order Placed", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
            }
                
            }
            
        }

    }
  
}

struct CartIsNotEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CartIsNotEmptyView()
    }
}
}
