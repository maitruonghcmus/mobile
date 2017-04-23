//
//  MyFileManager.swift
//  BT1
//
//  Created by An Le on 4/1/17.
//  Copyright © 2017 An Le. All rights reserved.
//

import Foundation

public class MyFileManager {
    static var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    public static func CreateDir(name : String) -> String {
        let url = dir.appendingPathComponent("\(name)")
        do {
            let date = NSDate().addingTimeInterval(3600*24)
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [FileAttributeKey.creationDate.rawValue:date])
        }catch {
            print(error.localizedDescription)
        }
        return url.absoluteString
    }
    public static func CreateFile(name : String, contentData : String) -> String {
        let url = dir.appendingPathComponent("\(name)")
        if FileManager.default.fileExists(atPath: url.path) {
            print("File is existed")
        }
        else {
            let result = FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
            if result {
                print("File is created")
            }
            else {
                print("File not created")
            }
        }
        return url.absoluteString
    }
}
