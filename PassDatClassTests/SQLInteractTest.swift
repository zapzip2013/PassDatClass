//
//  SQLTest.swift
//  PassDatClassTests
//
//  Created by Jose Carlos Torres Quiles on 3/6/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by Jose Carlos */

import XCTest
@testable import PassDatClass

class SQLInteractTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSelect() {
        let string = "SELECT * FROM Tutor;"
        let result = SQLInteract.ExecuteSelect(query: string)
        print (result.0[0]["FirstName"]!)        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInsertDelete(){
        let string = "INSERT INTO `Tutor` (`FSUEmail`, `Phone`, `FirstName`, `LastName`, `Rating`, `Photo`, `Bio`, `FSUVerified`, `NumberVotes`, `PricePerHour`) VALUES ('prueba', '1999999999', 'Prueba', 'Prueba2', '2.2', NULL, 'Esto es una prueba', '1', '1232', '3.3')"
        let result = SQLInteract.ExecuteModification(query: string)
        print (result)
        let string2 = "DELETE Tutor WHERE FSUEmail='prueba';"
        let result2 = SQLInteract.ExecuteModification(query: string2)
        print (result2)
    }
    
    func testInsertFailurePass(){
        let pass = SQLInteract.parameters["p"]!
        SQLInteract.parameters["p"] = "random"
        let string = "INSERT INTO `Tutor` (`FSUEmail`, `Phone`, `FirstName`, `LastName`, `Rating`, `Photo`, `Bio`, `FSUVerified`, `NumberVotes`, `PricePerHour`) VALUES ('prueba', '1999999999', 'Prueba', 'Prueba2', '2.2', NULL, 'Esto es una prueba', '1', '1232', '3.3')"
        let result = SQLInteract.ExecuteModification(query: string)
        print (result)
        SQLInteract.parameters["p"] = pass
    }
    
    func testInsertFailureHost(){
        let php = SQLInteract.phpFile
        SQLInteract.phpFile = URL(string: "anotherHost")
        let string = "INSERT INTO `Tutor` (`FSUEmail`, `Phone`, `FirstName`, `LastName`, `Rating`, `Photo`, `Bio`, `FSUVerified`, `NumberVotes`, `PricePerHour`) VALUES ('prueba', '1999999999', 'Prueba', 'Prueba2', '2.2', NULL, 'Esto es una prueba', '1', '1232', '3.3')"
        let result = SQLInteract.ExecuteModification(query: string)
        print (result)
        SQLInteract.phpFile = php
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

