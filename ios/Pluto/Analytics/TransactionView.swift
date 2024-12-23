//
//  TransactionView.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-15.
//
import SwiftUI

struct TransactionView: View {

    let transaction: TransactionDto

    var body: some View {

        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(transaction.merchant)
                        .font(.headline)
                    Spacer()

                    Text(
                        transaction.amount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .font(.headline)
                }
                Text("Food")
                    .font(.caption)
                Text("TD Visa")
                    .font(.caption)
            }
        }
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TransactionView(transaction: TestData().transaction)
}
