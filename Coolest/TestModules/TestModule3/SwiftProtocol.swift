//
//  SwiftProtocol.swift
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

import Foundation
@objc protocol SwiftProtocol {
    @objc func action_someOneTest(_ params:NSDictionary) -> Void;
    @objc func action_someOneOCTest(_ block:(_ result: NSDictionary)->()) ->Void;
}
