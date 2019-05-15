//
//  PhoneNumberManager.swift
//  iOSTeamHomework
//
//  Created by willsbor Kang on 2017/9/16.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import Foundation

class PhoneNumberManager {
    
    static let sharedInstance = PhoneNumberManager()
    static let dataChangedNotification: Notification.Name = Notification.Name("PhoneNumberManager.dataChangedNotification")
    
    private(set) var numbers: [NumberData] = [] {
        didSet {
            NotificationCenter.default.post(name: PhoneNumberManager.dataChangedNotification, object: nil)
        }
    }
    
    func add(_ number: NumberData) {
        numbers.append(number)
    }
    
    func remove(_ number: NumberData) {
        let index = numbers.firstIndex { (data) -> Bool in
            return data.code == number.code && data.number == number.number
        }
        
        if let index = index {
            numbers.remove(at: index.advanced(by: 0))
        }
    }
    
    func getCodes() -> [Int] {
        return numbers.map({ (data) -> Int in
            return data.code
            
        }).reduce([], { (result, code) -> [Int] in
            if result.contains(code) {
                return result
            }
            
            var next = result
            next.append(code)
            return next
        })
    }
    
    func getNumbers(`for` code: Int) -> [NumberData] {
        return numbers.filter({ (data) -> Bool in
            return data.code == code
        })
    }

    func checkExist(_ number: NumberData?) -> Bool {
        var exist = false

        for currentNumber in numbers {
            if currentNumber == number {
                exist = true
                break
            }
        }

        return exist
    }
    
    func load() {
        do {
            let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            let targetURL = tempDirectoryURL.appendingPathComponent("numbers.dat")
            
            let data = try Data(contentsOf: targetURL)
            if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [[String: Int]] {
                numbers = json.map({ (item) -> NumberData in
                    return NumberData(code: item["code"]!, number: item["number"]!)
                })
            }
            
        } catch let error {
            print("\(error)")
        }
    }
    
    func save() {
        let json = numbers.map { (data) -> [String: Int] in
            return ["code": data.code,
                    "number": data.number]
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions(rawValue: 0))
            
            let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            let targetURL = tempDirectoryURL.appendingPathComponent("numbers.dat")
            try data.write(to: targetURL)
        } catch let error {
            print("\(error)")
        }
    }
}
