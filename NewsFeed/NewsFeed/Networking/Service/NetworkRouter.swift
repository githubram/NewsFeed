//
//  NetworkRouter.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data:Data?, _ response:URLResponse?, _ error:Error?)->()

protocol NetworkRouter:class {
    associatedtype EndPoint:EndPointType
    func request(_ route:EndPoint, completion:@escaping NetworkRouterCompletion)
    func cancel()
}
