//
//  FeedViewModel.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-14.
//
import Combine
import SwiftUI

class AccountService: ObservableObject {
    @Published var accounts = [AccountDto]()
    
    @MainActor
    func fetchAccounts() async {
        do {
            let response = try await NetworkManager.shared.fetch(type: AccountsDto.self, with: AccountRequest.get)
            print("Received GET Accounts Request")
            accounts = response
        } catch {
            accounts = []
        }
    }
    
    

    
}
