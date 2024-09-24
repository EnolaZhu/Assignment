//
//  MainPageViewModel.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/24.
//

import Foundation
import Combine

class MainPageViewModel: ObservableObject {
    @Published var assetSets: [MainPageAssetSet] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let getDataUseCase: MainPageGetDataUseCase

    init(getDataUseCase: MainPageGetDataUseCase) {
        self.getDataUseCase = getDataUseCase
    }

    func fetchMainPageAssets() async {
        isLoading = true
        errorMessage = nil

        do {
            let data = try await getDataUseCase.execute()
            assetSets = data
        } catch {
            errorMessage = "Failed to load assets: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
