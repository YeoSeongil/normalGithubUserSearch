//
//  EndPointType.swift
//  normalGithubUserSearch
//
//  Created by 여성일 on 2/6/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
}

enum EndPointItems {
    case initUsers
    case Users(String)
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .initUsers:
            return "search/users?q=seongil"
        case .Users(let query):
            return "search/users?q=\(query)"
        }
    }
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .initUsers:
            return .get
        case .Users:
            return .get
        }
    }
    
    
}
