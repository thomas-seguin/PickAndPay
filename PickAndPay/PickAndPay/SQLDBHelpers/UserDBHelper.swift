//
//  UserDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//

import Foundation
import SQLite3
extension DBHelper{
    
//MARK: Register User
    func insertUser(username : NSString, password : NSString, name : NSString, address : NSString, number : NSString){
        var stmt : OpaquePointer?
        let query = "insert into User (UserId, Password, Name, Address, PhoneNumber, Balance, Verified) values (?,?,?,?,?,?,?);"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            //bind parameters
            if sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding username", err)

            }
            if sqlite3_bind_text(stmt, 2, password.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding password", err)

            }
            if sqlite3_bind_text(stmt, 3, name.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding name", err)

            }
            if sqlite3_bind_text(stmt, 4, address.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding address", err)

            }
            if sqlite3_bind_text(stmt, 5, number.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding phone number", err)

            }
            if sqlite3_bind_double(stmt, 6, 0.0) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in binding 0.0 balance", err)
            }
            
            if sqlite3_bind_int(stmt, 7,1) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in binding verified", err)
            }
    
            //insert
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("User Created")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating User", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating insert question query", err)
        }

    }
//MARK: Get all registered users
    func getAllUsers() -> [User]{
        users.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from User"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllUsers query", err)
            return users
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let pass = String(cString: sqlite3_column_text(stmt, 2))
            let address = String(cString: sqlite3_column_text(stmt, 3))
            let number = String(cString: sqlite3_column_text(stmt, 4))
            let bal = sqlite3_column_double(stmt, 5)
            users.append(User(userId: id, password: pass, name: name, address: address, number: number, balance: bal))

        }

        return users
    }
//MARK: validation
    func doesUserExist(username : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from User where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating doesUserExist query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            return false
        }
        else{
            return true
        }
    }
    
    func isPassCorrect(username : NSString, password : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from User where UserId = '\(username)' AND Password = '\(password)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating doesUserExist query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            return false
        }
        else{
            return true
        }
    }
//MARK: Get single user data
    func getUser(username : NSString) -> User{
        let query = "select * from User where UserId = '\(username)'"
        var stmt : OpaquePointer?
        var user = User()
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                user.userId = String(cString: sqlite3_column_text(stmt, 0))
                user.name = String(cString: sqlite3_column_text(stmt, 1))
                user.password = String(cString: sqlite3_column_text(stmt, 2))
                user.address = String(cString: sqlite3_column_text(stmt, 3))
                user.phoneNumber = String(cString: sqlite3_column_text(stmt, 4))
                user.currentBalance = sqlite3_column_double(stmt, 5)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getUserQuery", err)
        }
        
        return user
    }
    
    //MARK: Get Verified Status
    
    func getVerified(username: NSString) -> Int{
        let query = "select Verified from User where UserId = '\(username)'"
        var stmt : OpaquePointer?
        var res: Int = 10
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                res = Int(sqlite3_column_int(stmt, 0))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getVerified", err)
        }
        
        return res
    }
    
//MARK: Update User details
    func updateUser(username : NSString, password : NSString, name : NSString, address : NSString, number : NSString, balance : Double){
        let query = "update User SET Password = '\(password)', Name = '\(name)', Address = '\(address)' ,PhoneNumber = '\(number)', Balance = \(balance) where UserId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user updated")
            }
            else{
                print("error in updating details")
            }
        }
        else{
            print("Error in update user query")
        }
    }
    
    
    //MARK: Update User Verify
    func updateVerifyUser(verified : Int, username: NSString){
            let query = "update User SET Verified = '\(verified)'where UserId = ?;"
            var stmt : OpaquePointer?
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("user updated")
                }
                else{
                    print("error in updating details")
                }
            }
            else{
                print("Error in update user query")
            }
        }
    
    func changePassword(username : NSString, password : NSString){
        let query = "update User SET Password = '\(password)' where UserId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user password changed")
            }
            else{
                print("error in changing password")
            }
        }
        else{
            print("Error in changepass query")
        }

    }
//MARK: when user uses balance or got a refund (add to balance)
    func updateUserBalance(username : NSString, balance : Double){
        let query = "update User SET Balance = \(balance) where UserId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user balance updated")
            }
            else{
                print("error in updating balance")
            }
        }
        else{
            print("Error in update userbalance query")
        }

    }

//MARK: Get user's reamining balance
    func getUserBalance(username : NSString) -> Double{
        let query = "select Balance from User where UserId = '\(username)'"
        var stmt : OpaquePointer?
        var bal = 0.0
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                bal = sqlite3_column_double(stmt, 0)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getUserBalanceQuery", err)
        }
        
        return bal
    }
    
}
