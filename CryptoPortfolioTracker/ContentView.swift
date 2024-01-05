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




//struct ContentView: View {
//
////    @State var addresses: [String] = [Config.test_wallet,"0x868F2d27D9c5689181647a32c97578385CdDA4e6"]
//    @State var addresses: [String] = []
//
//    @State private var showingBottomMenu = false
//
//    @State var navigateToImportWalletView = false
//
//    var currentDate: String {
//            let now = Date()
//            let formatter = DateFormatter()
//            formatter.dateStyle = .medium
//            return formatter.string(from: now)
//    }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//
//                VStack(alignment: .leading) {
//
//                    // TODO: problem: Calling balance api too many times and UI is not matching
//                    TotalBalanceView(addresses: addresses)
//                        .padding(.leading)
//
//
//                    // Uncomment to code below
//                    HStack(spacing: 3) {
//                        Image(systemName: "arrowtriangle.up.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 15, height: 15)
//                            .foregroundColor(.green)
//
//                        Text("$645.55")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//
//                        Text("(0.69%)")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//
//                        Text("Today")
//                            .font(.subheadline)
//                            .fontWeight(.light)
//
//                        Spacer()
//
//                    }
//                    .padding(.leading)
//
//
//                    Spacer().frame(height: 300)
//                    HStack {
//                        Text(currentDate)
//                        Spacer()
//                    }
//                    .padding(.leading)
//
//
//
//                    HStack() {
//                        Text("Accounts")
//                            .font(.largeTitle)
//                            .fontWeight(.semibold)
//                        Spacer()
//                    }
//                    .padding(.leading)
//
//
//
//                    ForEach(addresses, id: \.self) { address in
//                        NavigationLink(destination: AccountDetailView(address: address)) {
//                            AccountCellView(address: address)
//                                .padding(.leading)
//                        }
//                    }
//
//
//
//                }
//                .navigationTitle("Total Balance")
//
//
//
//
//
//
//            }
//            .navigationDestination(isPresented: $navigateToImportWalletView, destination: {ImportWalletView(addresses: $addresses, navigateToImportWalletView: $navigateToImportWalletView)})
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//
//                    Button(action: {
//                        showingBottomMenu = true})
//                    {
//                        Image(systemName: "plus")
//                            .foregroundColor(.green)
//                            .font(.system(size: 20, weight: .bold))
//                    }
//                    .sheet(isPresented: $showingBottomMenu) {
//                        BottomSheetView(navigateToImportWalletView: $navigateToImportWalletView, showingBottomMenu: $showingBottomMenu)
//                            .padding()
//                            .presentationDetents([.fraction(0.2)])
//                            .presentationDragIndicator(.visible)
//                    }
//                }
//            }
//
//        }
//
//    }
//}


struct ContentView: View {
    
//    @State var addresses: [String] = [Config.test_wallet,"0x868F2d27D9c5689181647a32c97578385CdDA4e6"]
    @State var addresses: [String] = []
    
    @State private var showingBottomMenu = false

    @State var showingImportWalletView = false
    
    var currentDate: String {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: now)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // TODO: problem: Calling balance api too many times and UI is not matching
                    TotalBalanceView(addresses: addresses)
                        .padding(.leading)
               

                    // Uncomment to code below
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

                        Spacer()

                    }
                    .padding(.leading)
               

                    Spacer().frame(height: 300)
                    HStack {
                        Text(currentDate)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    

                    HStack() {
                        Text("Accounts")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading)



                    ForEach(addresses, id: \.self) { address in
                        NavigationLink(destination: AccountDetailView(address: address)) {
                            AccountCellView(address: address)
                                .padding(.leading)
                        }
                    }
                    


                }
                .navigationTitle("Total Balance")
   
            }
            .navigationDestination(isPresented: $showingImportWalletView, destination: {ImportWalletView(addresses: $addresses, showingImportWalletView: $showingImportWalletView)})
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
           
                    Button(action: {
                        showingBottomMenu = true})
                    {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .sheet(isPresented: $showingBottomMenu) {
                        BottomSheetView(navigateToImportWalletView: $showingImportWalletView, showingBottomMenu: $showingBottomMenu)
                            .padding()
                            .presentationDetents([.fraction(0.2)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
        
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


