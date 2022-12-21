//
//  SearchBarView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isSearching = false
    
    private var searchText: Binding<String> {
        return Binding<String>(
            get: {
                self.text
            }, set: {
                self.text = $0
            } )
    }
    
    var body: some View {
        HStack {
            TextField("Search", text: searchText)
                .font(.system(.body, design: .rounded))
                .padding(16)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .accentColor(Color.theme)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        if isSearching {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                }
                .onTapGesture {
                    withAnimation {
                        self.isSearching = true
                    }
                }
            if isSearching {
                Button(action: {
                    withAnimation {
                        self.isSearching = false
                        self.text = ""
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                }) {
                    Text("Cancel")
                        .foregroundColor(Color.theme)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
            
        }
        .padding(16)
    }
}
