//
//  News.h
//  RoyalKz
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Belkozhayeva Anel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property NSString *newsTitle;
@property NSString *newsCat;
@property NSString *postedBy;
@property NSString *imagePath;
@property NSMutableArray *newsTags;
@property NSString *newsDate;
@property BOOL isVisible;
@property int newsViews;
@property NSString *newsDomain;
@end
