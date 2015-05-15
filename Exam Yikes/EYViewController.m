//
//  EYViewController.m
//  EYExam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import "EYViewController.h"
#import "EYAPIGetCourses.h"
#import "EYQualificationTableViewCell.h"
#import "EYSubjectTableViewCell.h"
#import "EYSubjectsViewController.h"

@interface EYViewController ()
{
    EYQualificationTableViewCell *qCell;
    EYAPIGetCourses *qualificationsApiObject;
    
}
@end

@implementation EYViewController


//------------------------------------------------------------------------------
// MARK: - NSFetchedResultsController
//------------------------------------------------------------------------------

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kQualificationsEntityName inManagedObjectContext:XAppDelegate.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sort]];
    [fetchRequest setFetchBatchSize:10];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:XAppDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    NSError *fetchError;
    
    if (![_fetchedResultsController performFetch:&fetchError])
    {
        NSLog(@"Error performing fetch: %@", fetchError);
    }
    else
    {
        [self.tableView reloadData];
    }
    
    return _fetchedResultsController;
}


//------------------------------------------------------------------------------
// MARK: - NSFetchedResultsController delegates
//------------------------------------------------------------------------------

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(EYQualificationTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView insertRowsAtIndexPaths:[NSArray
                                            arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


//------------------------------------------------------------------------------
// MARK: - TableView DataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)configureCell:(EYQualificationTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell.title setText:[object valueForKey:@"name"]];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    qCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:qCell atIndexPath:indexPath];
    
    return qCell;
}


//------------------------------------------------------------------------------
// MARK: - TableView Delegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *object = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"toSubjectsSegue" sender:object];
}

//------------------------------------------------------------------------------
// MARK: - Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performGetCourses];
}


//------------------------------------------------------------------------------
// MARK: - Prepare for segue
//------------------------------------------------------------------------------

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toSubjectsSegue"])
    {
        NSManagedObject *object = (NSManagedObject*)sender;
        EYSubjectsViewController *viewController = (EYSubjectsViewController *) [segue destinationViewController];
        
        [viewController setTitle:[object valueForKey:@"name"]];
        [viewController setSelectedObject:object];
    }
}

//------------------------------------------------------------------------------
// MARK: - Network operation
//------------------------------------------------------------------------------

- (void)performGetCourses
{
    [XAppDelegate prepareHudView:self.view WithMessage:@"Please wait"];
    
    [self fetchedResultsController];
    qualificationsApiObject = [EYAPIGetCourses new];
    
   [qualificationsApiObject processRequestWithParams:nil completion:^(BOOL success, id completionResponse, NSError *error) {
       //
       if (success)
       {
           [XAppDelegate.hud setHidden:YES];
           [self.tableView reloadData];
       }
       else
       {
          [self.tableView reloadData];
           NSLog(@"Error");
       }
   }];

}

//------------------------------------------------------------------------------
// MARK: - Memory management and clean up
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
