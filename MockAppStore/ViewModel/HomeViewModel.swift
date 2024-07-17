//
//  HomeViewModel.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import Foundation

class HomeViewModel {
    
    var appInfo: AppDataModel?
    
    func fetchData() -> AppDataModel? {
        if let url = Bundle.main.url(forResource: "Applications", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let appData: AppDataModel = try Decoder.shared.decode(AppDataModel.self, from: data)
                appInfo = appData
                return appData
            } catch {
                print("Failed to decode plist: \(error)")
            }
        }
        return nil
    }
    
}
