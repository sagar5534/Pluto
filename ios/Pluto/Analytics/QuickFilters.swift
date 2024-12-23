//
//  ExtractedView.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-15.
//
import SwiftUI

struct QuickFilters: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<5) { index in
                    Button(
                        action: {
                            // Add Button
                        },
                        label: {
                            Text("Purchases")
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        })
                }
            }
            .padding()
        }
    }
}

#Preview {
    QuickFilters()
}
