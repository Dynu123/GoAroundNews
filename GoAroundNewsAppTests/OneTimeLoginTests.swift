//
//  OneTimeLoginTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 10/12/22.
//

import XCTest
@testable import GoAroundNewsApp

final class OneTimeLoginTests: XCTestCase {
    
    func test_userLogin_first_launch() {
        XCTAssertNil(LocalStorage.user)
    }
    
    func test_user_already_loggedInOnce_onRelaunch() {
        XCTAssertNotNil(LocalStorage.user)
    }
}
