//===----------------------------------------------------------------------===//
//
//  HTTPURL.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/17/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HTTPURL.swift - url constuction interface
//
//===----------------------------------------------------------------------===//

import Foundation

///
///
protocol HTTPURL {
    var webURL: String {get}
    var paramList: [Param] {get}
    var headder: [String:String]? {get}
}

extension HTTPURL {
    var webURL: String {
        return webURL
    }
    var params: [String:String] {
        let paras = paramList
        let ret = paras.reduce([String:String]()) { initialvalue, item in
            var retDic: [String: String] = initialvalue
            if let dic = item.paramValue {
                for (key, value) in dic {
                    retDic.updateValue(value, forKey: key)
                }
            }
            return retDic
        }
        return ret
    }
}
