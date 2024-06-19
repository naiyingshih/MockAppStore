//
//  HomeViewModel.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import Foundation

class HomeViewModel {
    
    var appData: [AppDataModel] = []
    
    func fetchData() {
        if let url = Bundle.main.url(forResource: "Applications", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let appData: AppDataModel = try Decoder.shared.decode(AppDataModel.self, from: data)
                print(appData)
                self.appData.append(appData)
            } catch {
                print("Failed to decode plist: \(error)")
            }
        }
    }
    
}
