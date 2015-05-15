//
//  EYAPIGetCourses.h
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "EYConnectionManager.h"

@interface EYAPIGetCourses : EYConnectionManager

//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (nonatomic, strong, readonly) NSString *endPoint;


//------------------------------------------------------------------------------
// MARK: - Init
//------------------------------------------------------------------------------

- (instancetype)initWithEndPoint:(NSString *)endPoint;


//------------------------------------------------------------------------------
// MARK: - Network processor for this microservice
//------------------------------------------------------------------------------

- (void)processRequestWithParams:(NSDictionary *)params completion:(completedRequestBlock)response;

@end
