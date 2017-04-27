//
//  AppUtils.swift
//  Midterm
//
//  Created by Truong Mai on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

public final class AppUtils {
    
    public static func DisplayAlertMessage(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    public static func GetImageData(name:String) -> Data {
        let data = NSData(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name))
        return data! as Data
    }
	public static func RandomInt() -> Int {
        var result = 0
        
        let randomNum:UInt32 = arc4random_uniform(1000) // range is 0 to 999
        result = Int(randomNum)
        
        return result
    }
    public static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let string = dateFormatter.string(from: date)
        return string
    }
    public static func formatString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let date = dateFormatter.date(from: string)
        return date!
    }
    public static func formatPrice(value: Double) -> String {
        let str = String(format: "%f", value)
        return str
    }
}
