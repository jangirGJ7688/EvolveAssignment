//
//  NetworkManager.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 01/12/24.
//

import Foundation

enum NetworkError: Error {
    case unexpected
    case invalidURL
    case apiError(String)
}
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(pageNumber: Int ,completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        guard let url = URL(string: Constants.APIURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.apiError(error!.localizedDescription)))
            }
            if let aData = data, let response = response{
                let cachedResponse = CachedURLResponse(response: response, data: aData)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                do {
                    let parsedData = try JSONDecoder().decode(ResponseModel.self, from: aData)
                    completion(.success(parsedData))
                } catch let error {
                    completion(.failure(NetworkError.apiError(error.localizedDescription)))
                }
            } else {
                completion(.failure(NetworkError.unexpected))
            }
        }
        .resume()
        
    }
}
