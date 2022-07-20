//
//  WishListView.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-07.
//
import SwiftUI

struct WishListView: View {
    @State var viewModel = WishListViewModel()
    var body: some View {
            VStack{
                List{
                    Section(header: Text(viewModel.getUsername() + "'s WishList")
                        .font(.headline), footer: Text("End of List")){
                        ForEach(viewModel.wishList, id: \.wishListId){ item in
                            //destination : Replace ProductViewTest with the real view for product details
                            NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: item.wishProduct))){
                                VStack{
                                    HStack{
                                        Image(item.wishProduct.productImage)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        VStack(alignment: .leading){
                                            Text(item.wishProduct.productName)
                                                .font(.title)
                                            Text(viewModel.getRatingString(product: item.wishProduct)).font(.footnote)
                                            Text(viewModel.getPriceString(product: item.wishProduct))
                                                .font(.subheadline)
                                        }
                                        
                                    }
                                    HStack(alignment: .center){
                                        if(viewModel.isInStock(product: item.wishProduct)){
                                            Button(action: {
                                                viewModel.addToCart(item: item)
                                                reloadList()
                                            }){
                                                Text("Add to Cart")
                                                    .font(.footnote)
                                                    .multilineTextAlignment(.center)
                                            }
                                            .buttonStyle(BorderedButtonStyle())
                                            .foregroundColor(Color.black)
                                            .background(Color.yellow)
                                            .cornerRadius(5)

                                        }
                                        else{
                                            Text("Item not in Stock")
                                                .font(.footnote)
                                                .foregroundColor(Color.red)
                                                .multilineTextAlignment(.center)
                                                
                                        }
                                        Button(action: {
                                            viewModel.removeFromWishList(id: item.wishListId)
                                            reloadList()
                                        }){
                                            Text("Remove from WishList")
                                                .font(.footnote)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                        }
                                        .buttonStyle(BorderedButtonStyle())
                                        .foregroundColor(Color.black)
                                        .background(Color.white)
                                        .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }
                    Section(header: Text("You might like these products")
                        .font(.headline)){
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(viewModel.recommended, id: \.productId){ item in
                                        NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: item))){
                                            HStack{
                                                Image(item.productImage)
                                                    .resizable()
                                                    .frame(width: 80, height: 80)
                                                VStack(alignment: .leading){
                                                    Text(item.productName)
                                                        .font(.title)
                                                    Text(viewModel.getRatingString(product: item)).font(.footnote)
                                                    Text(viewModel.getPriceString(product: item))
                                                        .font(.subheadline)
                                                }
                                            }
                                        }
                                        .foregroundColor(Color.black)
                                    }
                                }
                            }
                        }
                }
            }
    }
    func reloadList(){
        viewModel = WishListViewModel()
    }
}
struct ProductViewTest: View {
    let product: Product

    var body: some View {
        Text("Selected product: \(product.productName)")
            .font(.largeTitle)
    }
}
struct WishList_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}
