//
//  SignupView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 12/12/22.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var signupVM = SignupViewModel(networkService: NetworkService(), credential: Credential())
    @Binding var showSignUp: Bool
    
    var signUpButtonColor: Color {
        signupVM.signUpDisabled ? Color.theme.opacity(0.5) : Color.theme
    }
    
    var body: some View {
        ZStack {
            VStack {
                FormField(fieldName: "Enter name", isSecure: false, fieldValue: $signupVM.credential.name)
                    .padding()
                FormField(fieldName: "Enter email", isSecure: false, fieldValue: $signupVM.credential.email)
                    .padding()
                FormField(fieldName: "Enter phone", isSecure: false, fieldValue: $signupVM.credential.phone)
                    .padding()
                FormField(fieldName: "Enter password", isSecure: true, fieldValue: $signupVM.credential.password)
                    .padding()
                FormField(fieldName: "Confirm password", isSecure: true, fieldValue: $signupVM.credential.confirmPassword)
                    .padding()
                SolidButton(title: "Sign up", bgColor: signUpButtonColor, action: { signupVM.signup{} })
                    .disabled(signupVM.signUpDisabled)
                .padding(20)
                
                VStack {
                    Divider()
                        .frame(width: 200)
                        .padding(.bottom, 8)
                    Text("OR")
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    Divider()
                        .frame(width: 200)
                        .padding(.bottom, 8)
                }
                HStack {
                    Text("Already have an account? ")
                    Button("Sign in") {
                        showSignUp = false
                    }
                    .foregroundColor(.theme)
                    .bold()
                }
            }
            .autocapitalization(.none)
            .frame(maxWidth: .infinity, maxHeight: 650)
            .contentShape(Rectangle())
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .shadow(radius: 4, y: 5)
            .padding(.horizontal)
            if signupVM.isLoading {
                LoadingAnimationView {
                    Text("Loading...")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .alert(signupVM.signupMessage, isPresented: $signupVM.presentAlert) {
            Button("OK", role: .cancel) {
                signupVM.signupMessage = ""
                showSignUp = false
            }
        }
    }
}
