//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "ResponsiveLabel.h"
#import "User.h"
#import "InfiniteScrollActivityView.h"


@interface TimelineViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *tweets;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) InfiniteScrollActivityView* loadingMoreView;

- (IBAction)imgTapped:(id)sender;
- (void) didTapLink:(NSURL*)link;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
