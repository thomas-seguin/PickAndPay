//
//  ProductDetailsView.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//
import SwiftUI

struct ProductDetailView: View {
    @State var viewModel : ProductDetailViewModel
    @State var cartAlert = false
    @State var wishAlert = false
    var body: some View {
        VStack(){
            HStack{
                Text(viewModel.product.productName)
                    .font(.title)
                Spacer()
            }
            HStack{
                Text(viewModel.getRatingString())
                Spacer()
            }
            Image(viewModel.product.productImage)
                .resizable()
                .frame(width: 200, height: 200)
            HStack{
                Text(viewModel.getPriceString())
                    .bold()
                    .font(.subheadline)
                Spacer()
            }
            HStack{
                Text(viewModel.getStock())
                    .font(.footnote)
                Spacer()
            }
            HStack(alignment: .center){
                if(viewModel.isInStock()){
                    Button(action: {
                        viewModel.addToCart()
                        cartAlert = true
                    }){
                        Text("Add to Cart")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                    .alert(Text("Added to Cart"), isPresented: $cartAlert){
                        Button("OK", role: .cancel){}
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
                    viewModel.addToWishList()
                    wishAlert = true
                }){
                    Text("Add to WishList")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
                .alert(Text("Added to WishList"), isPresented: $wishAlert){
                    Button("OK", role: .cancel){}
                }
                .buttonStyle(BorderedButtonStyle())
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(5)
            }
            VStack(alignment: .leading){
                HStack{
                    Text("Product Description")
                        .bold()
                        .font(.subheadline)
                    Spacer()
                }
                HStack{
                    Text(viewModel.product.description)
                        .font(.footnote)
                    Spacer()
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
                                            Text(viewModel.getRatingString()).font(.footnote)
                                            Text(viewModel.getPriceString())
                                                .font(.subheadline)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top)
        }
        .padding()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product()))
    }
}
