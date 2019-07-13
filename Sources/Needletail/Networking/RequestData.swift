//
//  RequestData.swift
//  Needletail
//
//  Created by Ethan Kreloff on 4/7/19.
//

import Foundation

public struct RequestData {
    let method: HTTPMethod?
    let additionalHeaders: [String:String]?
    let queryItems: [URLQueryItem]?
    let templateParameters: [String:String]?
    
    public init(method: HTTPMethod? = nil, additionalHeaders: [String:String]? = nil, queryItems: [URLQueryItem]? = nil, templateParameters: [String:String]? = nil) {
        self.method = method
        self.additionalHeaders = additionalHeaders
        self.queryItems = queryItems
        self.templateParameters = templateParameters
    }
}
