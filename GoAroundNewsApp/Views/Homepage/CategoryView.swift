//
//  CategoryView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import SwiftUI

struct CategoryView: View {
    @State var selectedIndex = 0
    @Binding var selectedCategory: NewsCategory
    
    var body: some View {
        ScrollViewReader { scrollproxy in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack(spacing: 16) {
                        ForEach(NewsCategory.allCases.indices, id: \.self) { index in
                            VStack(spacing: 0) {
                                Text(NewsCategory.allCases[index].rawValue.capitalizeFirstLetter)
                                    .font(.system(.title3, design: .rounded, weight: .semibold))
                                    .foregroundColor(selectedIndex == index ? .theme : .secondary)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedIndex = index
                                            selectedCategory = NewsCategory.allCases[index]
                                            scrollproxy.scrollTo(index, anchor: .center)
                                        }
                                    }
                                    .id(index)
                                Rectangle()
                                    .fill(selectedIndex == index ? Color.theme.opacity(0.5) : .white)
                                    .frame(maxWidth: .infinity, maxHeight: 2)
                                    .padding(5)
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        
    }
}
