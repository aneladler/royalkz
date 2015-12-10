//
//  InfoTableViewCell.h
//  RoyalKz
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Belkozhayeva Anel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewsLabel;

@end
