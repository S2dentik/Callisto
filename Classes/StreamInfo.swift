//
//  StreamInfo.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation

struct StreamInfo {
    let key: StreamKey?
}

extension StreamInfo {
    init?(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else { return nil }
        let lines = string.components(separatedBy: "\n")
        self.key = lines.lazy.flatMap {
            guard $0.starts(with: .key) else { return nil }
            let params = $0.removing(.key).parameters
            guard let method = params[.method], let url = params[.uri].flatMap(URL.init) else { return nil }
            return StreamKey(method: method, url: url)
        }.first
    }
}
