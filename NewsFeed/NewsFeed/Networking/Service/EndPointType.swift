//
//  EndPointType.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL:URL {get}
    var apiVersion:String {get}
    var path:String {get}
    var httpMethod:HTTPMethod {get}
    var task:HTTPTask {get}
    var headers:HTTPHeaders? {get}
    
}
