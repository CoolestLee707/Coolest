//
//  Service_testModule12.swift
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

import Foundation

class Service_testModule12: NSObject {

//    _ 表示函数调用时可以忽略参数名称
    @objc func aaaaa(_ str:String?) -> Void {
        print(str ?? "aaa")
    }
    func bbbbb(str:String?) -> Void {
        print(str ?? "bbb")
    }
    @objc func action_testSwiftMethod(_ parameters: [AnyHashable: Any]?) -> Dictionary<String, Any> {
        
        aaaaa("1111")
        bbbbb(str: "2222")
        
        if let params = parameters {
            let queryTypeDict = params["info"] as? NSDictionary
            print(queryTypeDict as Any)
            let sblock = params["success"]
            let fblock = params["fail"]
            typealias BlockType = @convention(block) ([String: Any]) -> Void
            let sblockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(sblock as AnyObject).toOpaque())
            let fblockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(fblock as AnyObject).toOpaque())
            let sucessBlock = unsafeBitCast(sblockPtr, to: BlockType.self)
            let failBlock = unsafeBitCast(fblockPtr, to: BlockType.self)
            
            DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    if (arc4random()%2 == 0) {
                        let result = [
                            "code" : 0,
                            "data" : "successData",
                        ] as [String : Any]
                        
                        if sblock != nil {
                            sucessBlock(result)
                        }
                    }else {
                        let result = [
                            "code" : 1,
                            "data" : "failData",
                        ] as [String : Any]
                        
                        if fblock != nil {
                            failBlock(result)
                        }
                    }
                }
            }
            
        }
        
        return ["returnKey":"Swift method action_testSwiftMethod success called"]
    }

}
