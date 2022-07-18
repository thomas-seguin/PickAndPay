import SwiftUI

struct ProductCell: View {
    
    var product:Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            product.image
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
                
            Text(product.title)
                .font(Font.system(size: 15, weight: .regular, design: .rounded))
            Text("$\(String(format: "%.2f", product.price))")
                .font(Font.system(size: 15, weight: .heavy, design: .rounded))
        }
        .aspectRatio(contentMode: .fit)
        
    }
}

struct ProductCell_Previews: PreviewProvider {
    
    static var product:Product = Product(uuid: "shoe", image: Image("redshoe"), title: "Red Nike Air Force 1", price: 200.00, description: "Limited Edition Air Force !'s are surely to bring you some street cred", reviews: [Review(name: "John Doe", rating: 5.0, content: "This are sick! Best purchase I've made in a long time.")])
    
    static var previews: some View {
        ProductCell(product: product)
    }
}
