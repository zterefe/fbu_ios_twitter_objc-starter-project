//
//  User.m
//  twitter
//
//  Created by Zelalem Tenaw Terefe on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self=[super init];
    
    if(self){
        self.name=dictionary[@"name"];
        self.screenname=dictionary[@"screen_name"];
        
    }
    return self;
}
@end

