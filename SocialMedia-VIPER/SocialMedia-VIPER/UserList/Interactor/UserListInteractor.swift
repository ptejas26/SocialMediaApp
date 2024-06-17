//
//  UserListInteractor.swift
//  SocialMedia-VIPER
//
//  Created by Tejas Patelia on 2024-06-12.
//

import Foundation

class UserListInteractor: PresenterToInteractor {
    var presenter: InteractorToPresenter?
    private let serviceManager: ServiceManager = .sharedInstance

    func callUserListAPI(for page: Int) {
        // API Manager
        serviceManager.getMethod(url: .listUser, model: [UserModel].self) { [weak self] result in

            guard let self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let userModel):
                    self.presenter?.returnUserList(result: .success(userModel))
                case .failure(let error):
                    self.presenter?.returnUserList(result: .failure(error))
                    print(error.localizedDescription)
                }
            }
        }
    }
}
