//
//  ComparisonShopperTests.swift
//  ComparisonShopperTests
//
//  Created by Alberto Talaván on 6/15/20.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import XCTest
@testable import ComparisonShopper

class ComparisonShopperTests: XCTestCase {
   
   var house: House?

    func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
   
   func testHouseInstantiated() {
      house = House()

      XCTAssert(house != nil, "Instantiation failed")
   }
   
   func testHouseNoNilValues() {
      house = House()
      
      house?.address = "3898 Melody Ln, Santa Clara CA"
      house?.price = "$12,000"
      house?.bedrooms = "3 bedrooms"
      
      XCTAssert(house?.address != nil , "house.address is nil")
      XCTAssert(house?.price != nil , "house.price is nil")
      XCTAssert(house?.bedrooms != nil , "house.bedrooms is nil")

   }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
