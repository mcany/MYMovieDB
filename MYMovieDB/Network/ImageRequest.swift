//
//  ImageRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

struct ImageRequest: Request {

    private enum Constant {
        static let sizePrefix = "w"
    }

    var endpoint: String

    var method: HTTPMethod = .get

    init(path: String, width: Int = 200) {
        self.endpoint = [Constant.sizePrefix, "\(width)", path].joined()
    }
}
