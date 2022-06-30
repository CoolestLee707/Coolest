//
//  Swift_demo.swift
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

import Foundation

class Swift_demo: NSObject,SwiftProtocol {
    
    @objc func action_someOneTest(_ params:NSDictionary) {
        if let successBlock = params["success"] {
            typealias CallbackType = @convention(block) ([String: Any]) -> Void
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(successBlock as AnyObject).toOpaque())
            let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
            callback(["someOneTest":"Let us go"])
        }
    }
    
    
    func action_someOneOCTest(_ block: (NSDictionary) -> ()) {
        block(["someOneOCTest":"Kill you!!!"])
    }
}

// 单例
class Manager {
    static let sharedInstance = Manager()
    private init() {
        // 不要忘记把构造器变成私有
    }
}
