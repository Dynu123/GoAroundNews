//
//  LoginViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import Foundation
import Combine
import Alamofire


class LoginViewModel: ObservableObject {
    @Published var credential: Credential
    @Published var isLoading: Bool = false
    private var networkService: NetworkServiceProtocol
    private var bag: [AnyCancellable] = []
    
    init(networkService: NetworkServiceProtocol, credential: Credential) {
        self.networkService = networkService
        self.credential = credential
    }
    
    var loginDisabled: Bool {
        return credential.password.isEmpty || credential.email.isEmpty || !credential.isValid
    }
    
    func login(completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.login(credential: credential)) { [weak self] (result: Result<User, ServiceError>) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let user):
                LocalStorage.user = user
                completion() // for test case
            case .failure:
                LocalStorage.user = nil
                completion()// for test case
            }
        }.store(in: &bag)
    }
}
