//
//  DictionaryExtensions.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation

extension Dictionary {
    init(tuples: [(Key, Value)]) {
        self.init()
        for (key, value) in tuples {
            self[key] = value
        }
    }
}

extension Dictionary where Key == String {
    subscript(_ param: Parameter) -> Value? {
        get {
            return self[param.rawValue]
        } set {
            self[param.rawValue] = newValue
        }
    }
}
