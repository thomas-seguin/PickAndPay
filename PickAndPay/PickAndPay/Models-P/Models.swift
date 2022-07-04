//
//  Models.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//

import Foundation
struct User{
    var userId = ""
    var password = ""
    var name = ""
    var address = ""
    var phoneNumber = "123456789"
    var currentBalance = 0.0 //for refunds
    var wishList = [WishListItem]()
    var searchHistory = [SearchHistoryItem]()
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
    var wishProduct = Product() //details of wished product
    
    init(){
        
    }
    init(id : Int, userId : String, productId : Int){
        self.wishListId = id
        self.userId = userId
        self.productId = productId
        wishProduct = DBHelper.dbHelper.getProduct(productId: self.productId)
    }
}

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
    var cartProduct = Product() //Details of the single product in this cartitem
    init(){
        
    }
    
    init(id : Int, qty : Int, userId : String, productId : Int, totalPrice : Double){
        self.itemCartId = id
        self.quantity = qty
        self.userId = userId
        self.productId = productId
        self.totalPrice = totalPrice
        self.cartProduct = DBHelper.dbHelper.getProduct(productId: self.productId)
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
    init(id : Int, cardNumber : String, address : String, name : String, code : String, userId : String){
        self.cardId = id
        self.cardNumber = cardNumber
        self.address = address
        self.cardName = name
        self.securityCode = code
        self.userId = userId
    }
}

enum OrderStatus : String{
    case NotOrdered
    case Confirmed
    case Shipped
    case Delivered
    case Refunded
    case Delayed
}

struct Order{
    var orderId = 0 // assigned by databse on creation
    var status = OrderStatus.NotOrdered
    var numOfProducts = 0
    var totalPrice = 0.0
    var date = ""
    var userId = ""
    var cardId = 0
    var productOrders = [ProductOrder]()
    init(){
        
    }
    init(id : Int, status : OrderStatus, numOfProducts : Int, totalPrice : Double, date : String, userId : String, cardId : Int){
        self.orderId = id
        self.status = status
        self.numOfProducts = numOfProducts
        self.totalPrice = totalPrice
        self.date = date
        self.userId = userId
        self.cardId = cardId
    }
}

struct ProductOrder{
    var productOrderId = 0 // assigned by databse on creation
    var orderId = 0
    var productId = 0
    var quantity = 0
    var totalPrice = 0.0
    
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
