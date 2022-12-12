//
//  LoadingAnimationView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 09/12/22.
//

import SwiftUI

import Foundation
import SwiftUI

public struct LoadingAnimationView<Content>: View where Content: View {
    
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            LazyVStack(alignment: .center) {
                ProgressView {
                    self.content()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(UIColor.systemBackground))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
