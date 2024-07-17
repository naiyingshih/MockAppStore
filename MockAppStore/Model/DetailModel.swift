//
//  DetailModel.swift
//  MockAppStore
//
//  Created by NY on 2024/7/3.
//

import UIKit

struct DetailModel {
    let topic: String
    let content: ContentType
    let detail: ContentType
    
    enum ContentType {
        case text(String)
        case image(UIImage)
        case stackView
    }

}
