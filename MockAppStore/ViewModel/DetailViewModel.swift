//
//  DetailViewModel.swift
//  MockAppStore
//
//  Created by NY on 2024/7/3.
//

import UIKit

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
        
        let contentArray: [DetailModel.ContentType] = [
            .text("\(((result.averageUserRating) * 10).rounded() / 10)"),
            .text("\(result.contentAdvisoryRating)"),
            .text("#\(index + 1)"),
            .image(UIImage(systemName: "person.crop.square") ?? UIImage()),
//            .text("\(result.languageCodesISO2A[0])"),
            .text("EN"),
            .text("\(((Double(result.fileSizeBytes) ?? 0.0) * 0.00000095367432 * 10).rounded() / 10) MB")
        ]
        
        let detailArray: [DetailModel.ContentType] = [
            .stackView,
            .text("歲"),
            .text("\(result.primaryGenreName)"),
            .text("\(result.artistName)"),
            .text("English"),
            .text("MB")
        ]
        
        var topics = [DetailModel]()
        for i in 0..<(topicArray.count) {
            let topic = DetailModel(topic: topicArray[i], content: contentArray[i] , detail: detailArray[i])
            topics.append(topic)
        }
        return topics
    }

}
