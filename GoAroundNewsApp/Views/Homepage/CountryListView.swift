//
//  CountryListView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import SwiftUI

struct CountryListView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @AppStorage("selectedCountry") private var selectedCountry = NewsCountry.Ireland
    
    var body: some View {
        Menu {
            ForEach(NewsCountry.allCases, id: \.self) { country in
                HStack { // content in the menu
                    Button(country.name) {
                        //newsVM.selectedCountry = country
                        selectedCountry = country
                    }
                    .foregroundColor(.primary)
                    .font(.system(.body, design: .rounded, weight: .regular))
                }
                .padding(.horizontal)
                
            }
        } label: { // design
            HStack {
                Text("Change the region of interest")
                    .foregroundColor(.primary)
                Spacer()
                Text("\(selectedCountry.name)")
                    .font(.system(.body, design: .rounded, weight: .regular))
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 15)
                    .tint(.primary)
                    
            }
        }
    }
}
