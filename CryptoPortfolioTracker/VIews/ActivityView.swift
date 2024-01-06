//
//  ActivityView.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/2/24.
//

import SwiftUI


struct ActivityView: View {
    var activities: [ActivitiesResponse]
    
    var body: some View {
        VStack {
            ForEach(activities, id: \.id) { activity in
                
//                if let timeStamp = TimeInterval(activity.timeStamp) {
//                    Text(timeStampToDate(from: timeStamp))
//                } else {
//                    Text("Failed to convert timeStamp")
//                }
                
//                let timeStamp = TimeInterval(activity.timeStamp)
                
             
                
                if (activity.type == "Receive") {
                    ActivityReceiveCell(activity: activity)
                } else if (activity.type == "Send") {
                    ActivitySendCell()
                } else if (activity.type == "Swap") {
                    ActivitySwapCell()
                } else if (activity.type == "Approve") {
                    ActivityApproveCell()
                }
                
                
            }
            
        }
        
    }
    
    
    func timeStampToDate(from timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.string(from: date)
        print(formattedDate)
        return formattedDate
    }
}

//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
