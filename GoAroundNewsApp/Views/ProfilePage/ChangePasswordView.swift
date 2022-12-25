//
//  ChangePasswordView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 24/12/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @Binding var showChangePassword: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                FormField(fieldName: "Current password", isSecure: true, fieldValue: $profileVM.currentPassword)
                FormField(fieldName: "New password", isSecure: true, fieldValue: $profileVM.newPassword)
                FormField(fieldName: "Confirm password", isSecure: true, fieldValue: $profileVM.confirmPassword)
                SolidButton(title: "Submit", bgColor: .theme) {
                    profileVM.changePassword {}
                }
            }
            .padding(16)
            if profileVM.isLoading {
                LoaderView()
            }
        }
        .alert(isPresented: $profileVM.presentAlert) {
            Alert(title: Text(""), message: Text("Password updated succesfull!"), dismissButton: .cancel(Text("OK"), action: {
                showChangePassword = false
            }))
        }
    }
}

