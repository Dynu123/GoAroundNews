//
//  FormFieldView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

import SwiftUI

struct FormField: View {
    var fieldName = ""
    var isSecure = false
    @Binding var fieldValue: String
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(.headline, design: .rounded))
                    //.padding(.horizontal)
                    .accentColor(Color.theme)
            } else {
                TextField(fieldName, text: $fieldValue)
                    .font(.system(.headline, design: .rounded))
                    //.padding(.horizontal)
                    .accentColor(Color.theme)
            }
            Divider()
                .frame(height: 1)
                .background(Color.theme.opacity(0.5))
                //.padding(.horizontal)
        } }
}
