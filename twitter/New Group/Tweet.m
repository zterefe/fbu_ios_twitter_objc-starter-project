//
//  Tweet.m
//  twitter
//
//  Created by Zelalem Tenaw Terefe on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet
-(instancetype) initWithDictionary:(NSDictionary *)dictionary{
    self=[super init];
    
    
    if(self){
        //NSDictionary *original= dictionary[@"retweeted_status"];
        if(dictionary[@"retweeted_status"]!=nil){
            NSDictionary *original=dictionary[@"retweeted_status"];
            NSDictionary *userdictionary=dictionary[@"user"];
            self.retweetedByUser=[[User alloc] initWithDictionary:userdictionary];
            dictionary=original;
        }
        self.idStr=dictionary[@"id_str"];
        self.text=dictionary[@"text"];
        self.favoriteCount=[dictionary[@"favorite_count"] intValue];
        self.favorited=[dictionary[@"favorited"]boolValue];
        self.retweetCount= [dictionary[@"retweet_count"] intValue];
        self.retweeted=[dictionary[@"retweeted"] boolValue];
        
        
        NSDictionary *user=dictionary[@"user"];
        self.user=[ [User alloc] initWithDictionary:user];
        NSString *pic=dictionary[@"user"][@"profile_image_url_https"];
        NSURL * profile=[NSURL URLWithString:pic];
        self.profileurl=profile;
        
        
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        self.date = [formatter dateFromString:createdAtOriginalString];
      
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:self.date];
        }
        
        
    return self;
}
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}




@end
