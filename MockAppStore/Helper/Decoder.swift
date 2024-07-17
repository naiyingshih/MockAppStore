//
//  Decoder.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import Foundation

class Decoder {
    static let shared = Decoder()
        
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    }

}
