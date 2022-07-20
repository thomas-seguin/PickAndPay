//
//  OrderHistoryView.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//

import SwiftUI

struct OrderHistoryView: View {
    @State var viewModel = OrderHistoryViewModel()
    var body: some View {
        VStack(){
            List{
                Section(header: Text("Your Orders")
                    .font(.headline), footer: Text("End of List")){
                        ForEach(viewModel.orderHistory, id: \.orderId){ item in
                        //destination : Replace ProductViewTest with the real view for product details
                            NavigationLink(destination: OrderDetailsView(viewModel: OrderDetailsViewModel(orderId : item.orderId))){
                            VStack{
                                HStack{
                                    Image(viewModel.getFirstImage(thisOrder: item))
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading){
                                        Text("Order Id: \(item.orderId)")
                                            .font(.title)
                                        Text("Ordered at:  \(item.date)")
                                            .font(.subheadline)
                                    }
                                    
                                }
                                HStack(alignment: .center){
                                    Button(action: {
                                        viewModel.removeFromOrderHistory(orderId: item.orderId)
                                        reloadList()
                                    }){
                                        Text("Remove from Order History")
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
                                }
                            }
                        }
                    }
            }
        }
    }
    func reloadList(){
        viewModel = OrderHistoryViewModel()
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
