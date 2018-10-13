//
//  Responsible.swift
//  Needletail
//
//  Created by Ethan Kreloff on 10/12/18.
//

import Foundation

public protocol Responsible: Decodable {
    static var path: String { get }
    
    static func toURLRequest(from baseURL: URL, using data: RequestData?) -> URLRequest?
}

extension Responsible {
    static func toURLRequest(from baseURL: URL, using data: RequestData?) -> URLRequest? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.path = data?.dynamicPathOverride ?? path
        components.queryItems = data?.queryItems
        
        if let url = components.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
