import Foundation
import SwiftUI

struct ProductName {
    var uuid : String
    var image : Image
    var title : String
    var price : Double
    var description : String
    var reviews : [ReviewBody]
    
    var rating : Double {
        get {
            reviews.reduce(0) { (res, review) -> Double in
                res + review.rating
            }
        }
    }
}


struct ReviewBody {
    var name : String
    var rating : Double
    var content : String
}
