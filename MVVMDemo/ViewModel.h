//
//  ViewModel.h
//  MVVMDemo
//
//  Created by yuanchao Li on 2017/5/24.
//  Copyright © 2017年 yuanchao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *university;
@property (nonatomic, copy, readonly) NSString *sex;
@property (nonatomic, assign, readonly, getter=isLoading) BOOL load;

- (void)fetchUser;

@end
