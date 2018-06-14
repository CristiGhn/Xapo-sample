//
//  RepoTests.swift
//  XapoTests
//
//  Created by Cristian Florin Ghinea on 14/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import XCTest
@testable import Xapo

class RepoTests: XCTestCase {
    
    func testURL() {
        
//        let urlString = "This is not a valid url :)"
        let urlString = ApiURLs.Trends.rawValue
        let url = URL(string: urlString)
        let assertion = UIApplication.shared.canOpenURL(url!)
        
        XCTAssertTrue(assertion, "Trends URL provided is not valid")
    }

}
