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
        fashion()
        grocery()
    }
    
    private func electronics(){
        db.insertProduct(name: "LG 8K LCD TV", image: "tv", price: 1629.99, category: .Electronics, stock: 15, description: "LG 8K NanoCell TV NANO99 is our best 8K LED TV. It’s four times the resolution of 4K across 33+ million pixels.")
        db.insertProduct(name: "PS5", image: "PS5", price: 629.99, category: .Electronics, stock: 25, description: "God of WAR Nov.11 Disc Edtion")
        db.insertProduct(name: "PS4", image: "PS4", price: 379.99, category: .Electronics, stock: 20, description: "good for gamers")
        db.insertProduct(name: "Xbox Series S", image: "Xbox Series S", price: 379.99, category: .Electronics, stock: 20, description: "Lesser New Xbox (Doesn't have disc drive)")
        db.insertProduct(name: "Xbox Series X", image: "Xbox Series X", price: 629.99, category: .Electronics, stock: 10, description: "Greater New Xbox (Has Disc Drive)")
    }
    
    private func books(){
        db.insertProduct(name: "Harry Potter book set", image: "hpbookset", price: 90.00, category: .Books, stock: 32, description: "The enduringly popular adventures of Harry, Ron and Hermione have gone on to sell over 500 million copies, be translated into over 80 languages and made into eight blockbuster films.")
        db.insertProduct(name: "Lord of the Rings book set", image: "lotrbookset", price: 69.99, category: .Books, stock: 32, description: "The Lord of the Rings, features striking black covers based on Tolkien's own design, the definitive text, and three maps including a detailed map of Middle-earth")
        db.insertProduct(name: "Catcher in the Rye", image: "Catcher in the Rye", price: 12.86, category: .Books, stock: 32, description: "The Catcher in the Rye, novel by J.D. Salinger published in 1951. The novel details two days in the life of 16-year-old Holden Caulfield after he has been expelled from prep school")
        db.insertProduct(name: "The Little Prince", image: "The Little Prince", price: 12.00, category: .Books, stock: 12, description: "The story follows a young prince who visits various planets in space, including Earth, and addresses themes of loneliness, friendship, love, and loss.")
        db.insertProduct(name: "Getting Your Book Published for Dummies", image: "Getting Your Book Published for Dummies", price: 28.75, category: .Books, stock: 45, description: "Full of examples, proposals, query letters, and war stories drawn from the authors' extensive experience")
    }
    
    private func essentials(){
        db.insertProduct(name: "8-piece cookware", image: "cookware", price: 99.00, category: .Essentials, stock: 32, description: "8-piece nonstick cookware set includes 8-inch fry pan, 10-inch fry pan, 1.5-quart sauce pan with lid, 2 quart saucepan with lid, and 3-quart casserole pan with lid")
        db.insertProduct(name: "Medium Coffee Table", image: "table", price: 199.00, category: .Essentials, stock: 12, description: "This Wood industrial coffee table born with quaint and organic charm. A mix of classic material and rustic fashion appearance makes the square table fit well with any furniture style in your living room as a basic home decor, making your home/office space stylish.")
        db.insertProduct(name: "Teleporter", image: "Teleport Machine", price: 1099.00, category: .Essentials, stock: 1, description: "Mr Hankey's Teleportation Device toally legit")
        db.insertProduct(name: "Towelie", image: "Towelie", price: 39.95, category: .Essentials, stock: 3, description: "Weed Smoking Towel ;)")
        db.insertProduct(name: "Old sword", image: "Finns", price: 100.00, category: .Essentials, stock: 12, description: "Probably used by finn in adventure time")
    }
    
    private func fashion(){
        db.insertProduct(name: "Nike Air Force 1 Red", image: "redshoe", price: 120.00, category: .Fashion, stock: 32, description: "Limited Edition Nike Air Force 1's are surely to bring you some street cred.")
        db.insertProduct(name: "Mens Reebok Vest", image: "vest", price: 50.00, category: .Fashion, stock: 8, description: "Mens Reebok vest that is stylish and comfortable for everyday use")
        db.insertProduct(name: "Womens Columbia beige waterproof jacket", image: "jacket", price: 80.00, category: .Fashion, stock: 18, description: "For more than 80 years, Columbia Sportswear Company has been making gear for people who enjoy the rugged outdoors found in the Pacific Northwest and far beyond.")
        db.insertProduct(name: "Calvin Klein 2-peice suit", image: "suit", price: 250.00, category: .Fashion, stock: 13, description: "The advantage of the Calvin Klein Slim Fit Suit Separate is the ability to customize your jacket and pant size.")
        db.insertProduct(name: "Levi's Jeans womens", image: "jeans", price: 60.00, category: .Fashion, stock: 8, description: "These jeans are not a high waist nor a low waist type jeans. No matter what your figure, these mid will definetly become a member of your closet. Mid Rise will make you look taller !")
        
    }
    
    private func grocery(){
        db.insertProduct(name: "2LB Fresh Carrots", image: "carrots", price: 8.00, category: .Grocery, stock: 72, description: "Fresh and crunchy carrots, great for a snack")
        db.insertProduct(name: "5LB Fresh Gala Apples", image: "apples", price: 10.00, category: .Grocery, stock: 43, description: "Fresh and crunchy gala apples, great for a snack")
        db.insertProduct(name: "12 Free Range Eggs", image: "eggs", price: 6.00, category: .Grocery, stock: 22, description: "A dozen free range eggs straight from the farm into your arms")
        db.insertProduct(name: "Flamin' Hot Cheetoes 310g", image: "chips", price: 3.25, category: .Grocery, stock: 88, description: "Flmain' Hot Cheetoes are the perfect snack for yoyr munchies and more")
        db.insertProduct(name: "White Sliced bread", image: "bread", price: 4.00, category: .Grocery, stock: 32, description: "Freshly baked bread just like grandma used to make")
        
    }
}

