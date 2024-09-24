//
//  MainPageData.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/24.
//

import Foundation

enum AssetMediaType: String {
    case jpg = "jpg"
    case mp4 = "mp4"
}

struct MainPageAssetData: Codable {
    let code: Int?
    let data: [MainPageAssetSet]

    private enum CodingKeys: String, CodingKey {
        case code, data
    }

    static func create(_ response: [String: Any]) throws -> MainPageAssetData {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = try JSONSerialization.data(withJSONObject: response, options: [])

        return try decoder.decode(MainPageAssetData.self, from: data)
    }
}

struct MainPageAssetSet: Codable {
    let title: String
    let data: [MainPageAssetItem]

    private enum CodingKeys: String, CodingKey {
        case title, data
    }

    static func create(_ response: [String: Any]) throws -> MainPageAssetSet {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = try JSONSerialization.data(withJSONObject: response, options: [])

        return try decoder.decode(MainPageAssetSet.self, from: data)
    }
}

struct MainPageAssetItem: Codable {
    let title: String?
    let asset: String
    let type: String?
    private enum CodingKeys: String, CodingKey {
        case title, asset, type
    }

    static func create(_ response: [String: Any]) throws -> MainPageAssetItem {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = try JSONSerialization.data(withJSONObject: response, options: [])

        return try decoder.decode(MainPageAssetItem.self, from: data)
    }
}
