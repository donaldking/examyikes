//
//  EYAPIGetCourses.m
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "EYAPIGetCourses.h"

@interface EYAPIGetCourses ()

@property (nonatomic, strong, readwrite) NSString *endPoint;

@end

@implementation EYAPIGetCourses

//------------------------------------------------------------------------------
// MARK: - Default init
//------------------------------------------------------------------------------

- (instancetype)init
{
    return [self initWithEndPoint:kCoursesEndPoint];
}


//------------------------------------------------------------------------------
// MARK: - Init with end point. Subclasses should provide their end point
//------------------------------------------------------------------------------

- (instancetype)initWithEndPoint:(NSString *)endPoint
{
    self = [super init];
    if (self)
    {
        self.endPoint = [self urlRequestStringUsingEndPoint:endPoint];
    }
    
    return self;
}


//------------------------------------------------------------------------------
// MARK: - Process the network request for this microservice
//------------------------------------------------------------------------------

- (void)processRequestWithParams:(NSDictionary *)params completion:(completedRequestBlock)response
{
    [self.manager GET:self.endPoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([self saveArrayResponse:[operation responseData]])
        {
            response(YES, nil, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        response(YES, nil, error);
    }];
}


//------------------------------------------------------------------------------
// MARK: - Process the network response
//------------------------------------------------------------------------------

- (BOOL)saveArrayResponse:(NSData *)jsonData
{
    /* We know the response from the API is going to be an array of objects
     so we simply call the superclass helper to parse the response data
     to NSArray so we can walk through the objects contained.
     */
    
    NSArray *responseArray = [self convertToArray:jsonData];
    __block BOOL savedSuccessfully = NO;
    
    [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%@",[obj valueForKey:@"id"]];
        NSArray *localArray = [CoreDataHelper fetchObjectsForEntityName:kQualificationsEntityName
                                                          withPredicate:predicate inManagedObjectContext:XAppDelegate.managedObjectContext
                                                          setResultType:NSManagedObjectIDResultType];
        
        /* Pull out the objects we are interested in saving! */
        
        NSDictionary *dictionary = @{@"id":[obj valueForKey:@"id"],
                                     @"name":[obj valueForKey:@"name"],
                                     @"subjects":[obj valueForKey:@"subjects"]};
        
        /* Update if this entry if we have a value in core data */
        
        if ([localArray count] > 0)
        {
            if([CoreDataHelper updateAttributeForEntityName:kQualificationsEntityName inManagedObjectContext:XAppDelegate.managedObjectContext withDictionary:dictionary andPredicate:predicate])
                
                savedSuccessfully = YES;
        }
        
        /* This is a new entry! no previous record exists in core data */
        
        else
        {
            if([CoreDataHelper persistObjectForEntityName:kQualificationsEntityName inManagedObjectContext:XAppDelegate.managedObjectContext withDictionary:dictionary])
                
                savedSuccessfully = YES;
        }
    }];
    
    return savedSuccessfully;
}

@end
