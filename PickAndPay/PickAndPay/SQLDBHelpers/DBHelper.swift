//
//  DBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//
import Foundation
import SQLite3
class DBHelper{
    
    static var dbHelper = DBHelper()
    var dbpointer : OpaquePointer?
    var users = [User]()
    var products = [Product]()
    var wishList = [WishListItem]()
    var history = [SearchHistoryItem]()
    var reviews = [Review]()
    var cart = [CartItem]()
    private init(){
        
    }
//MARK: Call createDB and createTAbles at program start
    func createDB(){
        
        //create file path for db
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor : nil, create: false).appendingPathComponent("ShopTest.sqlite")
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK{
            print("Cannot open database")
        }
    }
    
    func createTables(){
        createUserTable()
        createProductTable()
        createWishListTable()
        createSearchHistoryTable()
        createReviewTable()
        createItemCartTable()
        createCardTable()
        createOrderDetailsTable()
        createProductOrderTable()
    }
    
    func createUserTable(){
        
        let query = "create table if not exists User (UserId text primary key, Name text, Password text, Address text, PhoneNumber text, Balance double)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating User table", err)
        }
        else{
            print("success creating User table")
        }
    }
    
    func dropUserTable(){
        let query = "DROP TABLE IF EXISTS User"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in dropping User table", err)
        }
        else{
            print("success dropping User table")
        }
    }
    
    func createProductTable(){
        
        let query = "create table if not exists Product (ProductId integer primary key autoincrement, ProductName text, Image text, Price double, Category text, InStock integer)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating Product table", err)
        }
        else{
            print("success creatingProduct table")
        }
    }
    
    func createWishListTable(){
        
        let query = "create table if not exists WishList (WishListId integer primary key autoincrement, UserId text, ProductId integer)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating WishListtable", err)
        }
        else{
            print("success creating WishList table")
        }
    }
    
    func createSearchHistoryTable(){
        
        let query = "create table if not exists SearchHistory (SearchHistoryId integer primary key autoincrement, SearchPhrase text, TimesSearched integer, UserId text)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating SearchHistoryTable", err)
        }
        else{
            print("success creating SearchHistory table")
        }
    }
    
    func dropSearchHistoryTable(){
        let query = "DROP TABLE IF EXISTS SearchHistory"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in dropping SearchHistory table", err)
        }
        else{
            print("success dropping SearchHistory table")
        }
    }
    
    func createReviewTable(){
        
        let query = "create table if not exists Review (ReviewId integer primary key autoincrement, Body text, Rating double, date text, UserId text, ProductId integer)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating Review Table", err)
        }
        else{
            print("success creating Review table")
        }
    }
    
    func dropReviewTable(){
        let query = "DROP TABLE IF EXISTS Review"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in dropping Review table", err)
        }
        else{
            print("success dropping Review table")
        }
    }
    
    func createItemCartTable(){
        
        let query = "create table if not exists ItemCart (ItemCartId integer primary key autoincrement, Quantity integer, TotalPrice double, UserId text, ProductId integer)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating ItemCart Table", err)
        }
        else{
            print("success creating ItemCart table")
        }
    }
    
    func createCardTable(){
        
        let query = "create table if not exists Card (CardId integer primary key autoincrement, CardNumber text, Address text, CardName text, SecurityCode text, UserId text)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating CardTable", err)
        }
        else{
            print("success creating Card table")
        }
    }
    
    func dropCardTable(){
        let query = "DROP TABLE IF EXISTS Card"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in dropping Card table", err)
        }
        else{
            print("success dropping Card table")
        }
    }

    
    func createOrderDetailsTable(){
        
        let query = "create table if not exists OrderDetails (OrderId integer primary key autoincrement, Status text, NumberOfProducts integer, TotalPrice double, Date text, UserId text, CardId integer)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating OrderDetails Table", err)
        }
        else{
            print("success creating OrderDetails table")
        }
    }
    
    func createProductOrderTable(){
        let query = "create table if not exists ProductOrder (ProductOrderId integer primary key autoincrement, OrderId integer, ProductId integer, Quantity integer, TotalPrice double)"
        if sqlite3_exec(dbpointer, query, nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating ProudctOrder Table", err)
        }
        else{
            print("success creating ProductOrder table")
        }
    }

}
