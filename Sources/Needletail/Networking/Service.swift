//
//  Service.swift
//  Needletail
//
//  Created by Ethan Kreloff on 9/26/18.
//

import Foundation

public protocol Service {
    static var shared: Self { get }
    
    var baseURL: URL { get }
    var delimters: (left: String, right: String) { get }
}

public extension Service {
    typealias RequestCompletion = (Data?, URLResponse?, Error?) -> Void
    
    var session: URLSession {
        return .shared
    }
    
    var sharedHeaders: [String:String] {
        return [:]
    }
    
    var delimters: (left: String, right: String) {
        return ("{", "}")
    }
    
    private func finalize(urlRequest: URLRequest, with data: RequestData?, body: Data? = nil, completion: @escaping RequestCompletion) {
        var urlRequest = urlRequest
        
        urlRequest.httpMethod = data?.method?.uppercased
        urlRequest.httpBody = body
        sharedHeaders.forEach { urlRequest.addValue($0.key, forHTTPHeaderField: $0.value) }
        data?.additionalHeaders?.forEach { urlRequest.addValue($0.key, forHTTPHeaderField: $0.value) }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func request<R: Respondable>(_ type: R.Type, with data: RequestData? = nil, completion: @escaping (_ responseObject: R?) -> Void) {
        guard let urlRequest = type.toURLRequest(from: baseURL, using: data, delimeters: delimters) else { completion(nil); return}
        
        finalize(urlRequest: urlRequest, with: data) { data, response, error in
            guard let data = data else { completion(nil); return }
            
            completion(try? JSONDecoder().decode(type, from: data))
        }
    }
    
    func request<R: Respondable, E: Encodable>(_ type: R.Type, body: E, with data: RequestData? = nil, completion: @escaping (_ responseObject: R?) -> Void) {
        guard let urlRequest = type.toURLRequest(from: baseURL, using: data, delimeters: delimters) else { completion(nil); return}
        
        finalize(urlRequest: urlRequest, with: data, body: try? JSONEncoder().encode(body)) { data, response, error in
            guard let data = data else { completion(nil); return }
            
            completion(try? JSONDecoder().decode(type, from: data))
        }
    }
    
    func request<R: Respondable>(_ type: Array<R>.Type, with data: RequestData? = nil, completion: @escaping (_ responseObject: Array<R>?) -> Void) {
        guard let urlRequest = type.ArrayLiteralElement.self.toURLRequest(from: baseURL, using: data, delimeters: delimters) else { completion(nil); return}
        
        finalize(urlRequest: urlRequest, with: data) { (data, response, error) in
            guard let data = data else { completion(nil); return }
            
            completion(try? JSONDecoder().decode(type, from: data))
        }
    }
    
    func request<R: Respondable, E: Encodable>(_ type: Array<R>.Type, body: E, with data: RequestData? = nil, completion: @escaping (_ responseObject: Array<R>?) -> Void) {
        guard let urlRequest = type.ArrayLiteralElement.self.toURLRequest(from: baseURL, using: data, delimeters: delimters) else { completion(nil); return}
        
        finalize(urlRequest: urlRequest, with: data, body: try? JSONEncoder().encode(body)) { (data, response, error) in
            guard let data = data else { completion(nil); return }
            
            completion(try? JSONDecoder().decode(type, from: data))
        }
    }
}
