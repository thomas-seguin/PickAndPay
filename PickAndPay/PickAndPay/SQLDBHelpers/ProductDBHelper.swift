//
//  ProductDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-06-28.
//
import Foundation
import SQLite3
extension DBHelper{
    
//MARK: Create / Populate product table
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
    
//MARK: searhcProducts Overloads
    
    func searchProducts() -> [Product]{
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
    
    func searchProducts(category : Category) -> [Product]{
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
    
    func searchProducts(searchParameter : String) -> [Product]{
        products.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Product where ProductName like '%\(searchParameter)%'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating SearchProducts query", err)
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
    
    func searchProducts(searchParameter : String, category : Category) -> [Product]{
        products.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from Product where ProductName like '%\(searchParameter)%' and Category = '\(category)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating SearchProducts query", err)
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
    
    
//MARK: get single product detail
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
    
    
//MARK: Update product details
    
    func updateProduct(productId : Int, name : NSString, image : NSString, price : Double, category : Category, stock : Int){
        let query = "update Product SET ProductName = '\(name)', Image = '\(image)', Price = \(price), Category = '\(category)', InStock = \(stock) where ProductId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(productId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding productId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("prduct details updated")
            }
            else{
                print("error in updating product details")
            }
        }
        else{
            print("Error in update product query")
        }
    }
    
    func updateProductStock(productId : Int, stock : Int){
        let query = "update Product SET InStock = \(stock) where ProductId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(productId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding productId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("prduct stock number updated")
            }
            else{
                print("error in updating product stock")
            }
        }
        else{
            print("Error in update product stock query")
        }
        
    }
    
//MARK: get a product's remaining stock quantity
    func getStockQty(productId : Int) -> Int{
        let query = "select InStock from Product where ProductId = \(productId)"
        var stmt : OpaquePointer?
        var stockNum = 0
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                stockNum = Int(sqlite3_column_int(stmt, 0))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getStockQty", err)
        }
        
        return stockNum
    }
//MARK: Delete a product
        func deleteProduct(productId : Int){
            let query = "delete from Product where ProductId = \(productId)"
            var stmt : OpaquePointer?
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("product deleted")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("Error in Deleting prodcut", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in delete product query", err)
            }

        }
    
}
