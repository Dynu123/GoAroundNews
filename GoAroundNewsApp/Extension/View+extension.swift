//
//  View+extension.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 29/12/22.
//

import SwiftUI

extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        DispatchQueue.main.async {
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
                .keyWindow?
                .rootViewController?
                .present(activityVC, animated: true)
        }
    }
}
