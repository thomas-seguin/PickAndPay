//
//  InsertProductData.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-18.
//
import Foundation
class InsertProductData{
    
    static var populate = InsertProductData()
    private var  db = DBHelper.dbHelper
    private init(){

    }
    
//MARK: Call this the first time you run the app
    func populateCategories(){
        electronics()
        books()
        essentials()
    }
    
    private func electronics(){
        db.insertProduct(name: "PS5", image: "PS5", price: 629.99, category: .Electronics, stock: 5, description: "God of WAR Nov.11 Disc Edtion")
        db.insertProduct(name: "PS4", image: "PS4", price: 379.99, category: .Electronics, stock: 20, description: "good for gamers")
        db.insertProduct(name: "Xbox Series S", image: "Xbox Series S", price: 379.99, category: .Electronics, stock: 20, description: "Lesser New Xbox (Doesn't have disc drive)")
        db.insertProduct(name: "Xbox Series X", image: "Xbox Series X", price: 629.99, category: .Electronics, stock: 10, description: "Greater New Xbox (Has Disc Drive)")
    }
    
    private func books(){
        db.insertProduct(name: "Catcher in the Rye", image: "Catcher in the Rye", price: 12.86, category: .Books, stock: 32, description: "The Catcher in the Rye, novel by J.D. Salinger published in 1951. The novel details two days in the life of 16-year-old Holden Caulfield after he has been expelled from prep school")
        db.insertProduct(name: "The Little Prince", image: "The Little Prince", price: 12.00, category: .Books, stock: 12, description: "The story follows a young prince who visits various planets in space, including Earth, and addresses themes of loneliness, friendship, love, and loss.")
        db.insertProduct(name: "Getting Your Book Published for Dummies", image: "Getting Your Book Published for Dummies", price: 28.75, category: .Books, stock: 45, description: "Full of examples, proposals, query letters, and war stories drawn from the authors' extensive experience")
    }
    
    private func essentials(){
        db.insertProduct(name: "Teleporter", image: "Teleport Machine", price: 1099.00, category: .Essentials, stock: 1, description: "Mr Hankey's Teleportation Device toally legit")
        db.insertProduct(name: "Towelie", image: "Towelie", price: 39.95, category: .Essentials, stock: 3, description: "Weed Smoking Towel")
        db.insertProduct(name: "Old sword", image: "Finns", price: 100.00, category: .Essentials, stock: 12, description: "Probably used by finn in adventure time")
    }
}

