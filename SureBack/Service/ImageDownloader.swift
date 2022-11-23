//
//  ImageDownloader.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import Foundation

class ImageDownloader {
    func downloadImage(url: URL, completionHandler: @escaping (Data) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url: url)) {
            DispatchQueue.main.async {
                completionHandler(response.data)
            }
        } else {
            let downloadTask = session.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            }
            downloadTask.resume()
        }
    }
}
