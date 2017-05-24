//
//  Model.h
//  MVVMDemo
//
//  Created by yuanchao Li on 2017/5/24.
//  Copyright © 2017年 yuanchao Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Model : NSObject

@property (nonatomic, assign, readonly, getter=isLoading) BOOL load;
@property (nonatomic, strong, readonly) User *user;

- (void)fetchUser;

@end
