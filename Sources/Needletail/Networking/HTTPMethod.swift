//
//  HTTPMethod.swift
//  Needletail
//
//  Created by Ethan Kreloff on 4/7/19.
//

import Foundation

public enum HTTPMethod: String {
    case get, head, post, put, delete, connect, options, trace, patch
    
    var uppercased: String {
        return rawValue.uppercased()
    }
}
