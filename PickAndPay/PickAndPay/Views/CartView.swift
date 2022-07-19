import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager : CartManager
    var body: some View {
        
        VStack{
        
        
        if cartManager.items.count > 0 {
            CartIsNotEmptyView()
        }else{
           CartIsEmptyView()
                
            }

    }
        .onAppear{
            cartManager.updateItems()
            
        }
            
        
    }

    }


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
