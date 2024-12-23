//
//  NetWorthChart.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-12.
//

import SwiftUI
import Charts
import Foundation

struct PetData: Identifiable, Equatable {
    let year: Int
    let population: Double
    var id: Int { year }
    
    static var catExample: [PetData] {
        [PetData(year: 2000, population: 6.8),
         PetData(year: 2010, population: 8.2),
         PetData(year: 2015, population: 12.9),
         PetData(year: 2022, population: 15.2)]
    }
    
    static var dogExamples: [PetData] {
        [PetData(year: 2000, population: 5),
         PetData(year: 2010, population: 5.3),
         PetData(year: 2015, population: 7.9),
         PetData(year: 2022, population: 10.6)]
    }
    
}
struct NetworthChart: View {
    
    let catData = PetData.catExample
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4),
                                                                    Color.accentColor.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    var body: some View {
        Chart {
            ForEach(catData) { data in
                LineMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .symbol(by: .value("Pet type", "cat"))

            ForEach(catData) { data in
                AreaMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
        }
        .chartXScale(domain: 2000...2022)
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
    
    let numberFormatter: NumberFormatter = {
           let formatter = NumberFormatter()
            formatter.numberStyle = .none
            formatter.maximumFractionDigits = 0
            return formatter
        }()
    
    func formatte(number: Int) -> String {
            let result = NSNumber(value: number)
            return numberFormatter.string(from: result) ?? ""
        }
}

#Preview {
    NetworthChart()
}
        
