//
//  StatisticView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/27/24.
//

import SwiftUI

struct StatisticView: View {
    let statistic: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.mainText)
            HStack(spacing: 4) {
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.caption)
                    .rotationEffect(Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(statistic: dev.stat1)
                .previewLayout(.sizeThatFits)
            StatisticView(statistic: dev.stat2)
                .previewLayout(.sizeThatFits)
            StatisticView(statistic: dev.stat3)
                .previewLayout(.sizeThatFits)
            
        }
       
    }
}
