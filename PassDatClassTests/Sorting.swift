//
//  Sorting.swift
//  PassDatClassTests
//
//  Created by Jose Carlos on 2/15/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import XCTest
import PassDatClass

class SortingTest: XCTestCase {
    
    var listTutors = [Tutor]()
    
    
    override func setUp() {
        super.setUp()
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "EEB,AC", rating: 0.3, photo: UIImage(named: "Random"), verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "BC,EC", rating: 0.12, verified: true, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "EA,SDAWQ", rating: 0.0, verified: true, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "FF,DSFGG", rating: 0.42, photo: UIImage(named: "Random"), verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "QWE,DSAW", rating: -1.2, verified: false, bio: "Random")]
        listTutors += [Tutor(phone: 6342, email: "dsadsa", name: "ZXC,AQ", rating: 2, verified: true, bio: "Random")]
        
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
