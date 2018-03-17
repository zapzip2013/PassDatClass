//
//  TutorTest.swift
//  PassDatClassTests
//
//  Created by Jose Carlos Torres Quiles on 3/16/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

/* Implemented by Jose Carlos */

import XCTest
@testable import PassDatClass

class TutorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignIn() {
        let result = Tutor.SignIn(FSUEmail: "tall2@outlook.com", Password: "carlos13")
        XCTAssert(result.status)
        let result2 = SQLInteract.ExecuteModification(query: "DELETE FROM User WHERE FSUEmail='tall2@outlook.com'")
        XCTAssert(result2.status)
    }
    
    func testQueryByEmail() {
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        XCTAssert(tutor != nil)
    }
    
    func testRemovePhoto() {
        var tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        let result = Tutor.RemovePhoto(tutor: tutor!)
        XCTAssert(result.status)
    }
    
    func testModifyPhoto() {
        var tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        tutor?.photo = #imageLiteral(resourceName: "images.jpg")
        let result = Tutor.ChangePhoto(tutor: tutor!)
        XCTAssert(result.status)
    }
    
    func testModifyProfile(){
        var tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        tutor?.bio = "This is Modified"
        let result = Tutor.EditAccount(tutor: tutor!)
        XCTAssert(result.status)
    }
    
    func testCastTutor() {
        let query = "SELECT * FROM Tutor WHERE FSUEmail='tallafoc@outlook.com';"
        let result = SQLInteract.ExecuteSelect(query: query)
        let tutor = Tutor.ParseResult(result.0.first!)
    }
    
    func testLogIn() {
        let result = Tutor.LogIn(email: "tallafoc@outlook.com", password: "carlos13")
        XCTAssert(result.status)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
