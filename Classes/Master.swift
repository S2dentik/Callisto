//
//  Master.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation

public struct Master {
    public let streams: [Stream]
}

extension Master {
    init?(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else { return nil }
        let lines = string.components(separatedBy: "\n")
        var streams = [Stream]()
        var buildStream: ((URL) -> Stream)?
        for line in lines {
            if line.isEmpty { continue }
            guard line.hasPrefix("#EXT") else { // this should be the stream URL
                if let build = buildStream, let url = URL(string: line) {
                    streams.append(build(url))
                    buildStream = nil
                }

                continue
            }
            if line.starts(with: .m3u) {
                continue
            } else if line.starts(with: .streamInfo) {
                let params = line.removing(.streamInfo).parameters
                buildStream = Stream.build(id: params[.programID].flatMap { Int($0) } ?? 0,
                                           bandwidth: params[.bandwidth].flatMap { Int($0) } ?? 0,
                                           resolution: params[.resolution].flatMap { CGSize($0) } ?? .zero,
                                           frameRate: params[.frameRate].flatMap { Double($0) } ?? 0)
            }
        }
        self.streams = streams
    }
}
