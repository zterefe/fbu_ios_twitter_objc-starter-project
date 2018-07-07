//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "User.h"
#import "Tweet.h"
#import "TweetCellTableViewCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController  ()  < ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) NSMutableArray *tweetArray;
@property(strong, nonatomic) UIRefreshControl * refreshcontrol;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.tableView.rowHeight = 170;
    
    [self fecthTweets];
    self.refreshcontrol = [[UIRefreshControl alloc] init];
     [self.refreshcontrol addTarget:self action:@selector(fecthTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshcontrol atIndex:0];
    
    // Get timeline
    
    
}
-(void)fecthTweets{
[[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
    if (tweets) {
        NSLog(@"😎😎😎 Successfully loaded home timeline");
        
        self.tweetArray=[NSMutableArray arrayWithArray: tweets];
        [self.tableView reloadData];
        [self.refreshcontrol endRefreshing];
    } else {
        NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
    }
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweetArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCellTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:
    @"TweetCellTableViewCell"];
   Tweet * tweet = self.tweetArray[indexPath.row];
    //[cell configureTweet:tweet];
    cell.tweet = tweet;
    return cell;
}
-(void) didTweet:(Tweet *)tweet{
    [self.tweetArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}
- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

@end
