//
//  SignUpViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 12/12/22.
//

import Foundation
import Combine
import Alamofire

class SignupViewModel: ObservableObject {
    @Published var signupMessage = ""
    
    @Published var credential: Credential
    @Published var isLoading: Bool = false
    @Published var presentAlert: Bool = false
    private var networkService: NetworkServiceProtocol
    private var bag: [AnyCancellable] = []
    
    init(networkService: NetworkServiceProtocol, credential: Credential) {
        self.networkService = networkService
        self.credential = credential
    }
    
    func showSignupError(with error: ServiceError, for statusCode: Int) {
        switch statusCode {
        case 200, 400, 404:
            self.signupMessage = error.localizedDescription
        default:
            self.signupMessage = "Something went wrong, please try again"
        }
        
        self.presentAlert = true
    }
    
    var signUpDisabled: Bool {
        return credential.name.isEmpty || credential.phone.isEmpty || credential.password.isEmpty || credential.email.isEmpty || !credential.isValidEmail || !credential.isValidPhone || !credential.passwordsMatch
    }
    
    func signup(completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.signup(credential: credential)) { [weak self] (result: Result<Bool, ServiceError>, statusCode) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success:
                self.presentAlert = true
                self.signupMessage = "Registration successfull! Please login using your created credentials!"
                completion() // for test case
            case .failure(let error):       
                self.showSignupError(with: error, for: statusCode ?? 0)
                completion()// for test case
            }
        }
    }
    
}
