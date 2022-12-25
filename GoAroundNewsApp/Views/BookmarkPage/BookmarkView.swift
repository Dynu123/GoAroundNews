//
//  BookmarkView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Bookmarks")
        }
        
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
