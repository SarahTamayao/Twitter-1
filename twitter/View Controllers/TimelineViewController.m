//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController ()<UITableViewDataSource, UITableViewDelegate>;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            /*
            for (NSDictionary *dictionary in tweets) {
                NSString *text = dictionary[@"text"];
                NSLog(@"%@", text);
            }*/
        self.tweets=[tweets mutableCopy];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];    
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell= [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];//use the cell that we created
    Tweet *ctweet= self.tweets[indexPath.row];
    tweetCell.screenNameLabel.text = ctweet.user.screenName;
    tweetCell.nameLabel.text=ctweet.user.name;
    
    tweetCell.tweetContentLabel.text= ctweet.text;
    tweetCell.dateLabel.text=ctweet.createdAtString;
    tweetCell.likeCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.favoriteCount ];
    tweetCell.retweetCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.retweetCount ];
    NSURL *pfImageURL = [NSURL URLWithString:ctweet.user.profileImageURL];
    tweetCell.profileImageView.image= nil;
    
    [tweetCell.profileImageView setImageWithURL:pfImageURL];


    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


@end
