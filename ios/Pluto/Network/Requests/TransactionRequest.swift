//
//  AccountRequest 2.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-14.
//


//
//  SessionRequest.swift
//  MemoriaPrism
//
//  Created by Sagar R Patel on 2023-05-26.
//

import Foundation

enum TransactionRequest {
    case get
    case create(dto: CreateTransactionDto)
    case update
    case delete
}

extension TransactionRequest: Request {
    
    var path: String {
        return "/transaction"
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .create:
            return .post
        case .update:
            return .patch
        case .delete:
            return .delete
        }
    }

    var bodyParam: [String: Any]? {
        switch self {
        case .get:
            return .none
        case let .create(dto):
            do {
                let jsonData = try JSONEncoder().encode(dto)
                let dict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                return dict
            } catch {
                print("Error converting struct to dict: \(error)")
                return .none
            }
        case .update:
            //TODO
            return .none
        case .delete:
            //TODO
            return .none
        }
    }
    
    
    var urlParam: [String : String]? {
        switch self {
        case .get:
            return .none
        case .create:
            return .none
        case .update:
            return .none
        case .delete:
            return .none
        }
    }

    var headers: [String: Any]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
    }
        
}
