//
//  Router.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

class Router<EndPoint:EndPointType>: NetworkRouter{
    
    var task:URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        }catch {
            completion(nil,nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws ->URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .requestParameters(.none, let urlParameters):
                try self.configureParameters(nil, urlParameters, request: &request)
                return request
            case .requestParameters(let bodyParameters, .none):
                try self.configureParameters(nil, bodyParameters, request: &request)
                return request
            case .requestParameters(.some(_), .some(_)):
                try self.configureParameters(nil, nil, request: &request)
                return request
            }
        }catch {
            throw error
        }
    }
    
    func configureParameters(_ bodyParameters:Parameters?, _ urlParameters:Parameters?, request:inout URLRequest) throws {
        
        do {
            if let urlParameter = urlParameters {
                try URLParameterEncoder.encode(urlReuest: &request, with: urlParameter)
            }
        }catch {
            throw error
        }
    }
}

