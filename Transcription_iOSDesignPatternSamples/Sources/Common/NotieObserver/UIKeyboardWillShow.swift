//
//  UIKeyboardWillShow.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/18.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import NoticeObserveKit

struct UIKeyboardWillShow: NoticeType {
    typealias InfoType = UIKeyboardInfo
    static let name: Notification.Name = UIResponder.keyboardWillShowNotification
}
