//
//  ViewModel.m
//  MVVMDemo
//
//  Created by yuanchao Li on 2017/5/24.
//  Copyright © 2017年 yuanchao Li. All rights reserved.
//

#import "ViewModel.h"
#import "Model.h"
#import <ReactiveObjC.h>

@interface ViewModel ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *university;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign, getter=isLoading) BOOL load;

@property (nonatomic, strong) Model *model;

@end

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = [[Model alloc] init];

        RAC(self, name) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
            return user.name;
        }];
        RAC(self, university) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
            NSString *university = user.university;
            if (user.university.length > 3) {
                university = [university substringToIndex:3];
            }
            return university;
        }];
        RAC(self, sex) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
            return user.sex == 1 ? @"男" : @"女";
        }];
        RAC(self, load) = [RACObserve(_model, load) skip:1];
    }
    return self;
}

- (void)fetchUser
{
    [self.model fetchUser];
}

@end
