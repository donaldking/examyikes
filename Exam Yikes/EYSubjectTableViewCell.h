//
//  EYSubjectTableViewCell.h
//  Exam Yikes
//
//  Created by Donald King on 14/05/2015.
//  Copyright (c) 2015 Tusk Solutions UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EYSubjectTableViewCell : UITableViewCell

//------------------------------------------------------------------------------
// MARK: - Properties
//------------------------------------------------------------------------------

@property (weak, nonatomic) IBOutlet UIView *colorCode;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
