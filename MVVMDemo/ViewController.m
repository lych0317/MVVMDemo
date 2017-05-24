//
//  ViewController.m
//  MVVMDemo
//
//  Created by yuanchao Li on 2017/5/24.
//  Copyright © 2017年 yuanchao Li. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) ViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ViewModel alloc] init];

    RAC(self.nameLabel, text) = RACObserve(self.viewModel, name);
    RAC(self.universityLabel, text) = RACObserve(self.viewModel, university);
    RAC(self.sexLabel, text) = RACObserve(self.viewModel, sex);
    RAC(self.loadLabel, text) = [RACObserve(self.viewModel, load) map:^id _Nullable(NSNumber *value) {
        return [value boolValue] ? @"loading" : @"normal";
    }];
}

- (IBAction)fetchDataAction:(UIButton *)sender
{
    [self.viewModel fetchUser];
}
@end
