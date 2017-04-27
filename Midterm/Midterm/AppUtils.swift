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
}
