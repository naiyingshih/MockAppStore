//
//  DateFormatter.swift
//  MockAppStore
//
//  Created by NY on 2024/7/17.
//

import Foundation

class DateFormatterManager {
    static let shared = DateFormatterManager()
    
    let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func formatReleaseDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: dateString) {
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
}
