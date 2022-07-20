//
//  OrderDetailsView.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//

import SwiftUI

struct OrderDetailsView: View {
    @State var viewModel : OrderDetailsViewModel
    var body: some View {
        VStack(){
            List{
                Section(header: Text("View Order Details")
                    .font(.headline)
                    .bold()){
                        HStack{
                            Text("Order date")
                            Spacer()
                            Text(viewModel.orderDetails.date)

                        }
                        HStack{
                            Text("Order # ")
                            Spacer()
                            Text("\(String(viewModel.orderDetails.orderId))")
                        }
                            
                        HStack{
                            Text("Order Total ")
                            Spacer()
                            Text("\(viewModel.getOrderTotalQty())")
                        }
                }
                Section(header: Text("Shipment Details")
                    .font(.headline)
                    .bold()){
                        Text(viewModel.getOrderStatus())
                            .bold()
                        ForEach(viewModel.orderDetails.productOrders, id: \.productOrderId){ item in
                        //destination : Replace ProductViewTest with the real view for product details
                            NavigationLink(destination: ProductViewTest(product: item.orderedProduct)){
                            VStack{
                                HStack{
                                    Image(item.orderedProduct.productImage)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading){
                                        Text(item.orderedProduct.productName)
                                            .font(.title3)
                                            .bold()
                                        Text("Qty: \(item.quantity)")
                                            .font(.footnote)
                                    }
                                    Spacer()
                                    VStack(){
                                        Text("CDN$")
                                        Text("\(String(format: "%.2f", item.totalPrice))")
                                    }
                                    .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Payment Information")
                    .font(.headline)
                    .bold()){
                        VStack(alignment: .leading){
                            Text("Payment Method").bold()
                            Text(viewModel.orderDetails.paymentMode)
                        }
                        VStack(alignment: .leading){
                            Text("Billing Address").bold()
                            Text(viewModel.orderDetails.billingAddress)
                        }
                }
                Section(header: Text("Shipping Address")
                    .font(.headline)
                    .bold()){
                        Text(viewModel.orderDetails.shippingAddress)
                }
                Section(header: Text("Order Summary")
                    .font(.headline)
                    .bold()){
                        HStack{
                            Text("Items: ")
                            Spacer()
                            Text(viewModel.getItemTotal())
                        }
                        HStack{
                            Text("Shipping & Handling:")
                            Spacer()
                            Text(viewModel.getShipFee())
                        }
                            
                        HStack{
                            Text("Total Before Tax: ")
                            Spacer()
                            Text(viewModel.getBeforeTax())
                        }
                        HStack{
                            Text("Estimated GST: ")
                            Spacer()
                            Text(viewModel.getGST())
                        }
                        HStack{
                            Text("Order Total: ")
                                .bold()
                            Spacer()
                            Text(viewModel.getTotal())
                                .bold()
                                .foregroundColor(.red)
                        }
                }
                Section(header: Text("You might like these products")
                    .font(.headline)){
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.recommended, id: \.productId){ item in
                                    NavigationLink(destination: ProductViewTest(product: item)){
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
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(viewModel: OrderDetailsViewModel(orderId : 6))
            .previewInterfaceOrientation(.portrait)
    }
}
