//
//  StringExtensions.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation

extension String {

    var parameters: [String: String] {
        let tuples = components(separatedBy: ",").flatMap { parameter -> (String, String)? in
            let components = parameter.split(maxSplits: 1, omittingEmptySubsequences: true, whereSeparator: { $0 == "=" })
            if components.count < 2 { return nil }
            return (String(components[0]), String(components[1]).replacingOccurrences(of: "\"", with: ""))
        }
        return Dictionary(tuples: tuples)
    }

    func replacingFirstOccurrence(of original: String, with newString: String) -> String {
        guard let range = range(of: original) else { return self }
        return replacingCharacters(in: range, with: newString)
    }

    func starts(with tag: Ext) -> Bool {
        return hasPrefix("#\(tag.rawValue)")
    }

    func removing(_ tag: Ext) -> String {
        return replacingFirstOccurrence(of: "#\(tag.rawValue):", with: "")
    }
}
