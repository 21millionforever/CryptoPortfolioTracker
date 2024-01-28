//
//  Test.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/28/24.
//

import SwiftUI
import Charts

struct Test: View {
    @State private var selectedIndex: Int? = nil
    @State private var isDragging = false
    @State private var numbers = (0...10).map { _ in
        Int.random(in: 0...10)
    }
    
    var body: some View {
        Chart {
             ForEach(Array(zip(numbers, numbers.indices)), id: \.0) { number, index in
                 if let selectedIndex, selectedIndex == index {
                     RectangleMark(
                         x: .value("Index", index),
                         yStart: .value("Value", 0),
                         yEnd: .value("Value", number),
                         width: 16
                     )
                     .opacity(0.4)
                 }

                 LineMark(
                     x: .value("Index", index),
                     y: .value("Value", number)
                 )
             }
         }
        .gesture(
            DragGesture()
                .onChanged { _ in isDragging = true }
                .onEnded { _ in isDragging = false }
        )
        .chartOverlay { chart in
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let currentX = value.location.x - geometry[chart.plotAreaFrame].origin.x
                                guard currentX >= 0, currentX < chart.plotAreaSize.width else {
                                    return
                                }
                                
                                guard let index = chart.value(atX: currentX, as: Int.self) else {
                                    return
                                }
                                selectedIndex = index
                                print(index)
                            }
                            .onEnded { _ in
                                selectedIndex = nil
                            }
                    )
            }
        }
    }
        
        
        
        
        
        
    
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
