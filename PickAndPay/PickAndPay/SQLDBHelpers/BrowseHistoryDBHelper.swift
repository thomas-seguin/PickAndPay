//
//  BrowseHistoryDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-07.
//
import Foundation
import SQLite3
extension DBHelper{
//MARK: Insert into browsing history or update searched date if product already exist in user's browsing history
    // can be called when user clicks a product and go to the product details page
    func productBrowsed(productId : Int, username : NSString){
        if(isBrowsedFirstTime(productId : productId, userId: username)){
            insertToBrowseHistory(productId : productId, userId: username)
        }
        else{
            updateBrowseDateTime(productId: productId, userId: username)
        }
    }
    private func isBrowsedFirstTime(productId : Int, userId : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from BrowseHistory where ProductId = \(productId) and UserId = '\(userId)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating isBrowsedFirstTime query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            print("first time browse")
            return true
        }
        else{
            print("Not a first time browse")
            return false
        }
    }
    func getCurrentDateTime() -> NSString{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return NSString(string: dateFormatter.string(from: Date()))
    }
    private func insertToBrowseHistory(productId : Int, userId : NSString){
            var stmt : OpaquePointer?
            let query = "insert into BrowseHistory (DateTime, ProductId, UserId) values (?,?,?);"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                //bind parameters
                if sqlite3_bind_text(stmt, 1, getCurrentDateTime().utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding dateTime", err)

                }
                if sqlite3_bind_int(stmt, 2, Int32(productId)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding productId", err)

                }
                if sqlite3_bind_text(stmt, 3, userId.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding userId", err)

                }

                //insert
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("product Inserted to browse history")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer))
                    print("error in inserting product to browse history", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating insert to browsehistory query", err)
            }

        }
    private func updateBrowseDateTime(productId : Int, userId : NSString){
        let query = "update BrowseHistory SET DateTime = '\(getCurrentDateTime())' where ProductId = \(productId) and UserId = '\(userId)';"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("time browsed updated")
            }
            else{
                print("error in updating time browsed")
            }
        }
        else{
            print("Error in time browsed update query")
        }
    }
//MARK: Get all browse history
    func getAllBrowseHistory() -> [BrowseHistoryItem]{
        browsing.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from BrowseHistory"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllBrowseHistory query", err)
            return browsing
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let dateTime = String(cString: sqlite3_column_text(stmt, 1))
            let productId = Int(sqlite3_column_int(stmt, 2))
            let username = String(cString: sqlite3_column_text(stmt, 3))
            browsing.append(BrowseHistoryItem(id: id, dateTime: dateTime, productId: productId, userId: username))
        }

        return browsing
    }
//MARK: Get user browse history starting with most recent
    func getUserBrowseHistory(username : NSString) -> [BrowseHistoryItem]{
        browsing.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from BrowseHistory where UserId = '\(username)' order by DateTime desc"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserBrowseHistory query", err)
            return browsing
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let dateTime = String(cString: sqlite3_column_text(stmt, 1))
            let productId = Int(sqlite3_column_int(stmt, 2))
            let username = String(cString: sqlite3_column_text(stmt, 3))
            browsing.append(BrowseHistoryItem(id: id, dateTime: dateTime, productId: productId, userId: username))
        }

        return browsing
    }
//MARK: Remove from user browse history overloads
    func removeFromBrowseHistory(browseHistoryId : Int){
        let query = "delete from BrowseHistory where BrowseHistoryId = \(browseHistoryId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("removed product from browse history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing product from browse history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in remove product from browse history query", err)
        }

    }
    func removeFromBrowseHistory(productId : Int, username : NSString){
        let query = "delete from BrowseHistory where ProductId = \(productId) and UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("removed product from browse history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing product from browse history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in remove product from browse history query", err)
        }

    }
//MARK: Clear user's browsed items / browse history
    func clearUserBrowseHistory(username : NSString){
        let query = "delete from BrowseHistory where UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("cleared user browse history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in clearing user browse history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in clear browse history query", err)
        }

    }
//MARK: Remove product from all browse history
    func removeProductFromAllBrowseHistory(productId : Int){
        let query = "delete from BrowseHistory where ProductId = \(productId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("removed product from all browse history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing product from all browse history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in remove product from all browse history query", err)
        }

    }
}
