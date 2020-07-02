//
//  ProfileViewController.h
//  twitter
//
//  Created by laurentsai on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *coverPic;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *followerCount;
@property (strong, nonatomic) IBOutlet UILabel *followingCount;
@property (strong, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (void) loadProfile;
-(NSString *)abbreviateNumber:(int)num withDecimal:(int)dec;
- (NSString *) floatToString:(float) val;
@end

NS_ASSUME_NONNULL_END
