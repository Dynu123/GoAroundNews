//
//  ProfileViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 24/12/22.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var presentAlert: Bool = false
    @Published var showChangePassword = false
    
    @Published var isLoading: Bool = false
    private var bag: [AnyCancellable] = []
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func changePassword(completion: @escaping () -> Void) {
        isLoading = true
        let query = UpdatePasswordQuery(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
        self.networkService.execute(API.changePassword(query: query)) { [weak self] (result: Result<Bool, ServiceError>) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success:
                self.presentAlert = true
                completion() // for test case
            case .failure:
                self.presentAlert = false
                completion()// for test case
            }
        }.store(in: &bag)
    }
}
