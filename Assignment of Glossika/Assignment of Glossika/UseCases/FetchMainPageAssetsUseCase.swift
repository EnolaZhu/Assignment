//
//  FetchMainPageAssetsUseCase.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/24.
//

import Foundation

protocol MainPageGetDataUseCase {
    @discardableResult func execute() async throws -> [MainPageAssetSet]
}
