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
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: retryAction) {
                Text("Try again")
            }
        }
        .padding(16)
    }
}
