//
//  WishListDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-29.
//

import Foundation
import SQLite3
extension DBHelper{
//MARK: Insert Product to WishList
    func insertToWishList(UserId : NSString, ProductId : Int){
        var stmt : OpaquePointer?
        let query = "insert into WishList (UserId, ProductId) values (?,?);"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            //bind parameters
            if sqlite3_bind_text(stmt, 1, UserId.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding User Id", err)

            }
            if sqlite3_bind_int(stmt, 2, Int32(ProductId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding Product Id", err)

            }

            //insert
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("PRoduct Inserted to wishlist")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in inserting Product to wishlist", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating insert product to wishlist query", err)
        }

    }
    
//MARK: Get ALL products in wishlist
    func getAllWishList() -> [WishListItem]{
        wishList.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from WishList"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllWishList query", err)
            return wishList
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let username = String(cString: sqlite3_column_text(stmt, 1))
            let productId = Int(sqlite3_column_int(stmt, 2))
            wishList.append(WishListItem(id: id, userId: username, productId: productId))

        }

        return wishList
    }
//MARK: Get user's wishlist
    func getUserWishList(username : NSString) -> [WishListItem]{
        wishList.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from WishList where userId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserWishList query", err)
            return wishList
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let username = String(cString: sqlite3_column_text(stmt, 1))
            let productId = Int(sqlite3_column_int(stmt, 2))
            wishList.append(WishListItem(id: id, userId: username, productId: productId))

        }

        return wishList
    }
//MARK: Delete a wishlist item Overloads
    func deleteWishListItem(WishListId : Int){
        let query = "delete from WishList where WishListId = \(WishListId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("product removed from wishlist")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting prodcut from wishlist", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete wishlist item query", err)
        }

    }
    func deleteWishListItem(username : NSString, productId : Int){
        let query = "delete from WishList where UserId = '\(username)' and ProductId = \(productId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("product removed from wishlist")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting prodcut from wishlist", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete wishlist item query", err)
        }

    }
}
