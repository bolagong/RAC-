//
//  LoginSuccessViewController.m
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/9.
//  Copyright © 2019 CB. All rights reserved.
//

#import "LoginSuccessViewController.h"
#import "CBViewModel.h"
#import "CBView.h"


@interface LoginSuccessViewController ()

@property (nonatomic,strong) CBViewModel *aViewModel;
@property (nonatomic,strong) CBView *aView;

@end


@implementation LoginSuccessViewController

- (void)dealloc {
    NSLog(@"---LoginSuccessViewController--dealloc---");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的信息页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // creat view
    _aView = [[CBView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_aView];
    
    // creat viewModel
    _aViewModel = [[CBViewModel alloc] init];
    
    // viewModel get data (example requests the data)
    [self.aViewModel getModelDataAction];
    
    // give the data to the view
    [self.aView showView:_aViewModel];
    
    // 执行信号
    [self.aViewModel loadDataAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
