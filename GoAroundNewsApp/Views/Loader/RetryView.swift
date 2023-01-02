//
//  RetryView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 30/12/22.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Spacer()
                Text(text)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Button(action: retryAction) {
                    Text("Try again")
                }
                Spacer()
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        
    }
}
