//
//  Model.m
//  MVVMDemo
//
//  Created by yuanchao Li on 2017/5/24.
//  Copyright © 2017年 yuanchao Li. All rights reserved.
//

#import "Model.h"
#import "User.h"

@interface Model ()

@property (nonatomic, strong) User *user;
@property (nonatomic, assign, getter=isLoading) BOOL load;

@end

@implementation Model

- (void)fetchUser
{
    // 模拟网络请求，或者数据库访问
    self.load = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        User *user = [[User alloc] init];
        user.identifier = 1;
        user.name = @"李远超";
        user.age = 28;
        user.university = @"山东工商学院";
        user.sex = 1;
        self.load = NO;
        self.user = user;
    });
}

@end
