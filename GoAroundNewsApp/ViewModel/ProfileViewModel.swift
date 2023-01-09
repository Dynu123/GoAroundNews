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
    @Published var showMessage = ""
    
    @Published var isLoading: Bool = false
    private var bag: [AnyCancellable] = []
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var changePasswordDisabled: Bool {
        currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword
    }
    
    func showError(with error: ServiceError, for statusCode: Int) {
        switch statusCode {
        case 200, 400, 404:
            self.showMessage = error.localizedDescription
        default:
            self.showMessage = "Something went wrong, please try again"
        }
        
        self.presentAlert = true
    }
    
    func changePassword(completion: @escaping () -> Void) {
        isLoading = true
        let query = UpdatePasswordQuery(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
        self.networkService.execute(API.changePassword(query: query)) { [weak self] (result: Result<Bool, ServiceError>, statusCode) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success:
                self.showMessage = "Password updated successfully!"
                self.presentAlert = true
                completion() // for test case
            case .failure(let error):
                self.showError(with: error, for: statusCode ?? 0)
                completion()// for test case
            }
        }
    }
}
