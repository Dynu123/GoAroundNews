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
    
    func login(completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.login(credential: credential)) { [weak self] (result: Result<User, ServiceError>) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let user):
                LocalStorage.user = user
                self.isUserLoggedIn = true
                withAnimation {
                    self.showHome = true
                }
                completion() // for test case
            case .failure:
                LocalStorage.user = nil
                self.isUserLoggedIn = false
                completion()// for test case
            }
        }.store(in: &bag)
    }
}
