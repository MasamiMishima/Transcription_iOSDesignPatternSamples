//
//  UIKeyboardWillHide.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/18.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import NoticeObserveKit

struct UIKeyboardWillHide: NoticeType {
    typealias InfoType = UIKeyboardInfo
    static let name: Notification.Name = UIResponder.keyboardWillHideNotification
}
