//
//  EndPoint.swift
//  WildWander
//
//  Created by nuca on 02.07.24.
//

import Foundation

public protocol EndPoint {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var queryItems: [URLQueryItem]? { get }
    var pathParams: [String: String]? { get }
}

extension EndPoint {
    public var scheme: String { "https" }
    public var host: String { "" }
}
