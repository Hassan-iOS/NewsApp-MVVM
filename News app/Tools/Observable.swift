//
//  Observable.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet{
            listener?(value)
        }
    }
    init(_ value: T){
        self.value = value
    }
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
