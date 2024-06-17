//
//  UserListRouter.swift
//  SocialMedia-VIPER
//
//  Created by Tejas Patelia on 2024-06-12.
//

import Foundation

class UserListRouter: PresenterToRouter {
    func navigateToDetailScreen(for user: UserModel) {

    }

    static func createUserListingVC(for viewController: UserListViewController) {
        let presenter: ViewToPresenter & InteractorToPresenter = UserListPresenter()
        let vc = viewController
        vc.presenter = presenter
        vc.presenter?.view = vc
        vc.presenter?.interactor = UserListInteractor()
        vc.presenter?.router = UserListRouter()
        vc.presenter?.interactor?.presenter = presenter
    }
}
