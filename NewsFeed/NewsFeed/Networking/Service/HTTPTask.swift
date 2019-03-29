//
//  HTTPTask.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask
{
    case requestParameters(bodyParameters:Parameters?, urlParameters:Parameters?)
}
