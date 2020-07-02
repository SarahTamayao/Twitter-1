//
//  User.m
//  twitter
//
//  Created by laurentsai on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
-(instancetype) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    //NSLog(@"%@", dictionary);
    if(self)//not equal null
    {
        self.name=dictionary[@"name"];
        self.screenName=dictionary[@"screen_name"];
        NSString*profileClear=[dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        if(dictionary[@"profile_image_url_https"])
            self.profileImageURL=[NSURL URLWithString:profileClear];
        if(dictionary[@"profile_background_image_url_https"])
            self.profileBannerURL=[NSURL URLWithString:dictionary[@"profile_banner_url"]];
        
        self.profileCreatedDate= dictionary[@"created_at"];
        self.tweetCount=[NSString stringWithFormat:@"%@",dictionary[@"statuses_count"]];
        self.favoriteCount=[NSString stringWithFormat:@"%@", dictionary[@"favourites_count"]];
        self.friendsCount=[NSString stringWithFormat:@"%@",dictionary[@"friends_count"]];
        self.followerCount=[NSString stringWithFormat:@"%@",dictionary[@"followers_count"]];
        self.userDescription=dictionary[@"description"];
        self.location=dictionary[@"location"];
        self.id_str=dictionary[@"id_str"];
    }
    return self;
}
@end
