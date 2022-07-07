//
//  OrderDBHelper.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-04.
//
import Foundation
import SQLite3
extension DBHelper{
//MARK: function when an order is placed overloads (automatically sums the total price plus the delivery fee)
    func placeOrder(shipAddress : NSString, payMode : NSString, billAddress : NSString, username : NSString, userCart : [CartItem]){
        //check if everything is in stock and calculate number of products and total order price
        var allInStock = true
        var notInStock = [Int]()
        var numberOfProducts = 0
        var totalOrderPrice = 0.0
        for item in userCart{
            if(!isInStock(productId: item.productId, qty: item.quantity)){
                allInStock = false
                notInStock.append(item.productId)
            }
            numberOfProducts += item.quantity
            totalOrderPrice += item.totalPrice
            //$10 delivery fee if order is less than $200
            if(totalOrderPrice < 200.0){
                totalOrderPrice += 10.0
            }
        }
        if(allInStock){
            insertOrderDetails(shipAddress: shipAddress, numOfProd: numberOfProducts, total: totalOrderPrice, payMode: payMode, billAddress: billAddress, username: username)
            let currentOrderId = getCurrentOrderId(username: username)
            for item in userCart{
                insertProductOrder(orderId: currentOrderId, item: item)
            }
        }
        else{
            print("Items not in Stock: ", notInStock)
        }
        
    }
    //checks if cart is empty then calls previous overload
    func placeOrder(shipAddress : NSString, payMode : NSString, billAddress : NSString, username : NSString){
        //get user's cart
        let userCart = getUserCart(username: username)
        if(!isCartEmpty(userCart: userCart)){
            //calls previous overload
            placeOrder(shipAddress: shipAddress, payMode: payMode, billAddress: billAddress, username: username, userCart: userCart)
        }
        else{
            print("Cart is Empty")
        }
        
    }
//MARK: Insert Order Details to database
    private func insertOrderDetails(shipAddress : NSString, numOfProd : Int, total : Double, payMode : NSString, billAddress : NSString, username : NSString){
        var stmt : OpaquePointer?
        let query = "insert into OrderDetails (Status, ShippingAddress, NumberOfProducts, TotalPrice, Date, PaymentMode, BillingAddress, UserId) values (?,?,?,?,?,?,?,?);"
        let statStr = NSString("Confirmed")
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            //bind parameters
            if sqlite3_bind_text(stmt, 1, statStr.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding order status", err)

            }
            if sqlite3_bind_text(stmt, 2, shipAddress.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding shipping address", err)

            }
            if sqlite3_bind_int(stmt, 3, Int32(numOfProd)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding number of products", err)

            }
            if sqlite3_bind_double(stmt, 4, total) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in binding retail price", err)
            }
            if sqlite3_bind_text(stmt, 5, getCurrentDate().utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding current date", err)

            }
            if sqlite3_bind_text(stmt, 6, payMode.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding payment mode", err)
                
            }
            if sqlite3_bind_text(stmt, 7, billAddress.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding shipping address", err)

            }
            if sqlite3_bind_text(stmt, 8, username.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding userId", err)

            }

            //insert
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("order details inserted")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in inserting order details", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating insert order details query", err)
        }

    }
//MARK: Insert product into orders overloads
        private func insertProductOrder(orderId : Int, productId : Int, qty : Int, total : Double){
            var stmt : OpaquePointer?
            let query = "insert into ProductOrder (Quantity, TotalPrice, OrderId, ProductId) values (?,?,?,?);"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                //bind parameters
                if sqlite3_bind_int(stmt, 1, Int32(qty)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding item quantity", err)

                }
                if sqlite3_bind_double(stmt, 2, total) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding total price based on qty", err)

                }
                if sqlite3_bind_int(stmt, 3, Int32(orderId)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding orderId", err)

                }
                if sqlite3_bind_int(stmt, 4, Int32(productId)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding producttId", err)

                }

                //insert
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("PRoduct Inserted to order")
                }
                else{
                    let err = String(cString: sqlite3_errmsg(dbpointer))
                    print("Error in inserting Product to order", err)
                }
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating insert product to order query", err)
            }
        }
