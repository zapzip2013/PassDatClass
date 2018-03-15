//
//  Sorting.swift
//  PassDatClassTests
//
//  Created by Jose Carlos on 2/15/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

/*Implemented by Jose Carlos */

import XCTest
import PassDatClass

class SortingTest: XCTestCase {
    
    var listTutors = [Tutor]()
    
    
    override func setUp() {
        super.setUp()
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "EEB", lastname: "EC", rating: 0.3, numbervotes: 10, photo: UIImage(named: "Random"), price: 1.1, verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "BC", lastname: "EC", rating: 0.12, numbervotes: 12, price: 2.0, verified: true, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "EA,SDAWQ", lastname: "SDAWQ", rating: 0.0, numbervotes: 13, price: 30.0, verified: true, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "FF", lastname: "DSFGG", rating: 0.42, numbervotes: 14, photo: UIImage(named: "Random"), price: 14.1, verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "QWE,DSAW", lastname: "DSAW", rating: -1.2, numbervotes: 15, price: 0.2, verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "ZXC,AQ", lastname: "AQ", rating: 2, numbervotes: 40, price: 44.1, verified: true, bio: "Random")]
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        listTutors.removeAll()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOrderAlph() {
        var ordered = Sorted.sort(by: Sorting.alph, tutors: listTutors)
        for index in 1..<ordered.count {
            XCTAssert(ordered[index].name.split(separator: ",")[1] > ordered[index-1].name.split(separator: ",")[1])
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testOrderLastNameAlph() {
        var ordered = Sorted.sort(by: Sorting.lastnamealph, tutors: listTutors)
        for index in 1..<ordered.count {
            XCTAssert(ordered[index].name > ordered[index-1].name)
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOrderInverseAlph() {
        var ordered = Sorted.sort(by: Sorting.inversealph, tutors: listTutors)
        for index in 1..<ordered.count {
            XCTAssert(ordered[index].name.split(separator: ",")[1] < ordered[index-1].name.split(separator: ",")[1])
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOrderRating() {
        var ordered = Sorted.sort(by: Sorting.rating, tutors: listTutors)
        for index in 1..<ordered.count {
            XCTAssert(ordered[index].rating > ordered[index-1].rating)
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testOrderFirstWithPhoto() {
        var ordered = Sorted.sort(by: Sorting.firstwithphoto, tutors: listTutors)
        for index in 1..<ordered.count {
            XCTAssertFalse(ordered[index].photo != nil && ordered[index].photo == nil)
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
