//
//  AppDataModel.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import Foundation

struct AppDataModel: Codable, Hashable {
    let freeApplications: AppData
    let paidApplications: AppData
}

struct AppData: Codable, Hashable {
    let title: String
    let applications: [AppInfo]
}

struct AppInfo: Codable, Hashable {
    let advisories: [String]
    let appletvScreenshotUrls: [String]
    let artistId: Int
    let artistName: String
    let artistViewUrl: String
    let artworkUrl100: String
    let artworkUrl512: String
    let artworkUrl60: String
    let averageUserRating: Double
    let averageUserRatingForCurrentVersion: Double
    let bundleId: String
    let contentAdvisoryRating: String
    let currency: String
    let currentVersionReleaseDate: String
    let description: String
    let features: [String]
    let fileSizeBytes: String
    let formattedPrice: String
    let genreIds: [String]
    let genres: [String]
    let ipadScreenshotUrls: [String]
    let isGameCenterEnabled: Bool
    let isVppDeviceBasedLicensingEnabled: Bool
    let kind: String
    let languageCodesISO2A: [String]
    let minimumOsVersion: String
    let price: Double
    let primaryGenreId: Int
    let primaryGenreName: String
    let releaseDate: String
    let releaseNotes: String
    let screenshotUrls: [String]
    let sellerName: String
    let sellerUrl: String?
    let supportedDevices: [String]
    let trackCensoredName: String
    let trackContentRating: String
    let trackId: Int
    let trackName: String
    let trackViewUrl: String
    let userRatingCount: Int
    let userRatingCountForCurrentVersion: Int
    let version: String
    let wrapperType: String
}

