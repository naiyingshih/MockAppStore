//
//  Decoder.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import Foundation

class Decoder {
        
    func decode<T>(_ type: T.Type, from data: Data) throws -> Data where T : Decodable {
        let url = Bundle.main.url(forResource: "Applications", withExtension: "plist")!
                
        if let data = try? Data(contentsOf: url),
           let appData = try? PropertyListDecoder().decode([AppDataModel].self, from: data) {
           print(appData)
        }
        return data
    }

}
