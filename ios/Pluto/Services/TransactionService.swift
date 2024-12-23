//
//  AccountService 2.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-14.
//


//
//  FeedViewModel.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-14.
//
import Combine
import SwiftUI

class TransactionService: ObservableObject {
    @Published var transactions = [TransactionDto]()
    
    @MainActor
    func fetchTransactions() async {
        do {
            let response = try await NetworkManager.shared.fetch(type: TransactionsDto.self, with: TransactionRequest.get)
            print("Received GET Transactions Request")
            transactions = response
        } catch {
            transactions = []
        }
    }

    
}