//inserts product in order, removes it from cart, and updates the stock quantity based on order / this calls the previous overload
    private func insertProductOrder(orderId : Int, item : CartItem){
        insertProductOrder(orderId: orderId, productId: item.productId, qty: item.quantity, total: item.totalPrice)
        removeFromCart(itemCartId: item.itemCartId)
        removeFromProductStock(productId: item.productId, qty: item.quantity)
    }
//MARK: Get user's current orderId
    private func getCurrentOrderId(username : NSString) -> Int{
        var stmt : OpaquePointer?
        let query = "SELECT OrderId FROM OrderDetails ORDER BY OrderId DESC LIMIT 1"
        var num = 0
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getCurrentOrderId query", err)
            return num
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            num = Int(sqlite3_column_int(stmt, 0))
        }

        return num
    }


//MARK: Get All ordered products
    func getAllProductOrders() -> [ProductOrder]{
        orderedProducts.removeAll()
        let query = "select * from ProductOrder"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let orderId = Int(sqlite3_column_int(stmt, 1))
                let productId = Int(sqlite3_column_int(stmt, 2))
                let qty = Int(sqlite3_column_int(stmt, 3))
                let total = sqlite3_column_double(stmt, 4)
                orderedProducts.append(ProductOrder(id: id, orderId: orderId, productId: productId, qty: qty, totalPrice: total))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getAllProductOrder Query", err)
        }
        return orderedProducts
    }
//MARK: Get products in an order
    func getProductOrders(orderId : Int) -> [ProductOrder]{
        orderedProducts.removeAll()
        let query = "select * from ProductOrder where OrderId = \(orderId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let orderId = Int(sqlite3_column_int(stmt, 1))
                let productId = Int(sqlite3_column_int(stmt, 2))
                let qty = Int(sqlite3_column_int(stmt, 3))
                let total = sqlite3_column_double(stmt, 4)
                orderedProducts.append(ProductOrder(id: id, orderId: orderId, productId: productId, qty: qty, totalPrice: total))
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating get products in an order Query", err)
        }
        return orderedProducts
    }
//MARK: Get All orderDetails
    func getAllOrders() -> [Order]{
            orders.removeAll()
            var stmt : OpaquePointer?
            let query = "Select * from OrderDetails"
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer))
                print("Error in creating getAllOrders query", err)
                return orders
            }
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let stat = String(cString: sqlite3_column_text(stmt, 1))
                let ship = String(cString: sqlite3_column_text(stmt, 2))
                let num = Int(sqlite3_column_int(stmt, 3))
                let total = sqlite3_column_double(stmt, 4)
                let date = String(cString: sqlite3_column_text(stmt, 5))
                let mode = String(cString: sqlite3_column_text(stmt, 6))
                let bill = String(cString: sqlite3_column_text(stmt, 7))
                let user = String(cString: sqlite3_column_text(stmt, 8))
                orders.append(Order(id: id, status: OrderStatus(rawValue: stat) ?? .NoStatus, shipAddress: ship, numOfProducts: num, totalPrice: total, date: date, payMode: mode, billAddress: bill, userId: user))
                
            }

            return orders
    }
//MARK: Get all user's orders
    func getUserOrders(username : NSString) -> [Order]{
        orders.removeAll()
        var stmt : OpaquePointer?
        let query = "Select * from OrderDetails where UserId = '\(username)'"
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer))
            print("Error in creating getUserOrders query", err)
            return orders
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let stat = String(cString: sqlite3_column_text(stmt, 1))
            let ship = String(cString: sqlite3_column_text(stmt, 2))
            let num = Int(sqlite3_column_int(stmt, 3))
            let total = sqlite3_column_double(stmt, 4)
            let date = String(cString: sqlite3_column_text(stmt, 5))
            let mode = String(cString: sqlite3_column_text(stmt, 6))
            let bill = String(cString: sqlite3_column_text(stmt, 7))
            let user = String(cString: sqlite3_column_text(stmt, 8))
            orders.append(Order(id: id, status: OrderStatus(rawValue: stat) ?? .NoStatus, shipAddress: ship, numOfProducts: num, totalPrice: total, date: date, payMode: mode, billAddress: bill, userId: user))
            
        }

        return orders
    }
