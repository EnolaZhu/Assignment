//
//  UIImage+Extension.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/24.
//

import UIKit

extension UIImage {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("無效的URL: \(urlString)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("下載圖片失敗: \(error)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("無法解析圖片數據")
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
