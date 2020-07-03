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
#import "APIManager.h"
@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    if(!self.user)
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.user=appDelegate.currentUser;
        NSLog(@"Here in load user");
    }
    [[APIManager shared] getUserTimelineWithCompletion:self.user completion:^(NSArray *tweets, NSError *error) {
        if(tweets)
        {
            self.userTweets= [tweets mutableCopy];
            NSLog(@"Success getting user tweets");
        }
        else
        {
            NSLog(@"There was an error getting user tweets: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    
    [self loadProfile];
}
-(void) viewWillAppear:(BOOL)animated{
    [self loadProfile];
}
- (void) loadProfile{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if([self.user.id_str isEqualToString:appDelegate.currentUser.id_str])
    {
        [appDelegate getUserData];
        self.user=appDelegate.currentUser;
    }
    
    if(self.user.profileBannerURL==nil)
        [self.coverPic setImage:[UIImage imageNamed:@"twitterBlue"]];//default blue background
    else
        [self.coverPic setImageWithURL:self.user.profileBannerURL ];
    [self.profilePic setImageWithURL:self.user.profileImageURL];
    self.profilePic.layer.cornerRadius=self.profilePic.frame.size.width/2;
    self.profilePic.clipsToBounds=YES;
    self.profilePic.layer.masksToBounds = YES;
    self.profilePic.layer.borderWidth=1;
    self.profilePic.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    self.profilePic.layer.zPosition=2;
    
    self.descriptionLabel.text=self.user.userDescription;
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

            //NSLog(@"%@", abbrevNum);

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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell= [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];//use the cell that we created
    Tweet *ctweet= self.userTweets[indexPath.row];
    tweetCell.tweet=ctweet;
    tweetCell.screenNameLabel.text = [@"@" stringByAppendingString:ctweet.user.screenName];
    tweetCell.nameLabel.text=ctweet.user.name;
    
    tweetCell.tweetContentLabel.text= ctweet.text;
    tweetCell.tweetContentLabel.userInteractionEnabled = YES;
    /*
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
        [self didTapLink:[NSURL URLWithString:tappedString]];
     };
     [tweetCell.tweetContentLabel enableURLDetectionWithAttributes:
     @{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber
     numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    */
    tweetCell.dateLabel.text=ctweet.timeAgo;
    tweetCell.likeCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.favoriteCount ];
    tweetCell.retweetCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.retweetCount ];
    tweetCell.replyCountLabel.text=[NSString stringWithFormat:@"%d",ctweet.replyCount];
    tweetCell.profileImageView.image= nil;
    
    [tweetCell.profileImageView setImageWithURL:ctweet.user.profileImageURL];
    tweetCell.profileImageView.layer.cornerRadius=tweetCell.profileImageView.frame.size.width/2;
    tweetCell.profileImageView.clipsToBounds=YES;
    tweetCell.profileImageView.layer.masksToBounds = YES;
    
    tweetCell.profileImageView.gestureRecognizers=nil;
    
   // UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapped:)];
    //tweetCell.imgTapRecog= imgtapGesture;
    //[tweetCell.profileImageView addGestureRecognizer:tweetCell.imgTapRecog];//add to the image view
    //tweetCell.imgTapRecog.tag= indexPath.row;
    
    tweetCell.mediaView.image= nil;
    if(ctweet.mediaUrl)
    {
        CGRect mediaRect = tweetCell.mediaView.frame;
        mediaRect.size.height = 150;
        tweetCell.mediaView.frame = mediaRect;
        [tweetCell.mediaView setImageWithURL:ctweet.mediaUrl];
    }
    else
    {
        CGRect mediaRect = tweetCell.mediaView.frame;
        mediaRect.size.height = 0;
        tweetCell.mediaView.frame = mediaRect;
    }

    
    tweetCell.likeButton.selected=ctweet.favorited;
    tweetCell.retweetButton.selected=ctweet.retweeted;
    
    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userTweets.count;
}

@end
