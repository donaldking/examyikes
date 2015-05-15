//
//  EYSubjectsViewController.m
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "EYSubjectsViewController.h"
#import "EYSubjectTableViewCell.h"
#import "UIColor+HexColor.h"

@interface EYSubjectsViewController ()
{
    EYSubjectTableViewCell *sCell;
}
@end

@implementation EYSubjectsViewController

//------------------------------------------------------------------------------
// MARK: - TableView DataSource
//------------------------------------------------------------------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return subjectsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)configureCell:(EYSubjectTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell.colorCode setBackgroundColor:[UIColor tsk_colorWithHexString:[[subjectsArray objectAtIndex:indexPath.row ] valueForKey:@"colour"]]];
    
    [cell.title setText:[[subjectsArray objectAtIndex:indexPath.row ] valueForKey:@"title"]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    sCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:sCell atIndexPath:indexPath];
    
    return sCell;
}


//------------------------------------------------------------------------------
// MARK: - Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self displaySubjects];
}


//------------------------------------------------------------------------------
// MARK: - Display subjects
//------------------------------------------------------------------------------

- (void)displaySubjects
{
    subjectsArray = (NSArray*)[_selectedObject valueForKey:@"subjects"];
    
    if ([subjectsArray count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"No subjects added yet for this qualification" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
        
        [alert show];
    }
}


//------------------------------------------------------------------------------
// MARK: - Memory management & clean up
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
