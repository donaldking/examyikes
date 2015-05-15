//
//  EYAppDelegate.h
//  EYExam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"
#import "Constants.h"
#import "AFNetworking.h"

#define XAppDelegate ((EYAppDelegate*)[[UIApplication sharedApplication] delegate])

@interface EYAppDelegate : UIResponder <UIApplicationDelegate>


//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) MBProgressHUD *hud;


//------------------------------------------------------------------------------
// MARK: - Core Data
//------------------------------------------------------------------------------

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


//------------------------------------------------------------------------------
// MARK: - HUD
//------------------------------------------------------------------------------

- (MBProgressHUD *)prepareHudView:(UIView *)view WithMessage:(NSString *)message;

@end

