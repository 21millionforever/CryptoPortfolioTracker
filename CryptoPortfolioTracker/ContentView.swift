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
    @State var addresses: [String] = [Config.test_wallet,"0x868F2d27D9c5689181647a32c97578385CdDA4e6"]
    
    var currentDate: String {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: now)
        }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                TotalBalanceView()
                
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
                
                Text(currentDate)
                
                HStack() {
                    Text("Accounts")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                

                
                
                VStack {
                    ForEach(addresses, id: \.self) { address in
                        AccountCellView(address: address)
                    }
                }

                

                
                
                
            }
            .padding([.leading], 20)
            
            

            
            
        }
     
    }
}



struct Test: View {
    @State var addresses: [String] = [Config.test_wallet,"0x868F2d27D9c5689181647a32c97578385CdDA4e6"]
    
    var currentDate: String {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: now)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    TotalBalanceView()
                    
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
                    
                    Text(currentDate)
                    
                    HStack() {
                        Text("Accounts")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    

                    
                    
                    VStack {
                        ForEach(addresses, id: \.self) { address in
                            NavigationLink(destination: AccountDetailView()) {
                                AccountCellView(address: address)
                            }
                        }
                    }

                    

                    
                    
                    
                }
                .padding([.leading], 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        Test()
    }
}


