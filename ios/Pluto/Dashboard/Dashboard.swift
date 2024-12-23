//
//  Dashboard.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-12.
//

import SwiftUI

struct Dashboard: View {

    @State private var tabSelected = 0
    @ObservedObject var accountService = AccountService()

    var body: some View {

        ScrollView {

            HStack {
                VStack(alignment: .leading) {
                    Text("$24,030")
                        .font(.title)
                        .bold()
                    Text("+200 (+2%) past month")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()

            NetworthChart()
                .aspectRatio(1, contentMode: .fit)

            Picker("Date Range", selection: $tabSelected) {
                Text("1M").tag(0)
                Text("3M").tag(1)
                Text("6M").tag(2)
                Text("1Y").tag(3)
            }
            .pickerStyle(.segmented)
            .padding()

            HStack {
                Text("Accounts")
                    .font(.headline)
                    .bold()

                Spacer()
            }
            .padding()

            VStack {
                ForEach(accountService.accounts) { account in
                    NavigationLink {
                        Text("")
                            .navigationTitle("Favorites")
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(account.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(account.type)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text("$13,000")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("+2%")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                }
            }

        }
        .task {
            await accountService.fetchAccounts()
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button(
                    action: {
                        // Add Button
                    },
                    label: {
                        Label("", systemImage: "plus")
                    })
        )
    }
}

#Preview {
    NavigationView {
        Dashboard()
    }
}
