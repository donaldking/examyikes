//
//  EYConnectionManagerTests.m
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EYConnectionManager.h"

@interface EYConnectionManagerTests : XCTestCase
{
    EYConnectionManager *mockConnectionManager;
    AFHTTPRequestOperationManager *mockOperationManager;
    AFSecurityPolicy *mockPolicy;
}
@end

@implementation EYConnectionManagerTests

//------------------------------------------------------------------------------
// MARK: - Set up
//------------------------------------------------------------------------------

- (void)setUp
{
    [super setUp];
    
    mockOperationManager = [AFHTTPRequestOperationManager manager];
    
    mockPolicy = [AFSecurityPolicy defaultPolicy];
    [mockPolicy setAllowInvalidCertificates:YES];
    
    mockConnectionManager = [[EYConnectionManager alloc] initWithManager:mockOperationManager securityPolicy:mockPolicy];
}


//------------------------------------------------------------------------------
// MARK: - Test network manager not nil
//------------------------------------------------------------------------------

- (void)testIfManagerAndSecurityPolicyIsNotNil
{
    XCTAssertNotNil(mockOperationManager, "Operation manger cannot be nil");
    XCTAssertNotNil(mockPolicy, "Security policy cannot be nil");
    XCTAssertNotNil(mockConnectionManager, "Connection manager cannot be nil");
}


//------------------------------------------------------------------------------
// MARK: - Test if url request string is correct and not nil
//------------------------------------------------------------------------------

- (void)testUrlRequestStringUsingEndPointNotNilAndCorrect
{
    NSString *endPoint = @"/test.json";
    NSString *expectedURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,endPoint];
    NSString *constructedURL = [mockConnectionManager urlRequestStringUsingEndPoint:endPoint];
    
    XCTAssertNotNil(constructedURL,@"Constructed URL cannot be nil");
    XCTAssertTrue([constructedURL isEqualToString:expectedURL], @"Constructed URL not correct");
}


//------------------------------------------------------------------------------
// MARK: - Test if convert to array returns NSArray object
//------------------------------------------------------------------------------

- (void)testConvertToArrayNotNilAndCorrect
{
    NSString *fileName = @"jsonResponseArray";
    NSArray *array = [mockConnectionManager convertToArray:[NSData dataWithContentsOfFile:[mockConnectionManager
                                                                                           getPathForFileNamed:fileName ofType:@"json" bundle:[NSBundle bundleForClass:[self class]]]]];
    
    XCTAssertNotNil(array,@"Array cannot be nil");
    XCTAssertTrue([array isKindOfClass:[NSArray class]],@"Returned object is not an NSArray");
}


//------------------------------------------------------------------------------
// MARK: - Test if convert to dictionary returns NSDictionary object
//------------------------------------------------------------------------------

- (void)testConvertToDictionaryNotNilAndCorrect
{
    NSString *fileName = @"jsonResponseObject";
    NSDictionary *dictionary = [mockConnectionManager convertToDictionary:[NSData dataWithContentsOfFile:[mockConnectionManager
                                                                                                          getPathForFileNamed:fileName ofType:@"json" bundle:[NSBundle bundleForClass:[self class]]]]];
    
    XCTAssertNotNil(dictionary,@"Dictionary cannot be nil");
    XCTAssertTrue([dictionary isKindOfClass:[NSDictionary class]],@"Returned object is not an NSArray");
}


//------------------------------------------------------------------------------
// MARK: - Clean up
//------------------------------------------------------------------------------

- (void)tearDown
{
    [super tearDown];
}

@end



