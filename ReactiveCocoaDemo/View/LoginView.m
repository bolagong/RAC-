//
//  LoginView.m
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/8.
//  Copyright © 2019 CB. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)dealloc {
    NSLog(@"---LoginView--dealloc---");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout {
    
    CGSize aSize = self.frame.size;
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((aSize.width-100)/2, 100, 100, 100)];
    _headImageView.backgroundColor = [UIColor whiteColor];
    _headImageView.layer.cornerRadius = 6;
    _headImageView.layer.masksToBounds = YES;
    [self addSubview:_headImageView];
    
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake((aSize.width-200)/2, CGRectGetMaxY(_headImageView.frame)+40, 200, 30)];
    _accountTextField.backgroundColor = [UIColor whiteColor];
    _accountTextField.placeholder = @"请输入账号";
    [self addSubview:_accountTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((aSize.width-200)/2, CGRectGetMaxY(_accountTextField.frame)+20, 200, 30)];
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"请输入密码";
    [self addSubview:_passwordTextField];
    
    _loginButon = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButon.frame = CGRectMake(90, CGRectGetMaxY(_passwordTextField.frame)+40, aSize.width-90*2, 50);
    _loginButon.backgroundColor = [UIColor blueColor];
    [_loginButon setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButon setTitle:@"登 录" forState:UIControlStateHighlighted];
    _loginButon.layer.cornerRadius = 50/2.0;
    _loginButon.layer.masksToBounds = YES;
    [self addSubview:_loginButon];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicatorView.frame = CGRectMake((aSize.width-50)/2.0, CGRectGetMaxY(_passwordTextField.frame)+10, 50, 50);
    _indicatorView.color = [UIColor cyanColor];
    _indicatorView.layer.cornerRadius = 4.0;
    _indicatorView.layer.masksToBounds = YES;
    _indicatorView.hidesWhenStopped = YES;
    [self addSubview:_indicatorView];
}

- (void)showConfigView:(LoginViewModel *)loginVM {
    
    self.loginVM = loginVM;
    
    [self bindViewModel];
}

- (void)bindViewModel {
    
    
    // 监听TextField输入信号
    RAC(self.loginVM,accountStr) = self.accountTextField.rac_textSignal;
    RAC(self.loginVM,passwordStr) = self.passwordTextField.rac_textSignal;
    
    
    //头像，订阅信号
    @weakify(self)
    [RACObserve(self.loginVM, iconUrlStr) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.headImageView.image = [UIImage imageNamed:x];
    }];
    
    
    // 监听登录按钮的高亮是否可点击
    RAC(self.loginButon, enabled) = self.loginVM.loginEnableSignal;
    // 登录按钮 监听
    [self.loginVM.loginEnableSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        UIColor *bgColor = (x.integerValue == 1) ? [UIColor blueColor] : [UIColor lightGrayColor];
        self.loginButon.backgroundColor = bgColor;
    }];
    
    
    // 监听按钮点击事件
    [[self.loginButon rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.accountTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        
        // 执行
        [self.loginVM.loginCommand execute:@"点击了登录"];
    }];
    
    
    // 监听 加载菊花 是否显示
    [[RACObserve(self.loginVM, indicatorHidden) skip:1] subscribeNext:^(NSNumber * x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (x.integerValue == 0) {
                [self.indicatorView stopAnimating];
            }else {
                [self.indicatorView startAnimating];
            }
        });
    }];
    
}



//返回当前视图的控制器
- (UIViewController *)cb_superVC {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return [UIViewController new];
}


@end
