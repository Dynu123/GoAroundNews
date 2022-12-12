//
//  SolidButton.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

import SwiftUI

struct SolidButton: View {
    var title: String
    var bgColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(bgColor)
                .cornerRadius(10)
        })
    }
}

extension String {
    static var userKey = "user"
}
