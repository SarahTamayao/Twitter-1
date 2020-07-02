//
//  ProfileViewController.m
//  twitter
//
//  Created by laurentsai on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!self.user)
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.user=appDelegate.currentUser;
        NSLog(@"Here in load user");
    }
    [self loadProfile];
}
- (void) loadProfile{
    [self.coverPic setImageWithURL:self.user.profileBannerURL];
    [self.profilePic setImageWithURL:self.user.profileImageURL];
    self.nameLabel.text=self.user.name;
    self.usernameLabel.text=[@"@" stringByAppendingString:self.user.screenName];
    
    if([self.user.followerCount intValue]>=1000)
        self.followerCount.text=[self abbreviateNumber:[self.user.followerCount intValue]  withDecimal:2];
    else
        self.followerCount.text= self.user.followerCount;
    if([self.user.friendsCount intValue]>=1000)
           self.followingCount.text=[self abbreviateNumber:[self.user.friendsCount intValue]  withDecimal:2];
       else
           self.followingCount.text= self.user.friendsCount;
    if([self.user.tweetCount intValue]>=1000)
        self.tweetCount.text=[self abbreviateNumber:[self.user.tweetCount intValue]  withDecimal:2];
    else
        self.tweetCount.text=self.user.tweetCount;
}
-(NSString *)abbreviateNumber:(int)num withDecimal:(int)dec {

    NSString *abbrevNum;
    float number = (float)num;

    NSArray *abbrev = @[@"K", @"M", @"B"];

    for (int i = (int) abbrev.count - 1; i >= 0; i--) {

        // Convert array index to "1000", "1000000", etc
        int size = pow(10,(i+1)*3);

        if(size <= number) {
            // Here, we multiply by decPlaces, round, and then divide by decPlaces.
            // This gives us nice rounding to a particular decimal place.
            number = round(number*dec/size)/dec;

            NSString *numberString = [self floatToString:number];

            // Add the letter for the abbreviation
            abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];

            NSLog(@"%@", abbrevNum);

        }

    }


    return abbrevNum;
}

- (NSString *) floatToString:(float) val {

    NSString *ret = [NSString stringWithFormat:@"%.1f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];

    while (c == 48 || c == 46) { // 0 or .
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
    }

    return ret;
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
