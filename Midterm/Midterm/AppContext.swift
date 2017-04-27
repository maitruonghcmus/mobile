//
//  AppContext.swift
//  Midterm
//
//  Created by Truong Mai on 4/18/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AppContext: NSObject {
    
    static let Instance = AppContext()
    
    var Areas : [Area] = []
    var Tables : [Table] = []
    var MenuItems : [MenuItem] = []
    var Orders : [Order] = []
    var OrderDetails : [OrderDetail] = []
    
    private override init(){
        for i in 1..<3{
            let area = Area(Id: i, Name: "Area \(i)", Description: "", Images: [Image]())
            Areas.append(area)
        }
        
        for i in 1..<10{
            let table = Table(Id: i, Name: "Table \(i)", Description: "", Images: [Image](), Area: Areas.first!, TableStatus: (i % 2 == 0 ? 0 : 1))
            Tables.append(table)
            
            let menuItem = MenuItem(Id: i, Name: "Food \(i)", Description: "description", Price: 100000, Images: [Image](), MenuItemType: 1)
            MenuItems.append(menuItem)
            
            let order = Order(Id: i, OrderDate: Date(), Customer: "anh \(i)", TableId: i, Table: Table(), Total: 100000, Currency: 0, Status: 1)
            Orders.append(order)
        }
    }
    
    func calcRevenueByDate(date: Date) -> Double {
        let orders = DataContext.Instance.Orders.all()
        //let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        
        if count > 0{
            for i in 0..<count {
                if orders[i].OrderDate == date {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    func calcRevenueByMonth(month: Int, year: Int) -> Double {
        let orders = DataContext.Instance.Orders.all()
        //let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        if count > 0{
            for i in 0..<count {
                let orderMonth = AppUtils.GetMonthOfDate(date: orders[i].OrderDate)
                //let currentMonth = AppUtils.GetMonthOfDate(date: Date())
                let orderYear = AppUtils.GetYearOfDate(date: orders[i].OrderDate)
                //let currentYear = AppUtils.GetYearOfDate(date: Date())
                
                if orderMonth == month && orderYear == year {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    func calcRevenueByYear(year: Int) -> Double {
        let orders = DataContext.Instance.Orders.all()
        //let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        if count > 0{
            for i in 0..<count {
                
                let orderYear = AppUtils.GetYearOfDate(date: orders[i].OrderDate)
                //let currentYear = AppUtils.GetYearOfDate(date: Date())
                
                if orderYear == year {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    //MARK: *** Add
    
    func AddArea(area:Area) -> Bool {
        if QueryContext.Instance.Insert(object: area) {
            
            area.Id = AppUtils.RandomInt()
            
            Areas.append(area)
            return true
        }
        return false
    }
    
    func AddTable(table:Table) -> Bool {
        if QueryContext.Instance.Insert(object: table){
            
            table.Id = AppUtils.RandomInt()
            
            Tables.append(table)
            return true
        }
        return false
    }
    
    func AddMenuItem(item:MenuItem) -> Bool {
        if QueryContext.Instance.Insert(object: item) {
            
            item.Id = AppUtils.RandomInt()
            
            MenuItems.append(item)
            return true
        }
        return false
    }
    
    func AddOrder(order:Order) -> Bool {
        if QueryContext.Instance.Insert(object: order) {
            
            order.Id = AppUtils.RandomInt()
            
            Orders.append(order)
            return true
        }
        return false
    }
    
    func AddOrderDetail(orderDetail:OrderDetail) -> Bool {
        if QueryContext.Instance.Insert(object: orderDetail) {
            
            orderDetail.SequenceNumber = AppUtils.RandomInt()
            
            OrderDetails.append(orderDetail)
            return true
        }
        return false
    }
    
    //MARK: *** Update
    
    func UpdateArea(area:Area) -> Bool{
        
        var result = false
        
        let index = Areas.index(where: {$0.Id == area.Id})
        
        if index != nil {
            if QueryContext.Instance.Update(object: area){
                Areas[index!] = area
            }
            
            result = true
        }
        
        return result
    }
    
    func UpdateTable(table:Table) -> Bool{
        
        var result = false
        
        let index = Tables.index(where: {$0.Id == table.Id})
        
        if index != nil {
            if QueryContext.Instance.Update(object: table){
                Tables[index!] = table
            }
            
            result = true
        }
        
        return result
    }
    
    func UpdateMenuItem(menuItem:MenuItem) -> Bool{
        
        var result = false
        
        let index = MenuItems.index(where: {$0.Id == menuItem.Id})
        
        if index != nil {
            if QueryContext.Instance.Update(object: menuItem){
                MenuItems[index!] = menuItem
            }
            
            result = true
        }
        
        return result
    }
    
    func UpdateOrder(order:Order) -> Bool{
        
        var result = false
        
        let index = Orders.index(where: {$0.Id == order.Id})
        
        if index != nil {
            if QueryContext.Instance.Update(object: order){
                Orders[index!] = order
            }
            
            result = true
        }
        
        return result
    }
    
    func UpdateOrderDetail(orderDetail:OrderDetail) -> Bool{
        
        var result = false
        
        let index = OrderDetails.index(where: {$0.OrderId == orderDetail.OrderId && $0.SequenceNumber == orderDetail.SequenceNumber})
        
        if index != nil {
            if QueryContext.Instance.Update(object: orderDetail){
                OrderDetails[index!] = orderDetail
            }
            
            result = true
        }
        
        return result
    }
    
    
    //MARK: *** Remove
    
    func RemoveAreaAtIndex(index: Int) -> Bool{
        var result = false
        
        if Areas.count > 0 && index >= 0 && index <= Areas.count{
            Areas.remove(at: index)
            result = true
        }
        
        return result
    }
    
    func RemoveTableAtIndex(index: Int) -> Bool{
        var result = false
        
        if Tables.count > 0 && index >= 0 && index <= Tables.count{
            Tables.remove(at: index)
            result = true
        }
        
        return result
    }
    
    func RemoveMenuItemAtIndex(index: Int) -> Bool{
        var result = false
        
        if MenuItems.count > 0 && index >= 0 && index <= MenuItems.count{
            MenuItems.remove(at: index)
            result = true
        }
        
        return result
    }
    
    func RemoveOrderAtIndex(index: Int) -> Bool{
        var result = false
        
        if Orders.count > 0 && index >= 0 && index <= Orders.count{
            Orders.remove(at: index)
            result = true
        }
        
        return result
    }
    
    func RemoveOrderDetailAtIndex(index: Int) -> Bool{
        var result = false
        
        if OrderDetails.count > 0 && index >= 0 && index <= OrderDetails.count{
            OrderDetails.remove(at: index)
            result = true
        }
        
        return result
    }
    
    
    func RemoveArea(area:Area) -> Bool{
        
        var result = false
        
        let index = Areas.index(where: {$0.Id == area.Id})
        
        if index != nil {
            if QueryContext.Instance.Delete(object: area){
                _ = self.RemoveAreaAtIndex(index: index!)
            }
            result = true
        }
        
        return result
    }
    
    func RemoveTable(table:Table) -> Bool{
        
        var result = false
        
        let index = Tables.index(where: {$0.Id == table.Id})
        
        if index != nil {
            if QueryContext.Instance.Delete(object: table){
                _ = self.RemoveTableAtIndex(index: index!)
            }
            result = true
        }
        
        return result
    }
    
    func RemoveMenuItem(menuItem:MenuItem) -> Bool{
        
        var result = false
        
        let index = MenuItems.index(where: {$0.Id == menuItem.Id})
        
        if index != nil {
            if QueryContext.Instance.Delete(object: menuItem){
                _ = self.RemoveMenuItemAtIndex(index: index!)
            }
            result = true
        }
        
        return result
    }
    
    func RemoveOrder(order:Order) -> Bool{
        
        var result = false
        
        let index = Orders.index(where: {$0.Id == order.Id})
        
        if index != nil {
            if QueryContext.Instance.Delete(object: order){
                _ = self.RemoveOrderAtIndex(index: index!)
            }
            result = true
        }
        
        return result
    }
    
    func RemoveOrderDetail(orderDetail:OrderDetail) -> Bool{
        
        var result = false
        
        let index = OrderDetails.index(where: {$0.OrderId == orderDetail.OrderId && $0.SequenceNumber == orderDetail.SequenceNumber})
        
        if index != nil {
            if QueryContext.Instance.Delete(object: orderDetail){
                _ = self.RemoveOrderDetailAtIndex(index: index!)
            }
            result = true
        }
        
        return result
    }
}
