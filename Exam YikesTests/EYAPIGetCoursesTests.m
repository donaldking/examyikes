//
//  EYAPIGetCoursesTests.m
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EYAPIGetCourses.h"

@interface EYAPIGetCoursesTests : XCTestCase
{
    EYAPIGetCourses *apiGetCourses;
    NSString *endPoint;
}
@end

@implementation EYAPIGetCoursesTests

//------------------------------------------------------------------------------
// MARK: - Set up
//------------------------------------------------------------------------------

- (void)setUp
{
    [super setUp];
    
    endPoint = @"/test.json";
    apiGetCourses = [[EYAPIGetCourses alloc] initWithEndPoint:endPoint];
}


//------------------------------------------------------------------------------
// MARK: - Test if object is not nil
//------------------------------------------------------------------------------

- (void)testIfApiGetCoursesNotNil
{
    XCTAssertNotNil(apiGetCourses,@"I cannot not be nil. This is a major bug!");
}


//------------------------------------------------------------------------------
// MARK: - Test initialized end point is set and correct
//------------------------------------------------------------------------------

- (void)testInitWithEndPointNotNilAndCorrect
{
    NSString *expectedEndPoint = [NSString stringWithFormat:@"%@%@",kBaseURLString,endPoint];
    
    XCTAssertNotNil(apiGetCourses.endPoint,@"Constructed URL cannot be nil");
    XCTAssertTrue([apiGetCourses.endPoint isEqualToString:expectedEndPoint], @"Constructed URL not correct");
}


//------------------------------------------------------------------------------
// MARK: - Clean up
//------------------------------------------------------------------------------

- (void)tearDown
{
    [super tearDown];
}

@end
