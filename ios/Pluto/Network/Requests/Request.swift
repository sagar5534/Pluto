//
//  Request.swift
//  MemoriaPrism
//
//  Created by Sagar R Patel on 2023-05-25.
//

import Foundation

/// This is the Request protocol you may implement as enum
/// or as a classic class object for each kind of request.
public protocol Request {
    /// Relative path of the endpoint we want to call (ie. `/users/login`)
    var path: String { get }

    /// This define the HTTP method we should use to perform the call
    /// We have defined it inside an String based enum called `HTTPMethod`
    /// just for clarity
    var method: HTTPMethod { get }

    /// These are the parameters we need to send along with the call.
    /// Params can be passed into the body or along with the URL
    var bodyParam: [String: Any]? { get }
    var urlParam: [String: String]? { get }

    /// You may also define a list of headers to pass along with each request.
    var headers: [String: Any]? { get }
}

/// This define the type of HTTP method used to perform the request
///
/// - post: POST method
/// - put: PUT method
/// - get: GET method
/// - delete: DELETE method
/// - patch: PATCH method
public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}
