//
//  ParameterEncoding.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

protocol ParameterEncoder {
    static func encode(urlReuest:inout URLRequest, with parameters:Parameters) throws
}

public enum NetworkErrors:String,Error
{
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
