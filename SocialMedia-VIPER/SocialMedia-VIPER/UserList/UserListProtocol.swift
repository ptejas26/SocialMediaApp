//
//  UserListProtocol.swift
//  SocialMedia-VIPER
//
//  Created by Tejas Patelia on 2024-06-12.
//

import Foundation


protocol ViewToPresenter: AnyObject {
    var total: Int? { set get }
    var pageLimit: Int? { set get }
    var page: Int? { set get }
    var view: PresenterToView? { set get }
    var interactor: PresenterToInteractor? { set get }
    var router: PresenterToRouter? { set  get }
    func getUserList(for page: Int)
    func navigateToDetailScreen(for user: UserModel)
}

protocol PresenterToView: AnyObject {
    func userList(result: Result<[UserModel], Error>)
}

protocol PresenterToRouter: AnyObject {
    func navigateToDetailScreen(for user: UserModel)
}

protocol PresenterToInteractor: AnyObject {
    var presenter: InteractorToPresenter? { set get }
    func callUserListAPI(for page: Int)
}

protocol InteractorToPresenter: AnyObject {
    func returnUserList(result: Result<[UserModel], Error>)
}
