//
//  EYConnectionManager.h
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYAppDelegate.h"
#import "CoreDataHelper.h"

typedef void(^completedRequestBlock) (BOOL success, id completionResponse, NSError *error);

@interface EYConnectionManager : AFHTTPSessionManager

//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (nonatomic, strong, readonly) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong, readonly) AFSecurityPolicy *policy;


//------------------------------------------------------------------------------
// MARK: - Initialization
//------------------------------------------------------------------------------

- (instancetype)initWithManager:(AFHTTPRequestOperationManager *)manager securityPolicy:(AFSecurityPolicy *)policy;


//------------------------------------------------------------------------------
// MARK: - Helpers
//------------------------------------------------------------------------------

- (NSString *)urlRequestStringUsingEndPoint:(NSString *)endPoint;
- (NSArray *)convertToArray:(NSData *)object;
- (NSDictionary *)convertToDictionary:(NSData *)object;
- (NSString *)getPathForFileNamed:(NSString *)fileName ofType:(NSString *)type bundle:(NSBundle *)bundle;

@end
