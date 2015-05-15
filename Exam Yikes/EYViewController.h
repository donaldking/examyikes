//
//  EYViewController.h
//  EYExam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYAppDelegate.h"

@interface EYViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
    NSFetchRequest *fetchRequest;
}


//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

