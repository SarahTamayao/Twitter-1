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
    
    UIImage *nonFavImage= [UIImage imageNamed:@"favor-icon"];
    //UIImage *favImage= [UIImage imageNamed:@"favor-icon-red"];
    UIImage *nonRTImage= [UIImage imageNamed:@"retweet-icon"];
    UIImage *rtImage= [UIImage imageNamed:@"rewtweet-icon-green"];

    [self.likeButton setImage:nonFavImage forState: UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [self.retweetButton setImage:nonRTImage forState:UIControlStateNormal];
    [self.retweetButton setImage:rtImage forState:UIControlStateSelected];
     

}
- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited= !self.tweet.favorited;
    if(self.tweet.favorited)
        self.tweet.favoriteCount++;
    else
        self.tweet.favoriteCount--;
    // TODO: Update cell UI
    self.likeButton.selected=self.tweet.favorited;
    [self refeshData];
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet * tweet, NSError *error) {
        if(tweet)
        {
            NSLog(@"Success post req");
            [self refeshData];
        }
        else{
            NSLog(@"Error POST for Like: %@", error.localizedDescription);
        }
    }];

}
- (IBAction)didTapRetweet:(id)sender {
}

-(void)refeshData {
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.nameLabel.text=self.tweet.user.name;
    
    self.tweetContentLabel.text= self.tweet.text;
    self.dateLabel.text=self.tweet.createdAtString;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.favoriteCount ];
    self.retweetCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.retweetCount ];
    self.replyCountLabel.text=[NSString stringWithFormat:@"%d",self.tweet.replyCount];
    NSURL *pfImageURL = [NSURL URLWithString:self.tweet.user.profileImageURL];
    self.profileImageView.image= nil;
    
    [self.profileImageView setImageWithURL:pfImageURL];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
