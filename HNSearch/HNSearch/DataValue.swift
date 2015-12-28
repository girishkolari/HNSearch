//===----------------------------------------------------------------------===//
//
//  DataValue.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/17/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      DataValue.swift - Parameter Data representation interface
//
//===----------------------------------------------------------------------===//

import Foundation

///
///
public protocol DataValue {
    func dataValue() -> String
}

///
///
extension String : DataValue {
    // String support protocol DataValue
    public func dataValue() -> String {
        return self
    }
}

extension Int : DataValue {
    public func dataValue() -> String {
        return String(self)
    }
}

extension Array : DataValue {
    public func dataValue() -> String {
        let ret = self.reduce("") { intitial, item in
            return intitial + "," + String(item)
        }
        return "(" + String(ret.characters.dropFirst()) + ")"
    }
}
