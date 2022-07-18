//
//  BrowsingHistoryView.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-08.
//
import SwiftUI

struct BrowsingHistoryView: View {
    @State var viewModel = BrowseHistoryViewModel()
    @State var isBrowseHistoryOn = BrowseHistoryViewModel().isBrowseHistoryOn()
    var body: some View {
            VStack(alignment: .leading){
                Toggle(isOn: $isBrowseHistoryOn){
                    Text(viewModel.browseHistoryToggleText(toggleValue: isBrowseHistoryOn))
                }
                .onChange(of: isBrowseHistoryOn){value in
                    viewModel.toggleBrowseHistorySwitch(toggleValue: value)
                }
                .padding(.horizontal)
                .toggleStyle(SwitchToggleStyle())
                Button(action: {
                    viewModel.clearHistory()
                    reloadList()
                    
                }){
                    Text("Clear History")
                        .font(.footnote)
                }
                .buttonStyle(BorderedButtonStyle())
                .padding(.horizontal)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(5)
                List{
                    Section(header: Text(viewModel.getUsername() + "'s Browsing History")
                        .font(.headline), footer: Text("End of List")){
                        ForEach(viewModel.browseHistory, id: \.browseHistoryId){ item in
                            //destination : Replace ProductViewTest with the real view for product details
                            NavigationLink(destination: ProductViewTest(product: item.browsedProduct)){
                                VStack{
                                    HStack{
                                        Image(item.browsedProduct.productImage)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        VStack(alignment: .leading){
                                            Text(item.browsedProduct.productName)
                                                .font(.title)
                                            Text(viewModel.getRatingString(product: item.browsedProduct))
                                                .font(.footnote)
                                            Text(viewModel.getPriceString(product: item.browsedProduct))
                                                .font(.subheadline)
                                        }
                                    }
                                    HStack(alignment: .center){
                                        Button(action: {
                                            viewModel.removeFromBrowseHistory(id: item.browseHistoryId)
                                            reloadList()
                                        }){
                                            Text("Remove from View")
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
                }
                Spacer()
            }
    }
    func reloadList(){
        viewModel = BrowseHistoryViewModel()
    }
}

struct BrowsingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BrowsingHistoryView()
    }
}


