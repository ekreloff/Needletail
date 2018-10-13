//
//  Foundation Extensions.swift
//  Needletail
//
//  Created by Ethan Kreloff on 8/18/18.
//

import Foundation

extension TimeInterval {
    public var minutes: TimeInterval {
        return self*60.0
    }
    
    public var hours: TimeInterval {
        return minutes*60.0
    }
    
    
    public var days: TimeInterval {
        return hours*24.0
    }
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(string: value)!
    }
}
