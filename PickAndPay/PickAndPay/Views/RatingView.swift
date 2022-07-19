import SwiftUI

struct RatingView: View {
    @State var selected = -1
    var body: some View{
        HStack {
            ForEach (0..<5) { rating in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(selected >= rating ? .yellow : .gray)
                    .onTapGesture {
                        selected = rating
                    }
                
            }
        }
        
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
