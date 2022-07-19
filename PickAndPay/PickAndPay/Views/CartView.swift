import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager : CartManager
    var body: some View {
        
        if cartManager.items.count > 0 {
            CartIsNotEmptyView()
        }else{
           CartIsEmptyView()
                
            }

        }

    }


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
