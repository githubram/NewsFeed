//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let environment : NetworkEnvironment = .production
    static let NewsAPIKey = "K9Kdgcr95PFe7tAarkVt6guMFusBmxAW"
    private let router = Router<NewsAPI>()
    
    func getPopularNews(completion:@escaping (_ news:[News]?,_ error:String?)->()) {
        
        router.request(.mostpopular(apiKey: NetworkManager.NewsAPIKey)) { (data, response, error) in
            if error != nil {
                completion(nil,"Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse{
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do{
                        let apiResponse = try JSONDecoder().decode(NewsApiResponse.self, from: responseData)
                        completion(apiResponse.news,nil)
                    }catch{
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response:HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    enum NetworkResponse:String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }


    enum Result<String> {
        case success
        case failure(String)
    }
}

