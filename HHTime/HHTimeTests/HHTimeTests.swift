//
//  HHTimeTests.swift
//  HHTimeTests
//
//  Created by tianxi on 2019/11/1.
//  Copyright © 2019 hh. All rights reserved.
//

/*
 
 什么时候用到单元测试：
 逻辑测试：测试逻辑方法
 异步测试：测试耗时方法（用来测试包含多线程的方法）
 性能测试：测试某一方法运行所消耗的时间
 
 测试注意：
 1、testExample和testPerformanceExample或者自己编写的测试函数，可以单独运行，也可以运行整个测试class里所有测试。
 2、可测试的方法命名固定为test开头。
 3、快捷方式：Command + U
 4、每一个test函数运行，都会执行一次setUp和tearDown
  
 单元测试的逻辑功能测试所有方法：
 XCTFail(format…) 生成一个失败的测试；
 XCTAssertNil(a1, format...)为空判断，a1为空时通过，反之不通过；
 XCTAssertNotNil(a1, format…)不为空判断，a1不为空时通过，反之不通过；
 XCTAssert(expression, format...)当expression求值为TRUE时通过；
 XCTAssertTrue(expression, format...)当expression求值为TRUE时通过；
 XCTAssertFalse(expression, format...)当expression求值为False时通过；
 XCTAssertEqualObjects(a1, a2, format...)判断相等，[a1 isEqual:a2]值为TRUE时通过，其中一个不为空时，不通过；
 XCTAssertNotEqualObjects(a1, a2, format...)判断不等，[a1 isEqual:a2]值为False时通过；
 XCTAssertEqual(a1, a2, format...)判断相等（当a1和a2是 C语言标量、结构体或联合体时使用, 判断的是变量的地址，如果地址相同则返回TRUE，否则返回NO）；
 XCTAssertNotEqual(a1, a2, format...)判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
 XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...)判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/-accuracy）以内相等时通过测试；
 XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
 XCTAssertThrows(expression, format...)异常测试，当expression发生异常时通过；反之不通过；（很变态） XCTAssertThrowsSpecific(expression, specificException, format...) 异常测试，当expression发生specificException异常时通过；反之发生其他异常或不发生异常均不通过；
 XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...)异常测试，当expression发生具体异常、具体异常名称的异常时通过测试，反之不通过；
 XCTAssertNoThrow(expression, format…)异常测试，当expression没有发生异常时通过测试；
 XCTAssertNoThrowSpecific(expression, specificException, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过；
 XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过
 
 异步功能方法测试 demo:
 func testAsyncURLConnection(){
     let URL = NSURL(string: "http://www.baidu.com")!
     let expect = expectation(description: "GET \(URL)")
     
     let session = URLSession.shared
     let task = session.dataTask(with: URL as URL, completionHandler: {(data, response, error) in
         
         XCTAssertNotNil(data, "返回数据不应该为空")
         XCTAssertNil(error, "error应该为nil")
         expect.fulfill() //请求结束通知测试
         
         if response != nil {
             let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
             
             XCTAssertEqual(httpResponse.statusCode, 200, "请求失败!")
             
             DispatchQueue.main.async {
                 //主线程中干事情
             }
             
         } else {
             XCTFail("请求失败!")
         }
     })
     
     task.resume()
     
     //请求超时
     waitForExpectations(timeout: (task.originalRequest?.timeoutInterval)!, handler: {error in
         task.cancel()
     })
 }
 */

import XCTest
//表示要测试HHTime这个模块
@testable import HHTime

class HHTimeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // 在测试之前做一些初始化、数据库装载等操作
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // 测试结束之后执行一些操作、清除掉数据
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // 书写测试用例
        
//        // 请求超时
//        waitForExpectations(timeout: 10) { (error) in
//            //超时后做一些事情
//
//        }
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        // 书写测试性能用例
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

//    func testItShouldRaiseAPassNotificationV2() {
//        expectation(forNotification: NSNotification.Name(rawValue: "evPassed"), object: nil,handler: nil)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "evPassed"),object: nil)
//    }
}
