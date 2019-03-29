//
//  NewsEndPoint.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum NewsAPI {
    case mostpopular(apiKey:String)
}

extension NewsAPI:EndPointType {
    
    var environmentBaseURL:String {
        switch NetworkManager.environment {
            case .production: return "https://api.nytimes.com/svc/"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {fatalError("base URL could not be configured.")}
        return url
    }
    
    var apiVersion: String {
        return "v2/"
    }
    
    var path: String {
        switch self {
        case .mostpopular:
            return "mostpopular/\(self.apiVersion)viewed/7.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .mostpopular(let apiKey):
            return .requestParameters(bodyParameters: nil, urlParameters: ["api-key":apiKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
