//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/8.
//  Copyright © 2019 CB. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "DescriptionViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"---");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MVVM";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * buton = [UIButton buttonWithType:UIButtonTypeCustom];
    buton.frame = CGRectMake(100, 180, 200, 200);
    buton.backgroundColor = [UIColor brownColor];
    [buton setTitle:@"点击开始" forState:UIControlStateNormal];
    buton.layer.cornerRadius = 200/2.0;
    buton.layer.masksToBounds = YES;
    @weakify(self);
    [[buton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    [self.view addSubview:buton];
    
    UIButton * buton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buton2.frame = CGRectMake(50, CGRectGetMaxY(buton.frame)+30, self.view.frame.size.width-50*2, 50);
    buton2.backgroundColor = [UIColor orangeColor];
    [buton2 setTitle:@"功能描述" forState:UIControlStateNormal];
    buton2.layer.cornerRadius = 50/2.0;
    buton2.layer.masksToBounds = YES;
    [[buton2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        DescriptionViewController *loginVC = [[DescriptionViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    [self.view addSubview:buton2];
    
}







@end
