//
//  LoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/9.
//  Copyright © 2019 CB. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginSuccessViewController.h"
#import "DescriptionViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginView *loginView;

@property (nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation LoginViewController

- (void)dealloc {
    NSLog(@"---LoginViewController--dealloc---");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"功能描述" style:UIBarButtonItemStylePlain target:self action:@selector(descriptionAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    _loginView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_loginView];
    
    _loginVM = [[LoginViewModel alloc] init];
    
    [self.loginView showConfigView:self.loginVM];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self);
    // 登录状态 绑定
    RAC(self.navigationItem, title) = self.loginVM.loginStatusSubject;
    // 登录状态 监听
    [[RACObserve(self.loginVM, isLogin) skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if (x.integerValue == 1) {
            LoginSuccessViewController *aVC = [[LoginSuccessViewController alloc] init];
            aVC.accountStr = self.loginVM.accountStr;
            [self.navigationController pushViewController:aVC animated:YES];
            return;
        }else {
            NSLog(@"--登录失败--");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.loginView.accountTextField resignFirstResponder];
    [self.loginView.passwordTextField resignFirstResponder];
}

- (void)descriptionAction {
    DescriptionViewController *desVC = [[DescriptionViewController alloc] init];
    [self.navigationController pushViewController:desVC animated:YES];
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
