//
//  NetworkManager.swift
//  Pluto
//
//  Created by Sagar R Patel on 2023-05-26.
//

import Foundation

enum HTTPProtocol: String, CaseIterable, Identifiable {
    case https, http
    var id: Self { self }
}

enum ApiError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet

    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}

public struct HostConfigs {
    /// Base URL of the environment
    public var host: String

    /// This is the list of common headers which will be part of each Request
    public var headers: [String: Any]? = [:]

    public init(host: String, headers: [String: Any]?) {
        self.host = host
        self.headers = headers
    }
}

protocol GenericApi {
    var environment: HostConfigs { get }
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: Request) async throws -> T
}

extension GenericApi {
    func fetch<T: Codable>(type: T.Type, with request: Request) async throws -> T {
        guard let urlRequest = try? prepareURLRequest(request: request) else {
            print(ApiError.requestFailed(description: "Bad URL Request"))
            throw ApiError.requestFailed(description: "Bad URL Request")
        }
        
        guard case let (data?, response?) = try await session.data(for: urlRequest) else {
            print(ApiError.requestFailed(description: "Invalid response"))
            throw ApiError.requestFailed(description: "Invalid response")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print(ApiError.requestFailed(description: "Invalid response"))
            throw ApiError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200 else {
            print(ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)"))
            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601withOptionalFractionalSeconds
            return try decoder.decode(type, from: data)
        } catch {
            print(ApiError.jsonConversionFailure(description: error.localizedDescription))
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }

    func fetch(with request: Request) async throws -> (Data, URLResponse) {
        guard let urlRequest = try? prepareURLRequest(request: request) else {
            throw ApiError.requestFailed(description: "Bad URL Request")
        }
        
        guard case let (data?, response?) = try await session.data(for: urlRequest) else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200 else {
            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        return (data, response)
    }

    func prepareURLRequest(request: Request) throws -> URLRequest {
        var urlComponents = URLComponents(string: environment.host)!
        urlComponents.path = request.path
        var finalURLRequest = URLRequest(url: urlComponents.url!)

        if request.bodyParam != nil {
            do {
                finalURLRequest.httpBody = try JSONSerialization.data(withJSONObject: request.bodyParam!)
            } catch {
                throw ApiError.failedSerialization
            }
        }
        
        if request.urlParam != nil {
            let queryItems = request.urlParam!.map(URLQueryItem.init)
            urlComponents.queryItems = queryItems
            finalURLRequest.url = urlComponents.url
        }
        
        environment.headers?.forEach { finalURLRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { finalURLRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }

        finalURLRequest.httpMethod = request.method.rawValue
        return finalURLRequest
    }
}

final class NetworkManager: GenericApi {
    static let shared = NetworkManager(environment: HostConfigs(host: "http://localhost:3000", headers: [:]), configuration: .default)
    var environment: HostConfigs
    let session: URLSession

    init(environment: HostConfigs, configuration: URLSessionConfiguration) {
        print("Starting NetworkManager")
        self.environment = environment
        session = URLSession(configuration: configuration)
    }

    required init(environment: HostConfigs) {
        print("Starting NetworkManager")
        self.environment = environment
        session = URLSession(configuration: .default)
    }
}
