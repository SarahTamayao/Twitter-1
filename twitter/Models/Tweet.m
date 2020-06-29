//
//  Tweet.m
//  twitter
//
//  Created by laurentsai on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if(self)
    {
        NSDictionary *origTweet= dictionary[@"retweeted_status"];
        if(origTweet!=nil)
        {
            NSDictionary *userDictionary= dictionary[@"user"];
            self.retweetedByUser=[[User alloc] initWithDictionary:userDictionary];//create a new user and initialize it to the original tweeter
            dictionary=origTweet;//change the tweet to the original
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        // TODO: initialize user
        NSDictionary *user= dictionary[@"user"];
        self.user=[[User alloc] initWithDictionary:user];//create new user with the info from tweet
        // TODO: Format and set createdAtString
        NSString *createdAtOrigStr= dictionary[@"created_at"];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];//initialize the formatter
        formatter.dateFormat=@"E MMM d HH:mm:ss Z y";// configure to parse the original format
        NSDate *date=[formatter dateFromString:createdAtOrigStr];
        //config output format
        formatter.dateStyle=NSDateFormatterShortStyle;
        formatter.timeStyle=NSDateFormatterNoStyle;
        self.createdAtString= [formatter stringFromDate:date];
    }
    return self;
}
//add factory method that returns tweets when initialized with an array of tweet dictionaries
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets= [NSMutableArray array];
    for(NSDictionary *dictonary in dictionaries)
    {
        //create an array of tweets from the big dictionary full of tweets
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictonary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