//MARK: Get single order detail
    func getOrder(orderId : Int) -> Order{
        let query = "select * from OrderDetails where OrderId = \(orderId)"
        var stmt : OpaquePointer?
        var orderDetails = Order()
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(stmt, 0))
                let stat = String(cString: sqlite3_column_text(stmt, 1))
                let ship = String(cString: sqlite3_column_text(stmt, 2))
                let num = Int(sqlite3_column_int(stmt, 3))
                let total = sqlite3_column_double(stmt, 4)
                let date = String(cString: sqlite3_column_text(stmt, 5))
                let mode = String(cString: sqlite3_column_text(stmt, 6))
                let bill = String(cString: sqlite3_column_text(stmt, 7))
                let user = String(cString: sqlite3_column_text(stmt, 8))
                orderDetails = Order(id: id, status: OrderStatus(rawValue: stat) ?? .NoStatus, shipAddress: ship, numOfProducts: num, totalPrice: total, date: date, payMode: mode, billAddress: bill, userId: user)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getOrder Query", err)
        }
        
        return orderDetails
    }
//MARK: Get order status
    func getOrderStatus(orderId : Int) -> OrderStatus{
        let query = "select Status from OrderDetails where OrderId = \(orderId)"
        var stmt : OpaquePointer?
        var stat = OrderStatus.NoOrder
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            while (sqlite3_step(stmt) == SQLITE_ROW){
                stat = OrderStatus(rawValue: String(cString: sqlite3_column_text(stmt, 0))) ?? .NoStatus
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in creating getOrderStatus Query", err)
        }
        
        return stat
    }
//MARK: Update order details / only shipping address and order status can be updated if order already confirmed and paid
    func updateOrderDetails(orderId : Int, status : OrderStatus, shipAddress : NSString){
        let stat = status.rawValue
        let query = "update OrderDetails SET Status = '\(stat)', ShippingAddress = '\(shipAddress)' where OrderId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(orderId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding orderId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("order details updated")
            }
            else{
                print("error in updating order details")
            }
        }
        else{
            print("Error in update order details query")
        }
    }
    func updateOrderStatus(orderId : Int, status : OrderStatus){
        let stat = status.rawValue
        let query = "update OrderDetails SET Status = '\(stat)' where OrderId = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_bind_int(stmt, 1, Int32(orderId)) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in binding orderId", err)

            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("order status updated")
            }
            else{
                print("error in updating order status")
            }
        }
        else{
            print("Error in update order status query")
        }
    }
    //can only change shipping address if order exists and not yet shipped or refunded
    func changeOrderShippingAddress(orderId : Int, shipAddress : NSString){
        let stat = getOrderStatus(orderId: 2)
        if(stat == .Shipped || stat == .Delivered || stat == .Refunded){
            print("Can't change shipping address, shipment already", stat)
        }
        else if(stat == .NoOrder){
            print("Order can't be found")
        }
        else{
            let query = "update OrderDetails SET ShippingAddress = '\(shipAddress)' where OrderId = ?;"
            var stmt : OpaquePointer?
            if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
                
                if sqlite3_bind_int(stmt, 1, Int32(orderId)) != SQLITE_OK{
                    let err = String(cString: sqlite3_errmsg(dbpointer)!)
                    print("error in binding orderId", err)

                }
                if sqlite3_step(stmt) == SQLITE_DONE{
                    print("order shipping address updated")
                }
                else{
                    print("error in updating order shipping address")
                }
            }
            else{
                print("Error in update order shipping address query")
            }
        }
        
    }
//MARK: Delete Order details / deleting order details also deletes its entries in ProductOrder table
    func deleteOrderDetails(orderId : Int){
        let query = "delete from OrderDetails where OrderId = \(orderId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("order details deleted")
                deleteProductOrders(orderId: orderId)
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in deleting order details", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in creating delete order details query", err)
        }
    }
    private func deleteProductOrders(orderId : Int){
        let query = "delete from ProductOrder where OrderId = \(orderId)"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("productOrders deleted")
            }
            else{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("Error in productOrders details", err)
            }
        }
        else{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("Error in creating delete productOrders query", err)
        }
    }
    
}

