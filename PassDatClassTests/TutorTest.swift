//
//  TutorTest.swift
//  PassDatClassTests
//
//  Created by Jose Carlos Torres Quiles on 3/16/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

/* Implemented by Jose Carlos & Jordan Mussman */

import XCTest
@testable import PassDatClass

class TutorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Tutor.tablename = "tutorBool"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

/* SignIn() test */
    func testSignIn() {
        let result = Tutor.SignIn(FSUEmail: "tall2@outlook.com", Password: "carlos13")
        XCTAssert(result.status)
        let result2 = SQLInteract.ExecuteModification(query: "DELETE FROM User WHERE FSUEmail='tall2@outlook.com'")
        XCTAssert(result2.status)
    }
  
/* Hardcoded get function from db test */
    func testQueryByEmail() {
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        XCTAssert(tutor != nil)
    }
 
/* Hardcoded remove photo from db test */
    func testRemovePhoto() {
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        let result = Tutor.RemovePhoto(tutor: tutor!)
        XCTAssert(result.status)
    }

/* Hardcoded modification of a photo from db test */
    func testModifyPhoto() {
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        tutor?.photo = #imageLiteral(resourceName: "images.jpg")
        let result = Tutor.ChangePhoto(tutor: tutor!)
        XCTAssert(result.status)
    }
    
    func testRequestPhoto() {
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        let photo = SQLInteract.donwloadPhoto(email: tutor!.email)
        XCTAssert(photo != #imageLiteral(resourceName: "images.jpg"))
    }
 
/* Hardcoded modification of an account from db test */
    func testModifyProfile(){
        let tutor = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        tutor?.firstname = "This is Modified"
        let result = Tutor.EditAccount(tutor: tutor!)
        XCTAssert(result.status)
    }

/* Hardcoded specific get from db test */
    func testCastTutor() {
        let query = "SELECT * FROM Tutor WHERE FSUEmail='tallafoc@outlook.com';"
        let result = SQLInteract.ExecuteSelect(query: query)
        let _ = Tutor.ParseResult(result.0.first!)
    }
    
/* Hardcoded login from db test */
    func testLogIn() {
        let result = Tutor.LogIn(email: "tallafoc@outlook.com", password: "carlos13")
        XCTAssert(result.status)
    }
    
    /* Check added course */
    func testAddCourse(){
        var query = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        query?.AddCourse(course: "BLA1234")
        XCTAssert(query?.bio.range(of: "BLA1234") != nil)
    }
    
    /* Chack remove course */
    func testRemoveCourse(){
        var query = Tutor.QueryAccount(email: "tallafoc@outlook.com")
        query?.RemoveCourse(course: "CCC1111")
        XCTAssert(query?.bio.range(of: "CCC1111") == nil)
        query?.RemoveCourse(course: "ABC1234")
        
    }
    
/* Apple's measure function to time the execution */
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
