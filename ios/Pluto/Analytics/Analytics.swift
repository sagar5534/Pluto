//
//  Analytics.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-12.
//

import Algorithms
import SwiftUI

struct Analytics: View {

    @State private var tabSelected = 0
    @ObservedObject var transactionService = TransactionService()

    var chunkedFeed: [[TransactionDto]] {
        return transactionService.transactions.chunked {
            Calendar.current.isDate(
                $0.date, equalTo: $1.date, toGranularity: .day)
        }.map { Array($0) }
    }

    var body: some View {

        ScrollView {

            QuickFilters()

            ForEach(chunkedFeed, id: \.self) { datedGroup in
                Section {
                    ForEach(datedGroup) { transaction in
                        TransactionView(transaction: transaction)
                        
                        if datedGroup.count > 1 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                } header: {
                    HStack {
                        Text(
                            datedGroup.first!.date.formatted(date: .long, time: .omitted)
                        )
                        .font(.headline)
                        .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }

        }
        .task {
            await transactionService.fetchTransactions()
        }
        .navigationTitle("Analytics")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button(
                    action: {
                        // Add Button
                    },
                    label: {
                        Label("", systemImage: "line.3.horizontal.decrease")
                            .foregroundColor(.primary)
                    })
        )
    }
}

#Preview {
    NavigationView {
        Analytics()
    }
}
