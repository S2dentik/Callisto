//
//  Callisto.swift
//  Callisto
//
//  Created by Alexandru Culeva on 8/15/17.
//  Copyright © 2017 Ellation. All rights reserved.
//

import Foundation
import RxSwift

public final class Callisto {

    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    @discardableResult
    public func parse() -> Observable<Master> {
        let url = self.url
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                defer { observer.onCompleted() }
                if let error = error { return observer.onError(error) }
                guard let data = data, let master = Master(data: data) else { return }
                observer.onNext(master)
            }
            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
}
