//
//  UserListPresenter.swift
//  SocialMedia-VIPER
//
//  Created by Tejas Patelia on 2024-06-12.
//

import Foundation

class UserListPresenter: ViewToPresenter {
    var view: PresenterToView?
    var total: Int? = 30
    var pageLimit: Int? = 10
    var page: Int? = 0
    
    var interactor: PresenterToInteractor?
    
    var router: PresenterToRouter?
    
    func getUserList(for page: Int) {
        interactor?.callUserListAPI(for: page)
    }

    func navigateToDetailScreen(for user: UserModel) {
        router?.navigateToDetailScreen(for: user)
    }
}

extension UserListPresenter: InteractorToPresenter {
    func returnUserList(result: Result<[UserModel], Error>) {
        view?.userList(result: result)
    }
}
