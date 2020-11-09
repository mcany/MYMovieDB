//
//  ImageLoader.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

typealias ImageCompletion = ((UIImage?) -> Void)

final class ImageLoader {

    var imageWidth = 200 {
        didSet {
            if imageWidth > 500 {
                imageWidth = 500
            } else if imageWidth < 200 {
                imageWidth = 200
            }
        }
    }

    private var task: URLSessionTask?

    func loadImage(path: String, completion: @escaping ImageCompletion) {

        let cachePath = path + "\(imageWidth)"

        if let imageFromCache = imageCache.object(forKey: cachePath as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }

        task?.cancel()

        let request = ImageRequest(path: path, width: imageWidth)
        task = NetworkManager.shared.send(imageRequest: request) { response in
            DispatchQueue.main.async {
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

                imageCache.setObject(image, forKey: cachePath as AnyObject)
                completion(image)
            }
        }
    }
}
