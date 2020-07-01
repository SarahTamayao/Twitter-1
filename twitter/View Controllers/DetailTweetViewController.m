//
//  DetailTweetViewController.m
//  twitter
//
//  Created by laurentsai on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailTweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailTweetViewController ()

@end

@implementation DetailTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [self loadTweet];
}
- (void) loadTweet{
    self.dateLabel.text=self.tweet.createdAtString;
    self.likeCountLabel.text= [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text= [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.tweetTextLabel.text= self.tweet.text;
    self.nameLabel.text=self.tweet.user.name;
    self.userNameLabel.text=[@"@" stringByAppendingString:self.tweet.user.screenName];

    NSURL *pfImageURL = [NSURL URLWithString:self.tweet.user.profileImageURL];
    self.profileImage.image= nil;
    
    [self.profileImage setImageWithURL:pfImageURL];
    
    self.likeButton.selected=self.tweet.favorited;
    self.retweetButton.selected=self.tweet.retweeted;    
}
- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted= !self.tweet.retweeted;
    if(self.tweet.retweeted)
    {
        self.tweet.retweetCount++;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet * tweet, NSError *error) {
            if(tweet)
            {
                NSLog(@"Success post rt req");
            }
            else{
                NSLog(@"Error POST for rt: %@", error.localizedDescription);
            }
        }];
    }
    else
    {
        self.tweet.retweetCount--;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet * tweet, NSError *error) {
            if(tweet)
            {
                NSLog(@"Success un rt post req");
            }
            else{
                NSLog(@"Error POST for un rt: %@", error.localizedDescription);
            }
        }];
    }
    // TODO: Update cell UI
    self.retweetButton.selected=self.tweet.retweeted;
    [self refreshData];
}

- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited= !self.tweet.favorited;
    if(self.tweet.favorited)
    {
        self.tweet.favoriteCount++;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet * tweet, NSError *error) {
            if(tweet)
            {
                NSLog(@"Success like post req");
            }
            else{
                NSLog(@"Error POST for Like: %@", error.localizedDescription);
            }
        }];
    }
    else
        self.tweet.favoriteCount--;
    {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet * tweet, NSError *error) {
            if(tweet)
            {
                NSLog(@"Success unlike post req");
            }
            else{
                NSLog(@"Error POST for unlike: %@", error.localizedDescription);
            }
        }];
    }
    // TODO: Update cell UI
    self.likeButton.selected=self.tweet.favorited;
    [self refreshData];
}
-(void)refreshData {
    self.userNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.nameLabel.text=self.tweet.user.name;
    
    self.tweetTextLabel.text= self.tweet.text;
    self.dateLabel.text=self.tweet.createdAtString;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.favoriteCount ];
    self.retweetCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.retweetCount ];
    NSURL *pfImageURL = [NSURL URLWithString:self.tweet.user.profileImageURL];
    self.profileImage.image= nil;
    [self.profileImage setImageWithURL:pfImageURL];
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
