//
//  TweetCell.m
//  twitter
//
//  Created by laurentsai on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
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

-(void)refreshData {
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.nameLabel.text=self.tweet.user.name;
    
    self.tweetContentLabel.text = self.tweet.text;
   self.tweetContentLabel.userInteractionEnabled = YES;
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
    NSLog(@"URL Tapped = %@",tappedString);
    };
    [self.tweetContentLabel enableURLDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber
    numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    
    
    self.dateLabel.text=self.tweet.timeAgo;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.favoriteCount ];
    self.retweetCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.retweetCount ];
    self.replyCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.replyCount];
    self.profileImageView.image= nil;
    
    [self.profileImageView setImageWithURL:self.tweet.user.profileImageURL];
    self.profileImageView.layer.cornerRadius=self.profileImageView.frame.size.width/2;
    self.profileImageView.clipsToBounds=YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
