//
//  LoginView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var loginVM = LoginViewModel(networkService: NetworkService(), credential: Credential())
    
    var loginButtonColor: Color {
        loginVM.loginDisabled ? Color.theme.opacity(0.5) : Color.theme
    }
    
    var body: some View {
        ZStack {
            VStack {
                FormField(fieldName: "Enter email", isSecure: false, fieldValue: $loginVM.credential.email)
                    .padding()
                FormField(fieldName: "Enter password", isSecure: true, fieldValue: $loginVM.credential.password)
                    .padding()
                SolidButton(title: "Login", bgColor: loginButtonColor, action: { loginVM.login{} })
                .disabled(loginVM.loginDisabled)
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
                Button("Create an account") {
                    
                }
                .foregroundColor(.theme)
                .bold()
                .padding(.bottom)
            }
            .autocapitalization(.none)
            .frame(maxWidth: .infinity, maxHeight: 400)
            .contentShape(Rectangle())
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .shadow(radius: 4, y: 5)
            .padding(.horizontal)
            if loginVM.isLoading {
                LoadingAnimationView {
                    Text("Loading...")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
