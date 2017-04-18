//
//  AppContext.swift
//  Midterm
//
//  Created by Truong Mai on 4/18/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

import Foundation

final class DataContext {
    
    static let Instance = DataContext()
    
    private init(){
        InitData()
    }
    
    //MARK: *** Data Models
    
    var Areas : [Area] = []
    var Tables : [Table] = []
    var MenuItems : [MenuItem] = []
    var Orders : [Order] = []
    var OrderDetails : [OrderDetail] = []
    
    func InitData(){
        //TODO: Load all data from databale to these objects
    }
    
    //MARK: *** Add
    
    func AddArea(area:Area) -> Bool {
        if QueryContext.Instance.Insert(object: area) {
            Areas.append(area)
            return true
        }
        return false
    }
    
    func AddTable(table:Table) -> Bool {
        if QueryContext.Instance.Insert(object: table){
            Tables.append(table)
            return true
        }
        return false
    }
    
    func AddMenuItem(item:MenuItem) -> Bool {
        if QueryContext.Instance.Insert(object: item) {
            MenuItems.append(item)
            return true
        }
        return false
    }
    
    func AddOrder(order:Order) -> Bool {
        if QueryContext.Instance.Insert(object: order) {
            Orders.append(order)
            return true
        }
        return false
    }
    
    func AddOrderDetail(orderDetail:OrderDetail) -> Bool {
        if QueryContext.Instance.Insert(object: orderDetail) {
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
    
//    
//    //Ham sap xep hoc sinh khi di chuyen 1 hs tu truoc ra sau
//    func ReArrangeHeadToTail(fromIndex: Int, toIndex: Int){
//        if fromIndex != toIndex {
//            let student = Students[fromIndex]
//            for i in fromIndex ..< toIndex {
//                Students[i] = Students[i + 1]
//            }
//            Students[toIndex] = student
//        }
//    }
//    
//    //Ham sap xep hoc sinh khi di chuyen 1 hs tu sau ra truoc
//    func ReArrangeTailToHead(fromIndex: Int, toIndex: Int){
//        if fromIndex != toIndex {
//            let student = Students[fromIndex]
//            for i in (toIndex+1...fromIndex).reversed() {
//                Students[i] = Students[i - 1]
//            }
//            Students[toIndex] = student
//        }
//    }
}
