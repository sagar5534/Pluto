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

struct AccountDto: Codable, Identifiable {
    let name, type: String
    let isActive: Bool
    let id: Int
}

typealias AccountsDto = [AccountDto]

struct CreateAccountDto: Codable {
    let name, type: String?
    let isActive: Bool?
}
