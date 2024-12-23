//
//  Insights.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-12.
//

import SwiftUI

struct Insights: View {

    var body: some View {

        ScrollView {
            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Avg Monthly Expenses")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text("$5,243")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(12)

                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Avg Monthly Income")
                                .font(.headline)
                                .foregroundColor(.green)
                            Text("$5,243")
                                .font(.title)
                                .bold()
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(12)
                }

                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Avg Monthly Savings")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text("$5,243")
                                .font(.title)
                                .bold()
                        }

                        Spacer()
                    }
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Avg Monthly")
                                .font(.headline)
                                .foregroundColor(.brown)
                            Text("$5,243")
                                .font(.title)
                                .bold()
                        }

                        Spacer()
                    }
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                }
            }
            .padding()
        }
        .navigationTitle("Insights")
    }
}

#Preview {
    NavigationView {
        Insights()
    }
}
