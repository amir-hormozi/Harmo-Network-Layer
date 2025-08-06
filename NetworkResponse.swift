//
//  NetworkResult.swift
//  SpaceX
//
//  Created by Amir on 8/9/23.
//

import Foundation

struct HTTPResponse<T> {
    let data: T
    let response: URLResponse
}
