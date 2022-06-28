//
//  ProductDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//
import Foundation
import SQLite3
extension DBHelper{
    
    func insertProduct(name : NSString, image : NSString, price : Double, category : Category, stock : Int){
        var stmt : OpaquePointer?
        let query = "insert into Product (ProductName, Image, Price, Category, InStock) values (?,?,?,?,?);"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            //bind parameters
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in creating query", err)
            }
            if sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding product name", err)

            }
            if sqlite3_bind_text(stmt, 2, image.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding password", err)

            }
            if sqlite3_bind_double(stmt, 3, price) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in binding retail price", err)
            }
            let catString = NSString(string: category.rawValue)
            if sqlite3_bind_text(stmt, 4, catString.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding category", err)

            }
            if sqlite3_bind_int(stmt, 5, Int32(stock)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding phone number", err)

            }

            //insert
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("PRoduct Created")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating Product", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating insert product query", err)
        }

    }
    
    func getAllProducts() -> [Product]{
        products.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Product"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getAllProducts query", err)
            return products
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let img = String(cString: sqlite3_column_text(stmt, 2))
            let price = sqlite3_column_double(stmt, 3)
            let cat = String(cString: sqlite3_column_text(stmt, 4))
            let stock = Int(sqlite3_column_int(stmt, 5))
            products.append(Product(id: id, name: name, image: img, price: price, category: Category(rawValue: cat) ?? .NoCategory, inStock: stock))

        }

        return products
    }
    
    func getProductsForCategory(category : Category) -> [Product]{
        products.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Product where Category = '\(category)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getProducts from category query", err)
            return products
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let img = String(cString: sqlite3_column_text(stmt, 2))
            let price = sqlite3_column_double(stmt, 3)
            let cat = String(cString: sqlite3_column_text(stmt, 4))
            let stock = Int(sqlite3_column_int(stmt, 5))
            products.append(Product(id: id, name: name, image: img, price: price, category: Category(rawValue: cat) ?? .NoCategory, inStock: stock))

        }

        return products
    }
    
    func getProduct(productId : Int) -> Product{
        let query = "select * from Product where ProductId = \(productId)"
        var stmt : OpaquePointer?
        let product = Product()
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                product.productId = Int(sqlite3_column_int(stmt, 0))
                product.productName = String(cString: sqlite3_column_text(stmt, 1))
                product.productImage = String(cString: sqlite3_column_text(stmt, 2))
                product.price = sqlite3_column_double(stmt, 3)
                product.category = Category(rawValue: String(cString: sqlite3_column_text(stmt, 4))) ?? Category.NoCategory
                product.stock = Int(sqlite3_column_int(stmt, 5))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getProductQuery", err)
        }
        
        return product
    }
}

