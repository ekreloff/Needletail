//
//  Respondable.swift
//  Needletail
//
//  Created by Ethan Kreloff on 10/12/18.
//

import Foundation

public protocol Respondable: Decodable {
    static var path: String { get }
    
    static func toURLRequest(from baseURL: URL, using data: RequestData?, delimeters: (left: String, right: String)?) -> URLRequest?
}

public extension Respondable {
    static func toURLRequest(from baseURL: URL, using data: RequestData?, delimeters: (left: String, right: String)?) -> URLRequest? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        var componentPath = path
        
        if var templateParameters = data?.templateParameters, !templateParameters.isEmpty, let delimeters = delimeters {
            templateParameters.forEach {
                let newKey = delimeters.left + $0 + delimeters.right
                templateParameters[newKey] = $1
                templateParameters.removeValue(forKey: $0)
            }
            
            templateParameters.forEach { componentPath = componentPath.replacingOccurrences(of: $0, with: $1) }
        }
    
        components.path = componentPath
        components.queryItems = data?.queryItems
        
        if let url = components.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
