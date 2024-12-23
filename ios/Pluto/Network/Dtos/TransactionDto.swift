//
//  AccountDto 2.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-14.
//


//
//  Account.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-13.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let account = try? JSONDecoder().decode(Account.self, from: jsonData)

import Foundation

struct TransactionDto: Codable, Identifiable, Hashable {
    let id: Int
    let amount: Double
    let date: Date
    let merchant: String
    let description: String
}

typealias TransactionsDto = [TransactionDto]

struct CreateTransactionDto: Codable {
    let amount: Double
    let date: Date
    let merchant: String
    let description: String?
    let account: Int
}
