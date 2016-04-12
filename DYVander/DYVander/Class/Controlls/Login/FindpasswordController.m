//
//  FindpasswordController.m
//  ofshop
//
//  Created by 卢达洋 on 16/3/16.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "FindpasswordController.h"

@interface FindpasswordController ()<UITextFieldDelegate> {
  __block int timeout; //倒计时时间
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *VerifyCodeTF;
@property (weak, nonatomic) IBOutlet UIButton    *VerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton    *CommitBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (copy, nonatomic) NSString *verifyCode;
@end

@implementation FindpasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
//  [_CommitBtn makeRoundedCorner:5];
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"忘记密码";
}

- (IBAction)getVerifyCode:(UIButton *)sender {
  _verifyCode = [NSString stringWithFormat:@"%d",arc4random()%1000000];
  [self.view makeToast:_verifyCode duration:2 position:CSToastPositionCenter];
  _VerifyCodeBtn.enabled = NO;
  [self startTime];
}

- (IBAction)commit:(UIButton *)sender {
  NSDictionary *diction =[[NSUserDefaults standardUserDefaults] objectForKey:@"OFUserNames"];
  if (![diction objectForKey:_userNameTF.text]) {
    [self.view makeToast:@"该用户不存在" duration:1 position:CSToastPositionCenter];
    [_userNameTF becomeFirstResponder];
    return;
  }
  
  if ([self inputCheak]) {
    if (!diction) {
      diction =[NSDictionary new];
    }
    NSMutableArray *newDiction = [diction mutableCopy];
    [newDiction setValue:_confirmPasswordTF.text forKey:_userNameTF.text];
    [[Global sharedSingleton]delUserDefaultsWithKey:@"OFUserNames"];
    [[Global sharedSingleton]setUserDefaultsWithKey:@"OFUserNames" andValue:newDiction];
    [UIAlertView showWithTitle:@"重置成功" message:@"返回登录页" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
      if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
      }
    }];
  }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  if (textField == _confirmPasswordTF) {
    [_confirmPasswordTF resignFirstResponder];
    [self commit:nil];
  }
  
  if (textField == _passwordTF) {
    [_confirmPasswordTF becomeFirstResponder];
  }
  if (textField == _userNameTF) {
    
    [_VerifyCodeTF becomeFirstResponder];
  }
  if (textField == _VerifyCodeTF) {
    
    [_passwordTF becomeFirstResponder];
  }
  return YES;
}

#pragma mark Privately Methods
-(BOOL)inputCheak{
  if ([_userNameTF.text isEqualToString:@""] || [_userNameTF.text length]==0) {
    [self.view makeToast:@"请输入用户名" duration:1 position:CSToastPositionCenter];
    [_userNameTF becomeFirstResponder];
    return NO;
  }
  if ([_passwordTF.text isEqualToString:@""] || [_passwordTF.text length]==0) {
    [self.view makeToast:@"请输入密码" duration:1 position:CSToastPositionCenter];
    [_passwordTF becomeFirstResponder];
    return NO;
  }
  if ([_confirmPasswordTF.text isEqualToString:@""] || [_confirmPasswordTF.text length]==0) {
    [self.view makeToast:@"请再次输入密码确认" duration:1 position:CSToastPositionCenter];
    [_confirmPasswordTF becomeFirstResponder];
    return NO;
  }
  if (![_passwordTF.text isEqualToString:_confirmPasswordTF.text]) {
    [self.view makeToast:@"两次密码不一致" duration:1 position:CSToastPositionCenter];
    _confirmPasswordTF.text = @"";
    [_confirmPasswordTF becomeFirstResponder];
    return NO;
  }
  if (![_VerifyCodeTF.text isEqualToString:_verifyCode]) {
    [self.view makeToast:@"验证码不正确" duration:1 position:CSToastPositionCenter];
    [_VerifyCodeTF becomeFirstResponder];
    return NO;
  }
  return YES;
}

- (void)startTime {
  //  __block int timeout = 60; //倒计时时间
  timeout = 60;
  dispatch_queue_t queue =
  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t _timer =
  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),
                            1.0 * NSEC_PER_SEC, 0); //每秒执行
  dispatch_source_set_event_handler(_timer, ^{
    if (timeout <= 0) { //倒计时结束，关闭
      dispatch_source_cancel(_timer);
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        [_VerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _VerifyCodeBtn.userInteractionEnabled = YES;
        _VerifyCodeBtn.enabled = YES;
      });
    } else {
      //            int minutes = timeout / 60;
      //      _VerifyCodeBtn.enabled = NO;
      int seconds = timeout % 61;
      NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        [_VerifyCodeBtn setTitle:[NSString stringWithFormat:@"%@秒", strTime]
                        forState:UIControlStateNormal];
        //        _VerifyCodeBtn.userInteractionEnabled = NO;
        
      });
      timeout--;
    }
  });
  dispatch_resume(_timer);
}

@end
