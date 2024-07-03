//
//  DetailViewModel.swift
//  MockAppStore
//
//  Created by NY on 2024/7/3.
//

import Foundation

class DetailViewModel {
    
    var appInfo: AppInfo
    var index: Int

    init(appInfo: AppInfo, index: Int) {
        self.appInfo = appInfo
        self.index = index
    }
    
    func loadData(_ result: AppInfo, index: Int) -> [DetailModel] {
        let topicArray = [
            "\(result.userRatingCount)份評分",
            "年齡",
            "排行榜",
            "開發者",
            "語言",
            "大小"
        ]
        
        let contentArray = [
            "\(((result.averageUserRating) * 10).rounded() / 10)",
            "\(result.contentAdvisoryRating)",
            "#\(index + 1)",
            "☺︎",
            "\(result.languageCodesISO2A)",
            "\(((Double(result.fileSizeBytes) ?? 0.0) * 0.00000095367432 * 10).rounded() / 10) MB"
        ]
        let detailArray = [
            "★",
            "歲",
            "\(result.primaryGenreName)",
            "\(result.artistName)",
            "English",
            "MB"
        ]
        
        var topics = [DetailModel]()
        for i in 0..<(topicArray.count) {
            let topic = DetailModel(topic: topicArray[i], content: contentArray[i] , detail: detailArray[i])
            topics.append(topic)
        }
        return topics
    }

}
