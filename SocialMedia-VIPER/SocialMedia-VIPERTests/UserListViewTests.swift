//
//  UserListViewTests.swift
//  SocialMedia-VIPERTests
//
//  Created by Tejas Patelia on 2024-06-15.
//

import Foundation
import XCTest
@testable import SocialMedia_VIPER

class MockYourPresenter: ViewToPresenter {
    var total: Int?
    
    var pageLimit: Int?
    
    var page: Int?
    
    var view: SocialMedia_VIPER.PresenterToView?
    
    var interactor: SocialMedia_VIPER.PresenterToInteractor?
    
    var router: SocialMedia_VIPER.PresenterToRouter?
    
    func getUserList(for page: Int) {

    }
    
    func navigateToDetailScreen(for user: SocialMedia_VIPER.UserModel) {

    }
}

class UserListViewTests: XCTestCase {

    func testViewWithMockPresenter() {
        let view = UserListViewController()
        let expectations = expectation(description: "model has 10 objects")
        waitForExpectations(timeout: 5)
        let mockPresenter = MockYourPresenter()
        view.presenter = mockPresenter
        let expectedModel = UserModel(
            address: Addres(city: "Nagpur",geo: Geo(lat: "123.00", lng: "-145.3")))


        view.userList(result: .success([expectedModel]))
        XCTAssertEqual(view.model.count, 10)
        expectations.fulfill()
        // Verify that the View correctly formatted and displayed the data
        XCTAssertNotNil(view.tableView)
    }
}
