//
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

//------------------------------------------------------------------------------
// MARK: - Persist object for the entity name specified
//------------------------------------------------------------------------------

+ (BOOL)persistObjectForEntityName:(NSString*)entityName
            inManagedObjectContext:(NSManagedObjectContext*)context withDictionary:(NSDictionary*)dictionary
{
    BOOL insertResult;
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    
    [newObject setValuesForKeysWithDictionary:dictionary];
    
    NSError *error;
    if([context save:&error])
    {
        insertResult = YES;
    }
    else
    {
        insertResult = NO;
    }
    return insertResult;
}


//------------------------------------------------------------------------------
// MARK: - Update attribute for entity name specified
//------------------------------------------------------------------------------

+ (BOOL)updateAttributeForEntityName:(NSString*)entityName inManagedObjectContext:(NSManagedObjectContext*)context
                      withDictionary:(NSDictionary*)dictionary andPredicate:(NSPredicate*)prediacte
{
    BOOL result = NO;
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [request setPredicate:prediacte];
    
    NSManagedObject *object = [[context executeFetchRequest:request error:&error] lastObject];
    if (error)
    {
        result = NO;
    }
    if(!object)
    {
        result = NO;
    }
    else if (object)
    {
        [object setValuesForKeysWithDictionary:dictionary];
        
        if([context save:&error])
        {
            
            result = YES;
        }
        else
        {
            result = NO;
        }
    }
    return result;
}


//------------------------------------------------------------------------------
// MARK: - Fetch objects for the entity name specified
//------------------------------------------------------------------------------

+ (NSArray*)fetchObjectsForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate
               inManagedObjectContext:(NSManagedObjectContext*)context setResultType:(NSFetchRequestResultType)resultType
{
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [request setResultType:resultType];
    [request setPredicate:predicate];
    
    return [context executeFetchRequest:request error:&error];
}


//------------------------------------------------------------------------------
// MARK: - Fetch objects for the entity name specified with sort descriptor
//------------------------------------------------------------------------------

+ (NSArray*)fetchObjectsForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate withSortDescriptor:(NSSortDescriptor*)sortDescriptor inManagedObjectContext:(NSManagedObjectContext*)context setResultType:(NSFetchRequestResultType)resultType
{
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [request setResultType:resultType];
    [request setPredicate:predicate];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
    [request setSortDescriptors:sortDescriptors];
    
    return [context executeFetchRequest:request error:&error];
}

@end
