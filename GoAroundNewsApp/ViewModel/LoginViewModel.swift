//
//  LoginViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import Foundation
import Combine
import Alamofire
import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var showSignup: Bool = false
    @Published var showHome: Bool = false
    
    @Published var credential: Credential
    @Published var isLoading: Bool = false
    private var networkService: NetworkServiceProtocol
    private var bag: [AnyCancellable] = []
    
    @Published var isLoginAlertPresented = false
    @Published var loginErrorMessage = ""
    
    
    init(networkService: NetworkServiceProtocol, credential: Credential) {
        self.networkService = networkService
        self.credential = credential
        addDebugCredentials()
        checkLoginStatus()
    }

    func checkLoginStatus() {
        isUserLoggedIn = LocalStorage.user != nil
    }

    private func addDebugCredentials() {
        ///#if targetEnvironment(simulator)
        credential = Credential(email: "dyana@yopmail.com", password: "123456")
        //#endif
    }
    
    var loginDisabled: Bool {
        return credential.password.isEmpty || credential.email.isEmpty || !credential.isValidEmail
    }
    
    func showLoginError(with error: ServiceError, for statusCode: Int) {
        switch statusCode {
        case 200, 400:
            self.loginErrorMessage = error.localizedDescription
        case 401:
            self.loginErrorMessage = "Sorry, you are not authorized to access this app. Please sign in again to continue using this app."
        default:
            self.loginErrorMessage = "Something went wrong, please try again"
        }
        
        self.isLoginAlertPresented = true
    }
    
    func login(completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.login(credential: credential)) { [weak self] (result: Result<User, ServiceError>, statusCode)  in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let user):
                self.isLoginAlertPresented = false
                LocalStorage.user = user
                self.isUserLoggedIn = true
                withAnimation {
                    self.showHome = true
                }
                completion() // for test case
            case .failure(let error):
                LocalStorage.user = nil
                self.isUserLoggedIn = false
                self.showLoginError(with: error, for: statusCode ?? 0)
                completion()// for test case
            }
        }
    }
}
