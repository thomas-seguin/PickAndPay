//
//  CartDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-02.
//

import Foundation
import SQLite3
extension DBHelper{
//MARK: Insert product to cart overloads /Also checks stock
    func insertToCart(username : NSString, productId : Int, qty : Int){
        let item = getProduct(productId: productId)
        if(isInStock(productId: productId, qty: qty))
        {
            let id = getItemCartId(username: username, productId: productId)
            if(id != 0){
                addToCartQty(qty: qty, itemCartId: id, price: item.price)
            }
            else{
                insertToCart(itemQty: qty, itemPrice: item.price, username: username, productId: item.productId)
            }
        }
        else{
            print("Not enough stock")
        }
    }
    private func insertToCart(itemQty : Int, itemPrice : Double, username : NSString, productId : Int){
        var stmt : OpaquePointer?
        let query = "insert into ItemCart (Quantity, TotalPrice, UserId, ProductId) values (?,?,?,?);"
        let total = Double(itemQty) * itemPrice
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            //bind parameters
            if sqlite3_bind_int(stmt, 1, Int32(itemQty)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding item quantity", err)

            }
            if sqlite3_bind_double(stmt, 2, total) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding total price based on qty", err)

            }
            if sqlite3_bind_text(stmt, 3, username.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding username", err)

            }
            if sqlite3_bind_int(stmt, 4, Int32(productId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding prodcutId", err)

            }

            //insert
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("PRoduct Inserted to cart")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in inserting Product to cart", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating insert product to cart query", err)
        }

    }
//MARK: Check if product is already in user's cart
    private func doesProductExistInCart(username : NSString, productID : Int) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from ItemCart where ProductId = '\(productID)' and UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating doesProductExistInCart query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            print("product not yet in cart")
            return false
        }
        else{
            print("product already in cart")
            return true
        }
    }
//MARK: Check if user's cart is empty overloads
    func isCartEmpty(username : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from ItemCart where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating doesProductExistInCart query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            print("user's cart is empty")
            return true
        }
        else{
            print("user's cart is not empty")
            return false
        }
    
    }
    func isCartEmpty(userCart : [CartItem]) -> Bool{
        if(userCart.count > 0){
            return false
        }
        else{
            return true
        }
    }
//MARK: Get ALL products in wishlist
    func getAllCartItems() -> [CartItem]{
            cart.removeAll()
            var stmt : OpaquePointer?
            let query = "Select * from ItemCart"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating getAllCartItems query", err)
                return cart
            }
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let qty = Int(sqlite3_column_int(stmt, 1))
                let total = sqlite3_column_double(stmt, 2)
                let username = String(cString: sqlite3_column_text(stmt, 3))
                let productId = Int(sqlite3_column_int(stmt, 4))
                cart.append(CartItem(id: id, qty: qty, userId: username, productId: productId, totalPrice: total))
            }

            return cart
    }
//MARK: Get user's cart
    func getUserCart(username : NSString) -> [CartItem]{
        cart.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from ItemCart where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserCart query", err)
            return cart
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let qty = Int(sqlite3_column_int(stmt, 1))
            let total = sqlite3_column_double(stmt, 2)
            let username = String(cString: sqlite3_column_text(stmt, 3))
            let productId = Int(sqlite3_column_int(stmt, 4))
            cart.append(CartItem(id: id, qty: qty, userId: username, productId: productId, totalPrice: total))
        }

        return cart
    }
//MARK: Get ItemCartID
    func getItemCartId(username : NSString, productId : Int) -> Int{
        var stmt : OpaquePointer?
        let query = "Select * from ItemCart where UserId = '\(username)' and ProductId = \(productId)"
        var num = 0
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserCart query", err)
            return num
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            num = Int(sqlite3_column_int(stmt, 0))
        }

        return num
    }
    
    
//MARK: Update quantity of pproduct in the cart and also the total price
    func updateCartItemQty(qty : Int, itemCartId : Int){
        let query = "update ItemCart SET TotalPrice = (TotalPrice/Quantity) * \(qty), Quantity = \(qty) where ItemCartId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(itemCartId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding itemCartId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("cart item qty and total price updated")
            }
            else{
                print("error in updating cart item qty and total price")
            }
        }
        else{
            print("Error in update cart item query")
        }
        
    }
    
//MARK: Add to item quantity and total price of the cartItem
    private func addToCartQty(qty : Int, itemCartId : Int, price : Double){
    let addedCost = Double(qty) * price
    let query = "update ItemCart SET Quantity = Quantity + \(qty), TotalPrice = TotalPrice + \(addedCost) where ItemCartId = ?;"
    var stmt : OpaquePointer?
    if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
        
        if sqlite3_bind_int(stmt, 1, Int32(itemCartId)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in binding itemCartId", err)

        }
        if sqlite3_step(stmt) == SQLITE_DONE{
            print("cart item qty and total price increased")
        }
        else{
            print("error in adding to cart item qty and total price")
        }
    }
    else{
        print("Error in add to cart item query")
    }
    
}
//MARK: Remove an item from the cart / automatically called when item is ordered and paid
    func removeFromCart(itemCartId : Int){
        let query = "delete from ItemCart where ItemCartId = \(itemCartId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("removed product from cart")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing product from cart", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in crfeating remove product from cart query", err)
        }
    }
//MARK: Clear user's cart
    func clearUserCart(username : NSString){
        let query = "delete from ItemCart where UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user cart cleared")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in clearing user's cart", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in clear user's cart query", err)
        }
    }
//MARK: Remove product from all carts
    func removeProductFromAllCarts(productId : Int){
        let query = "delete from ItemCart where ProductId = \(productId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Product removed from all carts")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing product from all carts", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in removeProductFromAllCarts query", err)
        }
    }
}

