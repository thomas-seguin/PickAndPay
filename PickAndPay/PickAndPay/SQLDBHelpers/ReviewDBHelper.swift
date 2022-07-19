//
//  ReviewDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-30.
//

import Foundation
import SQLite3
extension DBHelper{

    
    func getCurrentDate() -> NSString{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return NSString(string: dateFormatter.string(from: Date()))
    }
//MARK: Create / Insert REview
    //sets date to current date "yyyy/mm/dd"
    func insertReview(body : NSString, rating : Double, username : NSString, productId : Int, title : NSString){
        var stmt : OpaquePointer?
        let query = "insert into Review (Body, Rating, Date, UserId, ProductId, title) values (?,?,?,?,?,?);"
        
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                //bind parameters
                if sqlite3_bind_text(stmt, 1, body.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding review body", err)

                }
                if sqlite3_bind_double(stmt, 2, rating) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding review rating", err)

                }
                if sqlite3_bind_text(stmt, 3, getCurrentDate().utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding date", err)

                }
                if sqlite3_bind_text(stmt, 4, username.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding username", err)

                }
                if sqlite3_bind_int(stmt, 5, Int32(productId)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding productId", err)

                }
                if sqlite3_bind_text(stmt, 6, title.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding title", err)

                }

                //insert
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("review inserted")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer))
                    print("Error in inserting reviewt", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating insert review query", err)
            }

        }
//MARK: Get ALL reviews
    func getAllReviews() -> [Review]{
        reviews.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Review"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllReviews query", err)
            return reviews
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let body = String(cString: sqlite3_column_text(stmt, 1))
            let rating = sqlite3_column_double(stmt, 2)
            let date = String(cString: sqlite3_column_text(stmt, 3))
            let username = String(cString: sqlite3_column_text(stmt, 4))
            let prodId = Int(sqlite3_column_int(stmt, 5))
            let title = String(cString: sqlite3_column_text(stmt, 6))
            reviews.append(Review(id: id, body: body, rating: rating, date: date, userId: username, productId: prodId, title: title))
            
        }

        return reviews
    }
//MARK: Get product reviews
    func getProductReviews(productId : Int) -> [Review]{
        reviews.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Review where ProductId = \(productId)"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getProductReviews query", err)
            return reviews
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let body = String(cString: sqlite3_column_text(stmt, 1))
            let rating = sqlite3_column_double(stmt, 2)
            let date = String(cString: sqlite3_column_text(stmt, 3))
            let username = String(cString: sqlite3_column_text(stmt, 4))
            let prodId = Int(sqlite3_column_int(stmt, 5))
            let title = String(cString: sqlite3_column_text(stmt, 6))
            reviews.append(Review(id: id, body: body, rating: rating, date: date, userId: username, productId: prodId, title: title))
            
        }

        return reviews
    }
//MARK: Get user's reviews on all products
    func getUserReviews(username : NSString) -> [Review]{
            reviews.removeAll()
            var stmt : OpaquePointer?
            let query = "Select * from Review where UserId = '\(username)'"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating get User's Reviews query", err)
                return reviews
            }
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let body = String(cString: sqlite3_column_text(stmt, 1))
                let rating = sqlite3_column_double(stmt, 2)
                let date = String(cString: sqlite3_column_text(stmt, 3))
                let username = String(cString: sqlite3_column_text(stmt, 4))
                let prodId = Int(sqlite3_column_int(stmt, 5))
                let title = String(cString: sqlite3_column_text(stmt, 6))
                reviews.append(Review(id: id, body: body, rating: rating, date: date, userId: username, productId: prodId, title: title))
                
            }

            return reviews
        }
//MARK: Checks if user have already reviewed the product
    func haveUserReviewedProduct(username : NSString, productId : Int) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from Review where UserId = '\(username)' and ProductId = \(productId)"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating haveUserReviewedProduct query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount == 0)
        {
            print("User have not reviewed product")
            return false
        }
        else{
            print("User have reviewed product")
            return true
        }
    }
//MARK: Update Review
    //also sets date to current date
    func updateReview(reviewId : Int, body : NSString, rating : Double){
        let query = "update Review SET Body = '\(body)', Rating = \(rating), Date = '\(getCurrentDate())' where ReviewId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(reviewId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding reviewId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("prduct review updated")
            }
            else{
                print("error in updating product review")
            }
        }
        else{
            print("Error in update product review query")
        }
    }
//MARK: Delete a single Review
    func deleteReview(reviewId : Int){
        let query = "delete from Review where ReviewId = \(reviewId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("review deleted")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting review", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete review query", err)
        }

    }
//MARK: Delete All User Reviews
    func deleteAllUserReviews(username : NSString){
        let query = "delete from Review where UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user reviews deleted")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting user reviews", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete user reviews query", err)
        }

    }
//MARK: Delete ALL Product Reviews
    func deleteAllProductReviews(productId : Int){
        let query = "delete from Review where ProductId = \(productId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("user reviews deleted")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting user reviews", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete user reviews query", err)
        }
    }
}
