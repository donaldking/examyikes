//
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

//------------------------------------------------------------------------------
// MARK: - Persist object for the entity name specified
//------------------------------------------------------------------------------

+ (BOOL)persistObjectForEntityName:(NSString*)entityName
            inManagedObjectContext:(NSManagedObjectContext*)context withDictionary:(NSDictionary*)dictionary;


//------------------------------------------------------------------------------
// MARK: - Update attribute for entity name specified
//------------------------------------------------------------------------------

+ (BOOL)updateAttributeForEntityName:(NSString*)entityName inManagedObjectContext:(NSManagedObjectContext*)context
                      withDictionary:(NSDictionary*)dictionary andPredicate:(NSPredicate*)prediacte;


//------------------------------------------------------------------------------
// MARK: - Fetch objects for the entity name specified
//------------------------------------------------------------------------------

+ (NSArray*)fetchObjectsForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate
               inManagedObjectContext:(NSManagedObjectContext*)context setResultType:(NSFetchRequestResultType)resultType;


//------------------------------------------------------------------------------
// MARK: - Fetch objects for the entity name specified with sort descriptor
//------------------------------------------------------------------------------

+ (NSArray*)fetchObjectsForEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate withSortDescriptor:(NSSortDescriptor*)sortDescriptor
               inManagedObjectContext:(NSManagedObjectContext*)context setResultType:(NSFetchRequestResultType)resultType;

@end
