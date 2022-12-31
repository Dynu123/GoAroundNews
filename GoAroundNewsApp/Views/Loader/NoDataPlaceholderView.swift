//
//  NoDataPlaceholderView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 30/12/22.
//

import SwiftUI

struct NoDataPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.medium)
                    .font(.system(size: 30))
            }
            Text(text)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(16)
    }
    
}
