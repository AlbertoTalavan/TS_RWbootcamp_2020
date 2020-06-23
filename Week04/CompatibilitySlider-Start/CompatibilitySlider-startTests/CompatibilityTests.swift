//
//  CompatibilitySlider_StartTests.swift
//  CompatibilitySlider-StartTests
//
//  Created by Alberto Talaván on 6/21/20.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import XCTest
@testable import Compatibility

class CompatibilityTests: XCTestCase {

   let pass = "just for testing purposes "
   
   var pt: Person!               //person test
   var sut: CompatibilityGame!    //game test (System Under Test)
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      super.setUp()
      sut = CompatibilityGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      pt = nil
      sut = nil
      
      super.tearDown()
    }
   
   
//MARK: - Testing game and person objects instantiation.
   func testGameInstantiated() {
      XCTAssert(sut != nil, "CompatibilityGame was not instantiated")
   }
   
   func testPersonInstantiatedInGame() {
      XCTAssert(sut.getPerson1().id == 1, "person1 not instantiated")
      XCTAssert(sut.getPerson2().id == 2, "person2 not instantiated")
   }
   

   
//MARK: - Explanation of the tests splitting in two main groups
// NT for the following test classification:
// Now I´m trying to classify the different test looking
//   at if them test public or private methods.
//
// Most of the public methods need to use private
//   functions, so I create some extra, and just for
//   debugging, public functions to be able to access
//   those private properties/methods needed
//
   

   
//MARK: - Black box List (just exposed API)
   
   //MARK: -Testing Getters
   func testGetHowManyCompataibilityItems() {
      sut.alternativeTestingReset(pass)
      
      let compatibilityItems = sut.getHowManyCompatibilityItems()
      //compatibilityItems = ["Dogs", "Cats", "Beach", "Surf", "Mountain"]
      
      XCTAssert(compatibilityItems == 5, "Error getting how many compatibility items")
      XCTAssertFalse(compatibilityItems != 5) //this is the same test but just to try this method
   }
   
   func testGetCompatibilityItem() {
      //compatibilityItems = ["Dogs", "Cats", "Beach", "Surf", "Mountain"]
      sut.alternativeTestingReset(pass)
      
      
      //currentItemIndex = 3
      sut.setCII(pass, 3)
   
      XCTAssert(sut.getCompatibilityItem() == "Surf", "Error in getCompatibilityItem returned value")
      XCTAssertFalse(sut.getCompatibilityItem() != "Surf") //this is the same test but just to try this method

   }
   
   func testGetCurrentItemIndex () {
      sut.setCII(pass, 23)
      
      XCTAssert(sut.getCurrentItemIndex() == 23, "Error in getCurrentItemIndex returned value ")
   }
   
   
   //MARK: -Testing Setters
   func testUpdateCurrentItemIndexWhenShouldReset() {
      //giving values for the test
      sut.assignCSHC(pass)
      sut.setCII(pass, 4) //currentItemIndex = 4
      
      //we are testing the result of this method
      sut.updateCurrentItemIndex() //should reset to zero
      
      XCTAssert(sut.getCurrentItemIndex() == 0, "Error updating current item index -> should be zero")
      

      
   }
   
   func testUpdateCurrentItemIndexAddingOne() {
      //giving values for the test
      sut.assignCSHC(pass)
      sut.setCII(pass, 3) //currentItemIndex = 3
      
      //we are testing the result of this method
      sut.updateCurrentItemIndex() //should add 1
      
      XCTAssert(sut.getCurrentItemIndex() == 4, "Error updating current item index -> should be Four")
      
   }
   
   func testUpdatePerson() {
      pt = Person(id: 1, items: ["Cats": 5, "Dogs": 5])
      
      sut.updatePerson(who: pt, new: ["Programming": 9000])
      
      XCTAssert(pt.items.count == 3, "Error updating a person")
   }
   
   func testSetTopicsNumber () {
      sut.setTopicsNumber(howMany: 137)
      
      XCTAssert(sut.testTN(pass) == 137, "Error setting the number of topics")
   }
   
   func testReset() {
      sut.reset()
      
      XCTAssert(sut.getPerson1().items.count == 0, "Error: person1 was not reset()")
      XCTAssert(sut.getPerson2().items.count == 0, "Error: person1 was not reset()")
      
      //resetCurrentItemIndex() -> already tested
      //setTopicsNumber ....... -> already tested
      //resetCompatibilityItems -> already tested

      let howManyTopics = sut.testTN(pass)!
      XCTAssert(sut.getHowManyCompatibilityItems() == howManyTopics, "Error: assign compatibility items has a wrong number of items")
      
      
   }
   
   
//MARK: - White box List (testing internals)
     
   //MARK: -Testing Setters
   func testResetCurrentItemIndex() {
      sut.setCII(pass, 3)
      sut.reset()
      XCTAssert(sut.getCurrentItemIndex() == 0, "Error in reset current item index, value not equal to Zero")
   }
   
   func testResetCompatibilityItems() {
      sut.assignCSHC(pass) //assigning item to the array
      sut.resetCI(pass)        //resetCompatibilityItems
      
      XCTAssert(sut.getHowManyCompatibilityItems() == 0, "Error resetting compatibility items, result should be zero")
   }
   
   func testResetPerson() {
      pt = Person(id: 1, items: ["Cats": 5, "Dogs": 5])
      sut.sp(pass, pt) //assign pt to person1
      sut.alternativeTestingReset(pass) //inside both  alternativeTestingReset()/reset(), "resetPerson()" is called. I´m using alternativeTestingReset() just for consistency with other methods.
      
      XCTAssert(pt.items.count == 0, "")
      
   }
   
 
   
   
//MARK: - performance test Example (not used, by default test code)
/*

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 */

}


