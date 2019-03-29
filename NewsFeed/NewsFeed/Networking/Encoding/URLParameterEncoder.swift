//
//  URLParameterEncoder.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

// This class is responsible for generating a url with all parameters in url. This is handy for making GET Request.

public struct URLParameterEncoder:ParameterEncoder
{
    public static func encode(urlReuest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlReuest.url else {
            throw NetworkErrors.missingURL
        }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty
        {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters
            {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlReuest.url = urlComponents.url
        }
        if urlReuest.value(forHTTPHeaderField: "Content-Type") ==  nil
        {
            urlReuest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
