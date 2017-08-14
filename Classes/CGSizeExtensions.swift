//
//  CGSizeExtensions.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation

extension CGSize {
    init?(_ string: String) {
        let components = string.lowercased().components(separatedBy: "x")
        guard components.count > 1, let width = Double(components[0]), let height = Double(components[1]) else { return nil }
        self.init(width: width, height: height)
    }
}
