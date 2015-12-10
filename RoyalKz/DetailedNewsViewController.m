//
//  DetailedNewsViewController.m
//  RoyalKz
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Belkozhayeva Anel. All rights reserved.
//

#import "DetailedNewsViewController.h"

@interface DetailedNewsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;
@property (strong, nonatomic) IBOutlet UILabel *newsTagsLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsViewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsCatLabel;
@property (strong, nonatomic) IBOutlet UILabel *postedByLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsDomainLabel;

@end

@implementation DetailedNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsTitleLabel.text = [self.news newsTitle];
    
    NSURL *url = [NSURL URLWithString:[self.news imagePath]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.newsImage.image = image;
    
    for(int i = 0; i < [self.news newsTags].count; i++){
        self.newsTagsLabel.text = [[self.news newsTags] objectAtIndex:i];
    }
    
    self.newsDateLabel.text = [self.news newsDate];
    self.newsViewsLabel.text = [NSString stringWithFormat:@"%i",[self.news newsViews]];
    self.newsCatLabel.text = [self.news newsCat];
    self.postedByLabel.text = [NSString stringWithFormat:@"%@%@", @"Posted by:", [self.news postedBy]];
    self.newsDomainLabel.text = [NSString stringWithFormat:@"%@%@", @"Source:", [self.news newsDomain]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
