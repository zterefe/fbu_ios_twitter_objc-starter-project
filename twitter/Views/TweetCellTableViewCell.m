//
//  TweetCellTableViewCell.m
//  twitter
//
//  Created by Zelalem Tenaw Terefe on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "TimelineViewController.h"
#import "APIManager.h"

@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTweet:(Tweet *)tweet{
    
    _tweet = tweet;
    self.username.text = tweet.user.name;
    self.retweetcount.text=[NSString stringWithFormat: @"%d", tweet.retweetCount];
    self.favcount.text=[NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.textfield.text=tweet.text;
    self.imagefield.image=nil;
    [self.imagefield setImageWithURL:tweet.profileurl];
}

- (IBAction)liked:(id)sender {
    self.tweet.favorited=YES;
    self.tweet.favoriteCount+=1;
    //    TimelineViewController *time=[[TimelineViewController alloc] init];
    //    [time.tableView reloadData];
    //
     [self refreshdata];
 
    
    
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                NSLog(@"%i",self.tweet.favoriteCount);
                }
        }];
    self.count++;
    if(self.count==1){
    
        self.count=0;
        self.tweet.favorited=NO;
        self.tweet.favoriteCount-=1;
    }
    
}

    
-(IBAction)retweet:(id)sender {
    self.tweet.retweeted=YES;
    self.tweet.retweetCount+=1;
    //    TimelineViewController *time=[[TimelineViewController alloc] init];
    //    [time.tableView reloadData];
    //
    [self refreshdata];
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            self.tweet.favorited=NO;
            self.tweet.favoriteCount-=1;
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            NSLog(@"%i",self.tweet.favoriteCount);
        }
    }];
    
}



-(void) refreshdata{
    self.favcount.text=[NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetcount.text=[NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}



@end