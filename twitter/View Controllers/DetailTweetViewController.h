//
//  DetailTweetViewController.h
//  twitter
//
//  Created by laurentsai on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "ResponsiveLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet ResponsiveLabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *mediaImage;
-(void) loadTweet;
-(void) refreshData;
-(void) didTapLink:(NSURL*)link;
@end

NS_ASSUME_NONNULL_END
