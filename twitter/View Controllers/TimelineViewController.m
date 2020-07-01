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
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailTweetViewController.h"
#import "ProfileViewController.h"
#import "WebViewController.h"

@interface TimelineViewController ()<UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIRefreshControl *refreshControl= [[UIRefreshControl alloc] init];//initialize the refresh control
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];//add an event listener
    [self.tableView insertSubview:refreshControl atIndex:0];//add into the storyboard
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
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"Successfully reloaded home timeline");
            /*
            for (NSDictionary *dictionary in tweets) {
                NSString *text = dictionary[@"text"];
                NSLog(@"%@", text);
            }*/
        self.tweets=[tweets mutableCopy];
        [self.tableView reloadData];// Reload the tableView now that there is new data
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
            [refreshControl endRefreshing];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //create a tweet
    if([segue.identifier isEqualToString:@"composeSegue"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;//set the TimelineViewController as the delegate of the ComposeViewController
    }
    else if([segue.identifier isEqualToString:@"detailSegue"]){
        DetailTweetViewController *deetVC= segue.destinationViewController;
        UITableViewCell *tappedCell=sender;
        NSIndexPath *tappedIndex= [self.tableView indexPathForCell:tappedCell];
        deetVC.tweet=self.tweets[tappedIndex.row];
        [self.tableView deselectRowAtIndexPath:tappedIndex animated:YES];
    }
    else if([segue.identifier isEqualToString:@"profileSegue"]){
        ProfileViewController *profVC= segue.destinationViewController;
       CGPoint tapped= [sender locationInView:self.tableView];
       NSIndexPath* indexPath= [self.tableView indexPathForRowAtPoint:tapped];
        Tweet *tappedTweet= self.tweets[indexPath.row];
       profVC.user=tappedTweet.user;
    }
    else if([segue.identifier isEqualToString:@"linkSegue"]){
        WebViewController *webVC= segue.destinationViewController;
        webVC.link=sender;
    }
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell= [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];//use the cell that we created
    Tweet *ctweet= self.tweets[indexPath.row];
    tweetCell.tweet=ctweet;
    tweetCell.screenNameLabel.text = [@"@" stringByAppendingString:ctweet.user.screenName];
    tweetCell.nameLabel.text=ctweet.user.name;
    
    tweetCell.tweetContentLabel.text= ctweet.text;
    tweetCell.tweetContentLabel.userInteractionEnabled = YES;
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
        [self didTapLink:[NSURL URLWithString:tappedString]];
     };
     [tweetCell.tweetContentLabel enableURLDetectionWithAttributes:
     @{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber
     numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    tweetCell.dateLabel.text=ctweet.timeAgo;
    tweetCell.likeCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.favoriteCount ];
    tweetCell.retweetCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.retweetCount ];
    tweetCell.replyCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.replyCount];
    tweetCell.profileImageView.image= nil;
    
    [tweetCell.profileImageView setImageWithURL:ctweet.user.profileImageURL];
    tweetCell.profileImageView.gestureRecognizers=nil;
    
    UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapped:)];
    tweetCell.imgTapRecog= imgtapGesture;
    [tweetCell.profileImageView addGestureRecognizer:tweetCell.imgTapRecog];//add to the image view
    //tweetCell.imgTapRecog.tag= indexPath.row;

    
    tweetCell.likeButton.selected=ctweet.favorited;
    tweetCell.retweetButton.selected=ctweet.retweeted;
    
    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}
- (void)didTweet:(Tweet *)tweet{
    [self.tweets insertObject:tweet atIndex:0];//insert at the fromt of the array (newest)
    [self.tableView reloadData];
}
- (IBAction)tapLogout:(id)sender {
    AppDelegate *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyBoard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginVC= [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginVC;
    NSLog(@"Here in logout");
   if( [[APIManager shared] logout])//clear access token
   {
       NSLog(@"Success logout");
   }
}
-(IBAction)imgTapped:(id)sender{
    [self performSegueWithIdentifier:@"profileSegue" sender:sender];
}
- (void) didTapLink:(NSURL*)link{
    [self performSegueWithIdentifier:@"linkSegue" sender:link];
}

@end
