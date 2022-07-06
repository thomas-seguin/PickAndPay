//
//  CreditCardDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-04.
//
import Foundation
import SQLite3
extension DBHelper{
//MARK: Check if cardnumber exists within user's payment options
    func doesUserCardExist(cardNumber : NSString, username : NSString) -> Bool{
        var stmt : OpaquePointer?
        let query = "Select * from Card where CardNumber = '\(cardNumber)' and UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating doesUserCardExist query", err)
        }
        var resultCount = 0
        while(sqlite3_step(stmt) == SQLITE_ROW){
            resultCount = 1
        }
        if(resultCount <= 0)
        {
            print("card doesnt exist for user")
            return false
        }
        else{
            print("card exists for user")
            return true
        }
    }
//MARK: Remeber user's card within payment options / checks if it exists before adding
    func addCard(cardNumber : NSString, address : NSString, cardName : NSString, username : NSString){
        if(!doesUserCardExist(cardNumber: cardNumber, username: username)){
            var stmt : OpaquePointer?
            let query = "insert into Card (cardNumber, Address, CardName, UserId) values (?,?,?,?);"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                //bind parameters
                if sqlite3_bind_text(stmt, 1, cardNumber.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding card number", err)

                }
                if sqlite3_bind_text(stmt, 2, address.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding billing address", err)

                }
                if sqlite3_bind_text(stmt, 3, cardName.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding cardholder name", err)

                }
                if sqlite3_bind_text(stmt, 4, username.utf8String, -1, nil) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding username", err)

                }
                

                //insert
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("card added to user's payment options")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer))
                    print("error in adding card to payment options", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating insert card query", err)
            }
        }
        else{
            print("user's card already exist ")
        }

    }
//MARK: Get all cards
    func getAllCards() -> [Card]{
        cards.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Card"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllCards query", err)
            return cards
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let num = String(cString: sqlite3_column_text(stmt, 1))
            let add = String(cString: sqlite3_column_text(stmt, 2))
            let name = String(cString: sqlite3_column_text(stmt, 3))
            let user = String(cString: sqlite3_column_text(stmt, 4))
            cards.append(Card(id: id, cardNumber: num, address: add, name: name, userId: user))
        }

        return cards
    }
//MARK: Get all user's cards
    func getUserCards(username : NSString) -> [Card]{
        cards.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Card where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserCards query", err)
            return cards
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let num = String(cString: sqlite3_column_text(stmt, 1))
            let add = String(cString: sqlite3_column_text(stmt, 2))
            let name = String(cString: sqlite3_column_text(stmt, 3))
            let user = String(cString: sqlite3_column_text(stmt, 4))
            cards.append(Card(id: id, cardNumber: num, address: add, name: name, userId: user))
        }

        return cards
    }
//MARK: Get a single card
    func getCard(cardId : Int) -> Card{
        let query = "select * from Card where CardId = \(cardId)"
        var stmt : OpaquePointer?
        var card = Card()
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                card.cardId = Int(sqlite3_column_int(stmt, 0))
                card.cardNumber = String(cString: sqlite3_column_text(stmt, 1))
                card.address = String(cString: sqlite3_column_text(stmt, 2))
                card.cardName = String(cString: sqlite3_column_text(stmt, 3))
                card.userId = String(cString: sqlite3_column_text(stmt, 4))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getCard query", err)
        }
        
        return card
    }
//MARK: Update card details overload
    func updateCard(cardId : Int, address : NSString, cardName : NSString){
        let query = "update Card SET Address = '\(address)', CardName = '\(cardName)' where CardId = \(cardId);"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("card updated")
            }
            else{
                print("error in updating card")
            }
        }
        else{
            print("Error in update card query")
        }
    }
    func updateCard(cardNumber : NSString,  address : NSString, cardName : NSString, username : NSString){
        let query = "update Card SET Address = '\(address)', CardName = '\(cardName)' where CardNumber = '\(cardNumber)' and UserId = '\(username)';"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("card updated")
            }
            else{
                print("error in updating card")
            }
        }
        else{
            print("Error in update card query")
        }
    }
//MARK: Delete a card overlaods
    func deleteCard(cardId : Int){
        let query = "delete from Card where CardId = \(cardId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("card removed from payment options")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing card", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete card query", err)
        }

    }
    func deleteCard(cardNumber : NSString, username : NSString){
        let query = "delete from Card where CardNumber = '\(cardNumber)' and UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("card removed from payment options")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in removing card", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete card query", err)
        }

    }
//MARK: Delete all user's cards
    func deleteAllUsersCards(username : NSString){
        let query = "delete from Card where UserId = '\(username)'"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("removed all user's cards")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in Deleting all user's cards", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in delete all user's cards query", err)
        }
    }
}

