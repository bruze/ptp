//
//  Global.swift
//
//  Created by Bruno Garelli
//  Copyright © 2016 ZG-Ep. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

typealias DicStrAny = [String: AnyObject]
typealias DicStrStr = [String: String]
typealias BloqueVoid = () -> ()

let manager = Manager.sharedManager
let usuario = manager.currentUser
let notifiCenter = NotificationCenter.default
let FirebaseUrl = "https://tuserenata-dd913.firebaseio.com/"
let FirebaseRef = FIRDatabase.database().reference()
let bundle = Bundle.init()
let fileMan = FileManager.default

infix operator ~>
private let queue = DispatchQueue(label: "serial-worker", attributes: [])
//MARK: Global Operators
func ~> <R> (
    backgroundClosure: @escaping () -> R,
    mainClosure:       @escaping (_ result: R) -> ()) {

    queue.async {
        let result = backgroundClosure()
        DispatchQueue.main.async(execute: {
            mainClosure(result)
        })
    }
}
let emptyLayer = CALayer.init()
public struct Global {
    enum RLMove {
        case right
        case left
    }
    static public func stringToInt(_ value: String) -> Int? {
        if let num = NumberFormatter().number(from: value) {
            return num.intValue
        } else {
            return nil
        }
    }

    //MARK: Global Functions

    static func initColor(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
                                                                                -> UIColor {
        let color = UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        return color
    }

    static func distinct<T: Equatable>(_ source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }

    static func imageWithView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) { UnsafeRawPointer($0).load(as: T.self) }
            //let increment = i+1
            defer {
                i += 1
            }
            return next.hashValue == i ? next : nil
        }
    }

    static func kFormatter(_ num: Int) -> String {
        if num > 999 {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.roundingMode = .down
            return formatter.string(for: Double(num)/1000)! + "K"
        }
        return "\(num)"

    }
}


