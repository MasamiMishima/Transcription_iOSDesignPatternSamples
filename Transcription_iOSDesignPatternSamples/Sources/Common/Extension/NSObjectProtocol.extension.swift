//
//  NSObjectProtocol.extension.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/20.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
