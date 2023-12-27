//
//  ContentView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 12/25/23.
//
import Charts

import SwiftUI

struct MonthlyHoursOfSunshine: Identifiable {
    var id = UUID()
    var date: Date
    var hoursOfSunshine: Double


    init(month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}


var data: [MonthlyHoursOfSunshine] = [
    MonthlyHoursOfSunshine(month: 1, hoursOfSunshine: 74),
    MonthlyHoursOfSunshine(month: 2, hoursOfSunshine: 99),
    MonthlyHoursOfSunshine(month: 3, hoursOfSunshine: 70),
    MonthlyHoursOfSunshine(month: 4, hoursOfSunshine: 60),
    MonthlyHoursOfSunshine(month: 5, hoursOfSunshine: 75),
    MonthlyHoursOfSunshine(month: 6, hoursOfSunshine: 80),
    MonthlyHoursOfSunshine(month: 7, hoursOfSunshine: 95),
    MonthlyHoursOfSunshine(month: 8, hoursOfSunshine: 100),
    // ...
    MonthlyHoursOfSunshine(month: 12, hoursOfSunshine: 62)
]




struct ContentView: View {
    
    var currentDate: String {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: now)
        }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                
                HStack() {
                    Text("Total Balance")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()

                }

                HStack() {
                    Text("$93,858.07")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(currentDate)
         
                }
                
                HStack(spacing: 3) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)
                        
                    Text("$645.55")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        
                    Text("(0.69%)")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("Today")
                        .font(.subheadline)
                        .fontWeight(.light)
            
                }
                
                Spacer().frame(height: 300)
                
                HStack() {
                    Text("Accounts")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("0x868F2d27D9c5689181647a32c97578385CdDA4e6")
                            .frame(width: 100, height: 40)
                        
                        Spacer()
                        
                    }
                    
                    HStack(alignment: .top) {
                        Chart(data) {
                            LineMark(
                                x: .value("Month", $0.date),
                                y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                            )
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis(.hidden)
                        .foregroundStyle(.red)
                        .frame(width: 250, height: 70)
                        .padding([.leading],20)
                        
                        Text("$42.65")
                            .font(.title2)
                            .fontWeight(.medium)
                            .background(.green)
                            .padding([.leading], 40)
                        
                    }
                    
                    
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("0x868F2d27D9c5689181647a32c97578385CdDA4e6")
                            .frame(width: 100, height: 40)
                        
                        Spacer()
                        
                    }
                    
                    HStack(alignment: .top) {
                        Chart(data) {
                            LineMark(
                                x: .value("Month", $0.date),
                                y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                            )
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis(.hidden)
                        .foregroundStyle(.red)
                        .frame(width: 250, height: 70)
                        .padding([.leading],20)
                        
                        Text("$42.65")
                            .font(.title2)
                            .fontWeight(.medium)
                            .background(.green)
                            .padding([.leading], 40)
                        
                    }
                    
                    
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("0x868F2d27D9c5689181647a32c97578385CdDA4e6")
                            .frame(width: 100, height: 40)
                        
                        Spacer()
                        
                    }
                    
                    HStack(alignment: .top) {
                        Chart(data) {
                            LineMark(
                                x: .value("Month", $0.date),
                                y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                            )
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis(.hidden)
                        .foregroundStyle(.red)
                        .frame(width: 250, height: 70)
                        .padding([.leading],20)
                        
                        Text("$42.65")
                            .font(.title2)
                            .fontWeight(.medium)
                            .background(.green)
                            .padding([.leading], 40)
                        
                    }
                    
                    
                    HStack() {
                        Image("SVG_MetaMask_Icon_Color")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("MetaMask")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("0x868F2d27D9c5689181647a32c97578385CdDA4e6")
                            .frame(width: 100, height: 40)
                        
                        Spacer()
                        
                    }
                    
                    HStack(alignment: .top) {
                        Chart(data) {
                            LineMark(
                                x: .value("Month", $0.date),
                                y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                            )
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis(.hidden)
                        .foregroundStyle(.red)
                        .frame(width: 250, height: 70)
                        .padding([.leading],20)
                        
                        Text("$42.65")
                            .font(.title2)
                            .fontWeight(.medium)
                            .background(.green)
                            .padding([.leading], 40)
                        
                    }
              
                    
              
                    
                }
      
                
                
                
            }
            .padding([.leading], 20)
            
            

            
            

//            VStack(spacing: 20) {
//                ForEach(0..<10) {
//                    Text("Item \($0)")
//                        .foregroundStyle(.white)
//                        .font(.largeTitle)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 200)
//                        .background(.red)
//                }
//            }
            
            
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


