//
//  LoginController.m
//  ofshop
//
//  Created by 卢达洋 on 16/3/16.
//  Copyright © 2016年 oftenfull. All rights reserved.
//


#import "BmobUtil.h"
#import "FindpasswordController.h"
#import "LoginController.h"
#import "Master.h"
#import "RegisterController.h"
#import <BmobSDK/Bmob.h>

@interface LoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton    *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton    *findPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@end

@implementation LoginController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
//  NSLog(@"%@", [BmobUser getCurrentUser]);
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.tabBarController.tabBar setHidden:NO];
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"登录";
}

- (void)initView {
//  [_LoginBtn makeRoundedCorner:5];
}

- (void)initData {
  _userNameTF.text = [[Global sharedSingleton]
      getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME];
  _passWordTF.text = [[Global sharedSingleton]
      getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == _passWordTF) {
    [_passWordTF resignFirstResponder];
    [self loginBtnAction:_LoginBtn];
  }
  if (textField == _userNameTF) {
    [_passWordTF becomeFirstResponder];
  }

  return YES;
}

#pragma mark ButtonAction

- (IBAction)registerBtnAction:(UIButton *)sender {

  RegisterController *vc =
      [[RegisterController alloc] initWithNibName:@"RegisterController"
                                           bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)findPasswordBtnAction:(UIButton *)sender {

  [self.view makeToast:@"忘记密码请联系卢达洋"
              duration:1
              position:CSToastPositionCenter];
  return;
//  FindpasswordController *vc =
//      [[FindpasswordController alloc] initWithNibName:@"FindpasswordController"
//                                               bundle:nil];
//  [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginBtnAction:(UIButton *)sender {
  if (![self inputCheak]) {
    return;
  }
  
  [BmobUser loginWithUsernameInBackground:_userNameTF.text password:_passWordTF.text block:^(BmobUser *user, NSError *error) {
    if (!error) {
      
      [[Global sharedSingleton]
       setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME
       andValue:_userNameTF.text];
      [[Global sharedSingleton]
       setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD
       andValue:_passWordTF.text];
      
      Master *vc = [[Master alloc] init];
      [self presentViewController:vc animated:YES completion:nil];
      
    }else{
      [self.view makeToast:error.description
                  duration:1
                  position:CSToastPositionCenter];
      [[Global sharedSingleton]
       delUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD];
      _passWordTF.text = @"";
    }
    
    
  }];
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
  if ([_passWordTF.text isEqualToString:@""] ||
      [_passWordTF.text length] == 0) {
    [self.view makeToast:@"请输入密码"
                duration:1
                position:CSToastPositionCenter];
    [_passWordTF becomeFirstResponder];
    return NO;
  }

  return YES;
}

- (BOOL)loginVerificationWithUserName:(NSString *)userName
                             Password:(NSString *)password {
  if (userName) {
    BOOL isExist;
    NSDictionary *diction =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"OFUserNames"];
    if (diction) {
      for (NSString *user in [diction allKeys]) {
        if ([user isEqualToString:userName]) {
          isExist = YES;
        }
      }
    } else {
      [self.view makeToast:@"该用户尚未注册"
                  duration:1
                  position:CSToastPositionCenter];
    }
    if (isExist) {
      if ([[diction objectForKey:userName] isEqualToString:password]) {
        return YES;
      } else {
        [self.view makeToast:@"密码错误"
                    duration:1
                    position:CSToastPositionCenter];
        [_passWordTF becomeFirstResponder];
      }

    } else {
      [self.view makeToast:@"该用户尚未注册"
                  duration:1
                  position:CSToastPositionCenter];
      return NO;
    }
  }

  return NO;
}

@end
