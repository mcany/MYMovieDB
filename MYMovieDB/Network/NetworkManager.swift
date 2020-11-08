//
//  NetworkManager.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

final class NetworkManager: NSObject {

    private enum Config {

        static let baseURL = "https://api.themoviedb.org/3/"
        static let apiKey = "9a1fba3cdaf882b8d7ef7bd2a998485d"
        static let imageURL = "https://image.tmdb.org/t/p/"
    }

    private enum ErrorConstant {

        static let httpErrorDomain = "HTTP response error"
        static let httpErrorStatusCodeTitle = "HTTP Status Code"
    }

    static let shared = NetworkManager()

    /// URL session
    private lazy var urlSession: URLSession = {
        let urlSession = URLSession(configuration: .default,
                                    delegate: self,
                                    delegateQueue: nil)
        return urlSession
    }()

    @discardableResult
    func send(request: Request,
              completion: @escaping NetworkCompletion) -> URLSessionTask {

        guard var url = URL(string: Config.baseURL) else {
            fatalError("Base url is not valid!")
        }

        if let urlWithEndpoint = URL(string: request.endpoint, relativeTo: url) {
            url = urlWithEndpoint
        }

        let parameters = [QueryParameter.apiKey: Config.apiKey]
        let queryParameters = parameters.merging(
            request.queryParameters ?? [:]) { (current, _) in current }

        let request = URLRequest(with: url,
                                 method: request.method,
                                 queryParameters: queryParameters,
                                 bodyParameters: request.bodyParameters,
                                 headers: nil)

        return process(request, completion: completion)
    }

    func send(imageRequest request: ImageRequest,
              completion: @escaping NetworkCompletion) -> URLSessionTask? {

        guard var url = URL(string: Config.imageURL) else {
            fatalError("Base url is not valid!")
        }

        if let urlWithEndpoint = URL(string: request.endpoint, relativeTo: url) {
            url = urlWithEndpoint
        }

        let request = URLRequest(with: url,
                                 method: request.method,
                                 queryParameters: nil,
                                 bodyParameters: request.bodyParameters,
                                 headers: nil)

        return process(request, completion: completion)
    }

    private func process(_ request: URLRequest, completion: @escaping NetworkCompletion) -> URLSessionTask {

        let task = urlSession.dataTask(with: request) { data, response, sessionError in

            var error = sessionError
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                    let description = "\(ErrorConstant.httpErrorStatusCodeTitle) : \(httpResponse.statusCode)"
                    error = NSError(domain: ErrorConstant.httpErrorDomain,
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: description])
                }
            }

            let httpURLResponse = response as? HTTPURLResponse
            let wrappedResponse = Response(data: data,
                                           statusCode: httpURLResponse?.statusCode,
                                           allHeaderFields: httpURLResponse?.allHeaderFields,
                                           error: error)

            DispatchQueue.main.async {
                completion(wrappedResponse)
            }
        }

        task.resume()

        return task
    }
}

// MARK: - URLSessionDelegate

extension NetworkManager: URLSessionDelegate { }
