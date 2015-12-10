//
//  NewsTableViewController.m
//  RoyalKz
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Belkozhayeva Anel. All rights reserved.
//

#import "NewsTableViewController.h"
#import "InfoTableViewCell.h"
#import "News.h"
#import "DetailedNewsViewController.h"

@interface NewsTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property int countNews;
@property NSMutableArray *newsAll;
@property News *chosenNews;
@end

@implementation NewsTableViewController{
    NSMutableDictionary *result;
    NSMutableURLRequest *postRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ROYAL.KZ";
     self.urlString = @"http://api.royal.kz/soc/news";
    self.chosenNews = [News new];

    [self myFunction:self.urlString andWithBlock:^{
       
        self.newsAll = [NSMutableArray new];
            NSMutableArray *models = [result objectForKey:@"models"];
            self.countNews = [[result objectForKey:@"news_count"] intValue];
           for(NSMutableDictionary *model in models) {
               News *n = [News new];
               
               [n setNewsTitle:[model objectForKey:@"news_title"]];
               [n setNewsCat:[model objectForKey:@"news_cat"]];
               [n setPostedBy:[model objectForKey:@"account_fullname"]];
               NSString *combined = [NSString stringWithFormat:@"%@%@", @"http://fs.royal.kz/640x480xc/", [model objectForKey:@"news_image_file"]];
               [n setImagePath:combined];
               //[n setImagePath:[model objectForKey:@"news_image_file"]];
               [n setNewsTags:[model objectForKey:@"news_tags"]];
               [n setNewsDate:[model objectForKey:@"news_created_date"]];
               [n setIsVisible:[[model objectForKey:@"news_is_visible"] boolValue]];
               [n setNewsViews:[[model objectForKey:@"news_views"] intValue]];
               [n setNewsDomain:[model objectForKey:@"news_domain"]];
               
               [self.newsAll addObject:n];
        }
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.countNews;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = [[self.newsAll objectAtIndex:indexPath.row] newsTitle];
    cell.dateLabel.text = [[self.newsAll objectAtIndex:indexPath.row] newsDate];
    cell.viewsLabel.text = [NSString stringWithFormat:@"%i",[[self.newsAll objectAtIndex:indexPath.row] newsViews]];
    
    NSURL *url = [NSURL URLWithString:[[self.newsAll objectAtIndex:indexPath.row] imagePath]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    cell.newsImage.image = image;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //InfoTableViewCell *cell = (InfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.chosenNews = [News new];
    self.chosenNews = [self.newsAll objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toDetailedInfo" sender:self];
}
- (void)myFunction:(NSString *) urlString andWithBlock:(void (^)())block {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    
    //Create and add the Activity Indicator to splashView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    activityIndicator.hidesWhenStopped = NO;
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [self.view addSubview:view];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        NSURL *postURL;
        postURL = [NSURL URLWithString:urlString];
        postRequest = [NSMutableURLRequest new];
        [postRequest setTimeoutInterval:5.0];
        
        
        
        [postRequest setURL:[NSURL URLWithString:urlString]];
        
        [postRequest setHTTPMethod:@"GET"];
        
        
        [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [postRequest setURL:postURL];
        
        //send sync request
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
        
        result = [NSMutableDictionary new];
        
        
        if( error == nil) {
            
            result = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            
            postRequest = [[NSMutableURLRequest alloc] init];
            
        } else {
            postRequest = [[NSMutableURLRequest alloc] init];
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [view removeFromSuperview];
            
            block();
            
        });
    });
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailedNewsViewController *vc = (DetailedNewsViewController *)[segue destinationViewController];
    vc.news = self.chosenNews;
}


@end
