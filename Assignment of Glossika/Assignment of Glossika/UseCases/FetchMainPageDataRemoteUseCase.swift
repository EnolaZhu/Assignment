//
//  FetchMainPageDataRemoteUseCase.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/24.
//

import Foundation

class FetchMainPageDataRemoteUseCase: MainPageGetDataUseCase {

    private let urlString = "https://1ae7119d-075c-4111-94fd-f3384c43816c.mock.pstmn.io/asset"

    func execute() async throws -> [MainPageAssetSet] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let mainPageAssetData = try decoder.decode(MainPageAssetData.self, from: data)

        return mainPageAssetData.data
    }
}
