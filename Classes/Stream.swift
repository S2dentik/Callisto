//
//  Stream.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation
import RxSwift

public struct Stream {
    public let url: URL
    public let programID: Int
    public let bandwidth: Int
    public let resolution: CGSize
    public let frameRate: Double

    public init(url: URL, programID: Int, bandwidth: Int, resolution: CGSize, frameRate: Double) {
        self.url = url
        self.programID = programID
        self.bandwidth = bandwidth
        self.resolution = resolution
        self.frameRate = frameRate
    }

    @discardableResult
    public func fetchKey() -> Observable<Data> {
        let url = self.url
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                    return
                }
                guard let data = data, let key = StreamInfo(data: data)?.key else { return }
                let keyTask = URLSession.shared.dataTask(with: key.url) { data, _, error in
                    defer { observer.onCompleted() }
                    if let error = error { return observer.onError(error) }
                    guard let key = data else { return }
                    observer.onNext(key)
                }
                keyTask.resume()
            }
            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
}

extension Stream {
    static func build(id: Int, bandwidth: Int, resolution: CGSize, frameRate: Double) -> (URL) -> Stream {
        return { Stream(url: $0, programID: id, bandwidth: bandwidth, resolution: resolution, frameRate: frameRate) }
    }
}
