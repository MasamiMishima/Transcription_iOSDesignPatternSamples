//
//  Value.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/12/01.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation

struct Value<Base> {
    let base: Base
}

protocol ValueCompatible {
    var value: Value<Self> { get }
}

extension ValueCompatible {
    var value: Value<Self> {
        return Value(base: self)
    }
}
