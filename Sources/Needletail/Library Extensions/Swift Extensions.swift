//
//  Swift Extensions.swift
//  Needletail
//
//  Created by Ethan Kreloff on 10/12/18.
//

extension UnkeyedDecodingContainer {
    mutating func decodeBucket() -> [Any] {
        var values: [Any] = []
        
        while !isAtEnd {
            if let value = try? decode(Int.self) {
                values.append(value)
            } else if let value = try? decode(Double.self) {
                values.append(value)
            } else if let value = try? decode(String.self) {
                values.append(value)
            } else if let value = try? decode(Bool.self) {
                values.append(value)
            }
        }
        
        return values
    }
}
