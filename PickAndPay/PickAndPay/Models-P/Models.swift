//
//  Models.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//

import Foundation
import SQLite3
struct User{
    var userId = ""
    var password = ""
    var name = ""
    var address = ""
    var phoneNumber = "123456789"
    var currentBalance = 0.0 //for refunds
     
    var wishList : [WishListItem]{
        return DBHelper.dbHelper.getUserWishList(username: userId as NSString)
    }
    
    var searchHistory : [SearchHistoryItem]{
       get{
          return DBHelper.dbHelper.getUserSearchHistory(username: userId as NSString)
      }
   }
    
    var reviews : [Review]{
        get{
            return DBHelper.dbHelper.getUserReviews(username: userId as NSString)
       }
    }
    var itemCart : [CartItem]{
       get{
            return DBHelper.dbHelper.getUserCart(username: userId as NSString)
       }
    }
    var cards : [Card]{
        get{
            return DBHelper.dbHelper.getUserCards(username: userId as NSString)
        }
    }
    var orders : [Order]{
        get{
            return DBHelper.dbHelper.getUserOrders(username: userId as NSString)
       }
    }
    init(){
        
    }
    
    init(userId : String, password : String, name : String, address : String, number : String, balance : Double){
        self.userId = userId
        self.password = password
        self.name = name
        self.address = address
        self.phoneNumber = number
        self.currentBalance = balance
    }
    
}

struct Product{
    var productId = 0 // assigned by database on creation
    var productName = ""
    var productImage = ""
    var price = 0.0
    var category = Category.NoCategory
    var stock = 0
    var reviews : [Review]{
        get{
            return DBHelper.dbHelper.getProductReviews(productId: productId)
        }
    }
    var reviewCount : Int{
        return reviews.count
    }
    var averageRating : Double{
        get{
           var num = 0.0
            for review in reviews {
                num += review.rating
            }
            return num/Double(reviewCount)
        }
    }
    init(){
        
    }
    init(id : Int, name : String, image : String, price : Double, category : Category, inStock : Int){
        self.productId = id
        self.productName = name
        self.productImage = image
        self.price = price
        self.category = category
        self.stock = inStock
    }
}

enum Category : String{
    case Electronics
    case Fashion
    case Toys
    case Entertaiment
    case Hardware
    case NoCategory
}

struct WishListItem{
    var wishListId = 0 //assigned by databse on creation
    var userId = ""
    var productId = 0
    //details of wished product
    var wishProduct : Product{
        get{
            return DBHelper.dbHelper.getProduct(productId: self.productId)
        }
    }
    
    init(){
        
    }
    init(id : Int, userId : String, productId : Int){
        self.wishListId = id
        self.userId = userId
        self.productId = productId
        
    }
}
//For Search Bar
struct SearchHistoryItem{
    var searchHistoryId = 0 // assigned by database on creation
    var searchPhrase = ""
    var timesSearched = 0
    var userId = ""
    init(){
        
    }
    init(id : Int, searchPhrase : String, timesSearched : Int, userId : String){
        self.searchHistoryId = id
        self.searchPhrase = searchPhrase
        self.timesSearched = timesSearched
        self.userId = userId
    }
}
//For User Browsing History (when user clicks item)
struct BrowseHistoryItem{
    var browseHistoryId = 0 // assigned by database on creation
    var dateTime = ""
    var productId = 0
    var userId = ""
    var browsedProduct : Product{
        get{
            return DBHelper.dbHelper.getProduct(productId: productId)
        }
    }
    init(){
        
    }
    init(id : Int, dateTime : String, productId : Int, userId : String){
        self.browseHistoryId = id
        self.dateTime = dateTime
        self.productId = productId
        self.userId = userId
    }
}
struct Review{
    var reviewId = 0 // assigned by databse on creation
    var body = ""
    var rating = 0.0
    var date = ""
    var userId = ""
    var productId = 0
    init(){
        
    }
    init(id : Int, body : String, rating : Double, date : String, userId : String, productId : Int){
        self.reviewId = id
        self.body = body
        self.rating = rating
        self.date = date
        self.userId = userId
        self.productId = productId
        
    }
}

struct CartItem{
    var itemCartId = 0 // assigned by database on creation
    var quantity = 0
    var userId = ""
    var productId = 0
    var totalPrice = 0.0
    //Details of the single product in this cartitem
    var cartProduct : Product{
        get{
            return DBHelper.dbHelper.getProduct(productId: self.productId)
        }
    }
    init(){
        
    }
    
    init(id : Int, qty : Int, userId : String, productId : Int, totalPrice : Double){
        self.itemCartId = id
        self.quantity = qty
        self.userId = userId
        self.productId = productId
        self.totalPrice = totalPrice
        
    }
    
}

struct Card{
    var cardId = 0 // assigned by database on creation
    var cardNumber = "00000000000000000000" //16 digits
    var address = ""
    var cardName = ""
    var securityCode = "000" //3 digits
    var userId = ""
    
    init(){
        
    }
    init(id : Int, cardNumber : String, address : String, name : String, userId : String){
        self.cardId = id
        self.cardNumber = cardNumber
        self.address = address
        self.cardName = name
        self.userId = userId
    }
}

enum OrderStatus : String{
    case Confirmed
    case Shipped
    case Delivered
    case Refunded
    case Delayed
    case NoOrder  //can't find order in database
    case NoStatus //default
}

struct Order{
    var orderId = 0 // assigned by databse on creation
    var status = OrderStatus.NoOrder
    var shippingAddress = ""
    var numOfProducts = 0
    var totalPrice = 0.0
    var date = ""
    var paymentMode = ""
    var billingAddress = ""
    var userId = ""
    //array of ordered products
    var productOrders : [ProductOrder]{
        get{
            return DBHelper.dbHelper.getProductOrders(orderId: orderId)
        }
    }
    init(){
        
    }
    init(id : Int, status : OrderStatus, shipAddress : String, numOfProducts : Int, totalPrice : Double, date : String, payMode : String, billAddress : String, userId : String){
        self.orderId = id
        self.status = status
        self.shippingAddress = shipAddress
        self.numOfProducts = numOfProducts
        self.totalPrice = totalPrice
        self.date = date
        self.paymentMode = payMode
        self.billingAddress = billAddress
        self.userId = userId
        
    }
}

struct ProductOrder{
    var productOrderId = 0 // assigned by databse on creation
    var orderId = 0
    var productId = 0
    var quantity = 0
    var totalPrice = 0.0
    //details of ordered Product
    var orderedProduct: Product{
        get{
            return DBHelper.dbHelper.getProduct(productId: productId)
        }
        
    }
    init(){
        
    }
    init(id : Int, orderId : Int, productId : Int, qty : Int, totalPrice : Double){
        self.productOrderId = id
        self.orderId = orderId
        self.productId = productId
        self.quantity = qty
        self.totalPrice = totalPrice
    }
}
