//
//  User.h
//  twitter
//
//  Created by laurentsai on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSURL *profileImageURL;
@property (nonatomic, strong) NSURL *profileBannerURL;
@property (nonatomic, strong) NSString *followerCount;
@property (nonatomic, strong) NSString *friendsCount;
@property (nonatomic, strong) NSString *tweetCount;
@property (nonatomic, strong) NSString *userDescription;
@property (nonatomic, strong) NSString *favoriteCount;
@property (nonatomic, strong) NSString *profileCreatedDate;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *id_str;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
