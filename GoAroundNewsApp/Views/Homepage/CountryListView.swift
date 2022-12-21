//
//  CountryListView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import SwiftUI

struct CountryListView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    var body: some View {
        Menu {
            ForEach(NewsCountry.allCases, id: \.self) { country in
                Button(country.name) {
                    newsVM.selectedCountry = country
                }
                .foregroundColor(.primary)
                .font(.system(.body, design: .rounded, weight: .regular))
            }
        } label: {
            HStack {
                Text("\(newsVM.selectedCountry.name)")
                    .foregroundColor(.primary)
                    .font(.system(.body, design: .rounded, weight: .regular))
                Image(systemName: "arrowtriangle.down.fill")
                    .accentColor(Color.theme)
            }
        }
    }
}
