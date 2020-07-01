//
//  TweetCell.h
//  twitter
//
//  Created by laurentsai on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property(strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
- (IBAction)didTapLike:(id)sender;
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
