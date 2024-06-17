//
//  UserListViewModel.swift
//  SocialMedia-MVVM
//
//  Created by Tejas Patelia on 2024-06-09.
//

import Foundation

protocol UserNetworkEngine {
    func getUserList(completionHandler: @escaping (Result<Void, Error>) -> Void)
}

class UserListViewModel: UserNetworkEngine {

    private(set) var model: [UserModel] = []
    private let serviceManager: ServiceManager
    var total: Int = 30
    var page: Int = 0
    var pageLimit: Int = 10

    init(model: [UserModel] = [],
         serviceManager: ServiceManager = .sharedInstance
    ) {
        self.model = model
        self.serviceManager = serviceManager
    }

    func getUserList(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        serviceManager.getMethod(url: .listUser, model: [UserModel].self) { [weak self] result in
            
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let userModel):
                    self.model.append(contentsOf: userModel)
                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
                    print(error.localizedDescription)
                }
            }
        }
    }

    func getName(for row: Int) -> String {
        guard model.indices.contains(row), let firstName = model[row].name else {
             return "NA"
        }
        return firstName
    }

    func getEmailAddress(for row: Int) -> String {
        guard model.indices.contains(row), let email = model[row].email else {
            return "NA"
        }
        return email
    }

    func getCompanyName(for row: Int) -> String {
        guard model.indices.contains(row), let companyName = model[row].company?.name else {
            return "NA"
        }
        return companyName
    }

    func getAddress(for row: Int) -> String {

        guard model.indices.contains(row), let address = model[row].address else {
            return "NA"
        }
        guard let suite = address.suite, let street = address.street, let city = address.city else {
            return "NA"
        }
        return "\(suite), \(street), \(city)"
    }
}
