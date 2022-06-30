//
//  SearchHistoryDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-30.
//

import Foundation
import SQLite3
extension DBHelper{
//MARK: Insert phrase to Search History or add 1 to TimesSearched if phrase already exists for user
    // can be called when user enters a search phrase
    func itemSearched(phrase : NSString, username : NSString){
        if(isSearchedFirstTime(phrase: phrase, userId: username)){
            insertToSearchHistory(phrase: phrase, userId: username)
        }
        else{
            addSearchCount(phrase: phrase, userId: username)
        }
    }
    private func isSearchedFirstTime(phrase : NSString, userId : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from SearchHistory where SearchPhrase = '\(phrase)' and UserId = '\(userId)'"
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
            print("first time search")
            return true
        }
        else{
            print("Not a first time search")
            return false
        }
    }
    private func insertToSearchHistory(phrase : NSString, userId : NSString){
            var stmt : OpaquePointer?
            let query = "insert into SearchHistory (SearchPhrase, TimesSearched, UserId) values (?,?,?);"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                //bind parameters
                if sqlite3_bind_text(stmt, 1, phrase.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding search phrase", err)

                }
                if sqlite3_bind_int(stmt, 2, 1) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding 1 times searched", err)

                }
                if sqlite3_bind_text(stmt, 3, userId.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding userId", err)

                }

                //insert
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("phrase Inserted to history")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer))
                    print("error in inserting phrase to history", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating insert to search history query", err)
            }

        }
    private func addSearchCount(phrase : NSString, userId : NSString){
        let query = "update SearchHistory SET TimesSearched = TimesSearched + 1 where SearchPhrase = '\(phrase)' and UserId = '\(userId)';"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("times searched + 1")
            }
            else{
                print("error in times searched + 1")
            }
        }
        else{
            print("Error in times searched + 1 query")
        }
    }
//MARK: get ALL history
    func getAllSearchHistory() -> [SearchHistoryItem]{
        history.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from SearchHistory"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllSearchHistory query", err)
            return history
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let phrase = String(cString: sqlite3_column_text(stmt, 1))
            let num = Int(sqlite3_column_int(stmt, 2))
            let username = String(cString: sqlite3_column_text(stmt, 3))
            history.append(SearchHistoryItem(id: id, searchPhrase: phrase, timesSearched: num, userId: username))
        }

        return history
    }
    
//MARK: get all user's search history/ searched phrases
    func getUserSearchHistory(username : NSString) -> [SearchHistoryItem]{
        history.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from SearchHistory where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserSearchHistory query", err)
            return history
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let phrase = String(cString: sqlite3_column_text(stmt, 1))
            let num = Int(sqlite3_column_int(stmt, 2))
            let username = String(cString: sqlite3_column_text(stmt, 3))
            history.append(SearchHistoryItem(id: id, searchPhrase: phrase, timesSearched: num, userId: username))
        }

        return history
    }
    
//MARK: delete a user's search entry overloads
    func deleteUserSearchEntry(searchHistoryId : Int){
        let query = "delete from SearchHistory where SearchHistoryId = \(searchHistoryId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("phrase removed from user history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting phrase from user history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete search entry query", err)
        }

    }
    func deleteUserSearchEntry(phrase : NSString, username : NSString){
        let query = "delete from SearchHistory where SearchPhrase = '\(phrase)' and UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("phrase removed from user history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting phrase from user history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete search entry query", err)
        }

    }
    
//MARK: Clear user's search history
    func clearUserSearchHistory(username : NSString){
        let query = "delete from SearchHistory where UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("cleared user search history")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in clearing user search history", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in clear search history query", err)
        }

    }
}
