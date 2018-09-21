//
//  Canada_SpecialTests.swift
//  Canada SpecialTests
//
//  Created by L-156089550 on 18/09/18.
//  Copyright © 2018 WIPRO. All rights reserved.
//

import XCTest
import Foundation
import Alamofire
@testable import Canada_Special

class Canada_SpecialTests: XCTestCase {
    
    var rowsData:[RowsModel] = []
    let viewController = ViewController()

    override func setUp() {
        super.setUp()
         rowsData = loadRowsContent()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // Test Case 1
    func testRowSizeBeforeFilter() {
        let rowsData = loadRowsContent()
        XCTAssertNotNil(rowsData)
        XCTAssertEqual(rowsData.count, 5)
    }

    // Test Case 2
    func testRowsContentValidation() {
        // Check invalid data and remove
        let filterdeRowsData = viewController.removeInvalidContent(rawContent: rowsData)
        XCTAssertNotEqual(rowsData.count, filterdeRowsData.count)
    }
    
    // Test Case 3
    func testRowSizeAfterFilter() {
        let rowsData = loadRowsContent()
        let filterdeRowsData = viewController.removeInvalidContent(rawContent: rowsData)
        XCTAssertEqual(filterdeRowsData.count, 3)
    }
    
    // Test Case 4 : Map the json content to swift properties
    func testDataSerialization() {
        let data: Data? = sampleJsonContent().data(using: .utf8)
        let mapRowsData = APIManager.jsonSerialization(data: data!)
        
        // Validate decoded content
        XCTAssertNotNil(mapRowsData)
        
        // Validate title
        XCTAssertNotNil(mapRowsData.title)
        
         // Validate rows
        XCTAssertNotNil(mapRowsData.rows)
        
        // Validate total words counts
        XCTAssertEqual(mapRowsData.rows.count, 2)
        
        // Validate title String after decoding from JSON
        XCTAssertEqual(mapRowsData.title, "About Canada")

    }
    
    // Test Case 5 : Network Reachability
    func testNetworkReachability() {
        let isConnected = APIManager.isConnectedToInternet()
        XCTAssertEqual(isConnected, true)
    }
    
    // Test Case 6 : API call Validation
    func testAPICall() {
        let apiExpectation = expectation(description: "APICall")
        let completionHandler: (Result<InfoModel>) -> Void = {result in
            
            // Validate Result
            XCTAssertNotNil(result)
            
            // Validate Success case
            XCTAssertEqual(result.isSuccess, true)
            
            // Validate Response Value
            XCTAssertNotNil(result.value)
            
            // Validate title
            XCTAssertNotNil(result.value?.title)
            
            // Validate rows
            XCTAssertGreaterThan(result.value!.rows.count, 0)
            
            // Validate error
            XCTAssertNil(result.error)
            
            apiExpectation.fulfill()
        }

        APIManager.makeApiCall(completionHandler: completionHandler)
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func loadRowsContent() -> [RowsModel] {
        let sampleData1 = RowsModel(title: "Title 1", description: nil, imageHref: "http://test.jpg")
        let sampleData2 = RowsModel(title: nil, description: nil, imageHref: nil)
        let sampleData3 = RowsModel(title: nil, description: nil, imageHref: "http://test.jpg")
        let sampleData4 = RowsModel(title: "Title 4", description: nil, imageHref: "http://test.jpg")
        let sampleData5 = RowsModel(title: nil, description: nil, imageHref: nil)
        let rowsContent = [sampleData1, sampleData2, sampleData3, sampleData4, sampleData5]
        return rowsContent
    }
    
    func sampleJsonContent() -> String {
        return """
        {
        "title":"About Canada",
        "rows":[
        {
        "title":"Beavers",
        "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
        "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        },
        {
        "title":null,
        "description":null,
        "imageHref":null
        }]}
        """
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
