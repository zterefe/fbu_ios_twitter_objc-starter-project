//
//  User.h
//  twitter
//
//  Created by Zelalem Tenaw Terefe on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong, nonatomic) NSString *name;
@property(strong,nonatomic) NSString *screenname;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
