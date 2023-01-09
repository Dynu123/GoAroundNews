//
//  ChangePasswordView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 24/12/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @Environment(\.presentationMode) var presentation
    
    var changePasswordButtonColor: Color {
        profileVM.changePasswordDisabled ? Color.accentColor.opacity(0.5) : Color.accentColor
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                FormField(fieldName: "Current password", isSecure: true, fieldValue: $profileVM.currentPassword)
                FormField(fieldName: "New password", isSecure: true, fieldValue: $profileVM.newPassword)
                FormField(fieldName: "Confirm password", isSecure: true, fieldValue: $profileVM.confirmPassword)
                SolidButton(title: "Submit", bgColor: changePasswordButtonColor) {
                    profileVM.changePassword {}
                }.disabled(profileVM.changePasswordDisabled)
            }
            .padding(16)
            if profileVM.isLoading {
                LoaderView()
            }
        }
        .alert(isPresented: $profileVM.presentAlert) {
            Alert(title: Text(profileVM.showMessage), message: Text(""), dismissButton: .cancel(Text("OK"), action: {
                //presentation.wrappedValue.dismiss()
            }))
        }
    }
}

