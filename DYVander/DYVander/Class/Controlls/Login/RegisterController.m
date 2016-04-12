//
//  RegisterController.m
//  ofshop
//
//  Created by 卢达洋 on 16/3/16.
//  Copyright © 2016年 oftenfull. All rights reserved.
//


#import "BmobUtil.h"
#import "RegisterController.h"
#import <BmobSDK/Bmob.h>
@interface RegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@end

@implementation RegisterController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)initView {
  //  [_registerBtn makeRoundedCorner:5];
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"注册";
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == _confirmPasswordTF) {
    [_confirmPasswordTF resignFirstResponder];
    [self registerBtnAction:_registerBtn];
  }

  if (textField == _passwordTF) {
    [_confirmPasswordTF becomeFirstResponder];
  }
  if (textField == _userNameTF) {

    [_passwordTF becomeFirstResponder];
  }
  return YES;
}

- (IBAction)registerBtnAction:(UIButton *)sender {

  BOOL cheakResult = [self inputCheak];

  if (cheakResult) {

    BmobUser *bUser = [[BmobUser alloc] init];
    bUser.username = _userNameTF.text;
    [bUser setPassword:_passwordTF.text];

    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
      if (isSuccessful) {
        [UIAlertView
                showWithTitle:@"注册成功"
                      message:@"返回登录页"
            cancelButtonTitle:@"确定"
            otherButtonTitles:nil
                     tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                       if (buttonIndex == 0) {
                         [self.navigationController
                             popViewControllerAnimated:YES];
                       }
                     }];
      } else {
        [self.view makeToast:error.description
                    duration:1
                    position:CSToastPositionCenter];
        NSLog(@"%@", error);
      }
    }];
  }
}

#pragma mark Privately Methods
- (BOOL)inputCheak {
  if ([_userNameTF.text isEqualToString:@""] ||
      [_userNameTF.text length] == 0) {
    [self.view makeToast:@"请输入用户名"
                duration:1
                position:CSToastPositionCenter];
    [_userNameTF becomeFirstResponder];
    return NO;
  }
  if ([_passwordTF.text isEqualToString:@""] ||
      [_passwordTF.text length] == 0) {
    [self.view makeToast:@"请输入密码"
                duration:1
                position:CSToastPositionCenter];
    [_passwordTF becomeFirstResponder];
    return NO;
  }
  if ([_confirmPasswordTF.text isEqualToString:@""] ||
      [_confirmPasswordTF.text length] == 0) {
    [self.view makeToast:@"请再次输入密码确认"
                duration:1
                position:CSToastPositionCenter];
    [_confirmPasswordTF becomeFirstResponder];
    return NO;
  }
  if (![_passwordTF.text isEqualToString:_confirmPasswordTF.text]) {
    [self.view makeToast:@"两次密码不一致"
                duration:1
                position:CSToastPositionCenter];
    _confirmPasswordTF.text = @"";
    [_confirmPasswordTF becomeFirstResponder];
    return NO;
  }
  return YES;
}

@end
