//
//  EYConnectionManager.m
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "EYConnectionManager.h"

@interface EYConnectionManager ()

@property (nonatomic, strong, readwrite) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong, readwrite) AFSecurityPolicy *policy;

@end

@implementation EYConnectionManager

//------------------------------------------------------------------------------
// MARK: - Default initialization
//------------------------------------------------------------------------------

- (instancetype)init
{
    return [self initWithManager:[AFHTTPRequestOperationManager manager] securityPolicy:[AFSecurityPolicy defaultPolicy]];
}


//------------------------------------------------------------------------------
// MARK: - Custom initialization so we can pass any manager and policy
//------------------------------------------------------------------------------

- (instancetype)initWithManager:(AFHTTPRequestOperationManager *)manager securityPolicy:(AFSecurityPolicy *)policy
{
    self = [super init];
    if (self)
    {
        self.manager = manager;
        self.policy = policy;
    }
    return self;
}


//------------------------------------------------------------------------------
// MARK: - Helpers
//------------------------------------------------------------------------------

- (NSString *)urlRequestStringUsingEndPoint:(NSString *)endPoint
{
    return [NSString stringWithFormat:@"%@%@",kBaseURLString, endPoint];
}

- (NSArray *)convertToArray:(NSData *)object
{
    return [NSJSONSerialization JSONObjectWithData:object options:kNilOptions error:nil];
}

- (NSDictionary *)convertToDictionary:(NSData *)object
{
    return [NSJSONSerialization JSONObjectWithData:object options:kNilOptions error:nil];;
}

- (NSString *)getPathForFileNamed:(NSString *)fileName ofType:(NSString *)type bundle:(NSBundle *)bundle
{
    return [bundle pathForResource:fileName ofType:type];
}
@end
