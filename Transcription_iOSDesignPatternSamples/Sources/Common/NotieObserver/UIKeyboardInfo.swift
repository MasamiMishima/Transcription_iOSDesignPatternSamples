//
//  UIKeyboardInfo.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/18.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import NoticeObserveKit

struct UIKeyboardInfo: NoticeUserInfoDecodable {
    let frame: CGRect
    let animationDuration: TimeInterval
    let animationCurve: UIView.AnimationOptions
    
    init?(info: [AnyHashable : Any]) {
        guard
            let frame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return nil
        }
        self.frame = frame
        self.animationDuration = duration
        self.animationCurve = UIView.AnimationOptions(rawValue: curve)
    }
}
