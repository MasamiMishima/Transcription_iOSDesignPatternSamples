//
//  ApiSession.extension.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/19.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import GithubKit

extension ApiSession {
    static let shared: ApiSession = {
        let token: String = ""
        
        return ApiSession(injectToken: {InjectableToken.init(token: token)})
    }()
}
