//
//  EYSubjectsViewController.h
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYAppDelegate.h"

@interface EYSubjectsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *subjectsArray;
}

//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (nonatomic, strong)NSManagedObject *selectedObject;
@property (nonatomic, strong)IBOutlet UITableView *tableView;

@end
