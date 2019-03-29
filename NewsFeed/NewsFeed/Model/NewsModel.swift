//
//  NewsModel.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

struct News:Codable {
    let id: Int
    let url: String
    let by: String
    let title: String
    let publishDate: String
    
    enum CodingKeys: String,CodingKey
    {
        case id
        case url
        case by = "byline"
        case title
        case publishDate = "published_date"
    }
}

struct NewsApiResponse : Codable {
    let numberOfResults: Int
    let news: [News]
    
    enum CodingKeys : String,CodingKey
    {
        case numberOfResults = "num_results"
        case news = "results"
    }
}

