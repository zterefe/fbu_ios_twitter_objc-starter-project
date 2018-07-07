//
//  Tweet.h
//  twitter
//
//  Created by Zelalem Tenaw Terefe on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property(nonatomic, strong) NSString *idStr;
@property(strong, nonatomic) NSString *text;
@property(nonatomic) int favoriteCount;
@property(nonatomic) BOOL favorited;
@property(nonatomic) int retweetCount;
@property(nonatomic) BOOL retweeted;
@property(strong,nonatomic) NSURL *profileurl;
@property(strong,nonatomic) User* user;
@property(strong,nonatomic) NSString *createdAtString;

@property(strong, nonatomic) User *retweetedByUser;
-(instancetype) initWithDictionary:(NSDictionary *) dictionary;
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end
