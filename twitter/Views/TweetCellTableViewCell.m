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
#import <NSDate+DateTools.h>

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
    NSString * duration=[tweet.date shortTimeAgoSinceNow];
    self.datelabel.text=duration;
}

- (IBAction)liked:(id)sender {
    
    //    TimelineViewController *time=[[TimelineViewController alloc] init];
    //    [time.tableView reloadData];
    //
    UIColor *maincolor=[UIColor colorWithRed: 173/255.0
                                       green: 184/255.0
                                        blue: 194/255.0
                                       alpha:1];
    
    
    
    if(self.tweet.favorited== YES){
        self.tweet.favorited=NO;
        self.tweet.favoriteCount-=1;
        self.likebutton.selected=NO;
        self.favcount.textColor=maincolor;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error Unfavoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully Unfavorited the following Tweet: %@", tweet.text);
                //self.likebutton.backgroundColor=[UIColor redColor];
                NSLog(@"%i",self.tweet.favoriteCount);
            }
        }];
    } else if(self.tweet.favorited== NO){
        self.tweet.favorited=YES;
        self.tweet.favoriteCount+=1;
        self.likebutton.selected=YES;
        self.favcount.textColor=UIColor.redColor;
       
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                //self.likebutton.backgroundColor=[UIColor redColor];
                NSLog(@"%i",self.tweet.favoriteCount);
            }
        }];
    
    }
    
[self refreshdata];
}

    
-(IBAction)retweet:(id)sender {
  
    //    TimelineViewController *time=[[TimelineViewController alloc] init];
    //    [time.tableView reloadData];
    //
    UIColor *maincolor=[UIColor colorWithRed: 173/255.0
                                       green: 184/255.0
                                        blue: 194/255.0
                                       alpha:1];
    if(self.tweet.retweeted==YES){
        self.tweet.retweeted=NO;
        self.tweet.retweetCount-=1;
        self.tweetbutton.selected=NO;
        self.retweetcount.textColor=maincolor;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error Unretweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully Unretweet: %@", tweet.text);
                
            }
        }];
        
    }else if (self.tweet.retweeted==NO){
        self.tweet.retweeted=YES;
        self.tweet.retweetCount+=1;
        self.tweetbutton.selected=YES;
        self.retweetcount.textColor=UIColor.greenColor;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting: %@", error.localizedDescription);
               }
            else{
                NSLog(@"Successfully retweet: %@", tweet.text);
                NSLog(@"%i",self.tweet.favoriteCount);
            }
        }];
        
    }
    
    
    [self refreshdata];
    
    
}



-(void) refreshdata{
    self.favcount.text=[NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetcount.text=[NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}



@end
