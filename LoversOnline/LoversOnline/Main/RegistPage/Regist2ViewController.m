//
//  Regist2ViewController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/3.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "Regist2ViewController.h"

@interface Regist2ViewController ()<BZGFormFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,assign) BOOL isRead;
@property (nonatomic,assign) BOOL flag;
@property (nonatomic,assign) BOOL passFlag;
@property (nonatomic,assign) BOOL userFlag;
@property (retain,nonatomic)NSString *sex;//存放性别
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet BZGFormField *emailTextField;//邮箱输入框
@property (weak, nonatomic) IBOutlet BZGFormField *passWordTextField;//密码框
@property (weak, nonatomic) IBOutlet BZGFormField *userNameTextField;//用户名框
@property (weak, nonatomic) IBOutlet UIImageView *tickEmailImage;
@property (weak, nonatomic) IBOutlet UIImageView *tickPassImage;
@property (weak, nonatomic) IBOutlet UIImageView *tickUserImage;

@end

@implementation Regist2ViewController
/**
 *  显示navigationController
 *
 *  @param animated <#animated description#>
 */
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置性别默认为男
    self.sex=@"男";
    self.title=@"注册爱语";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(5, 10, 20, 15 )];
    [back setBackgroundImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    //判断文本是否有内容
    [self judgementTextField];
}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  打勾事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 200:
        {
            //是否阅读协议
            if (_isRead) {
                
                [btn setImage:[UIImage imageNamed:@"协议选框"] forState:UIControlStateNormal];
                _isRead = NO;
            }else{
                
                [btn setImage:[UIImage imageNamed:@"协议选框对勾"] forState:UIControlStateNormal];
                
                _isRead = YES;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 改变头像
/**
 *  点击男按钮发生的事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)changeHeadBtn:(UIButton *)sender {
    self.headImage.image=[UIImage imageNamed:@"头像男"];
    self.sex=@"男";
}

/**
 *  点击女按钮发生的事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)changeHeadGirlBtn:(UIButton *)sender {
    self.headImage.image=[UIImage imageNamed:@"头像女"];
    self.sex=@"女";
}

#pragma mark 注册事件
- (IBAction)registerBtn:(UIButton *)sender {
    //判断文本是否有内容
//    [self judgementTextField];
    
    if(!_isRead){
        _alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请勾选阅读协议选项框" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
    }else if(!_flag)
    {
        _alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的邮箱" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
    }else if(!_passFlag)
    {
        _alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
    }else if(!_userFlag)
    {
        _alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的用户名" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
    }
    else
    {
        //初始化数据库
        DbOperation *db=[DbOperation new];
        //数据库 插入
        UserModel *userList=[UserModel new];
        userList.userName=self.userNameTextField.textField.text;
        userList.userEmail=self.emailTextField.textField.text;
        userList.userPassword=self.passWordTextField.textField.text;
        userList.userSex=self.sex;
        userList.userHead=@"路径";
        if([db insertUserList:userList])
        {
            NSLog(@"插入数据成功!");
            //设置故事板为第一启动
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MatchingInfoController *matchingInfo=[storyboard instantiateViewControllerWithIdentifier:@"匹配信息Controller"];
            [self.navigationController pushViewController:matchingInfo animated:YES];
        }else
        {
            NSLog(@"插入数据失败!");
        }
    }
    
}
#pragma mark 判断文本框是否有内容
-(void)judgementTextField{
    /*邮箱*/
    self.emailTextField.textField.placeholder=@"请输入您的邮箱";
    __weak Regist2ViewController *weakSelf=self;
    [self.emailTextField setTextValidationBlock:^BOOL(NSString *text) {
        // from https://github.com/benmcredmond/DHValidation/blob/master/DHValidation.m
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:text]&&text.length>0) {
            weakSelf.emailTextField.alertView.title = @"请输入正确的邮箱";
            return NO;
            _flag=NO;
        } else  {
            _flag=YES;
            return YES;
        }
    }];
    self.emailTextField.delegate = self;
    /*密码*/
    self.passWordTextField.textField.placeholder = @"请输入不小于8位的密码";
    self.passWordTextField.textField.secureTextEntry = YES;
    [self.passWordTextField setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length < 8) {
            weakSelf.passWordTextField.alertView.title = @"密码太短";
            self.passFlag=NO;
            return NO;
        } else {
            self.passFlag=YES;
            return YES;
        }
    }];
    self.passWordTextField.delegate = self;
    /*用户名*/
    self.userNameTextField.textField.placeholder=@"请输入您的用户名";
    [self.userNameTextField setTextValidationBlock:^BOOL(NSString *text) {
        if(text.length<=0){
            weakSelf.userNameTextField.alertView.title=@"请输入您的用户名";
            self.userFlag=NO;
            return NO;
        }else {
            self.userFlag=YES;
            return YES;
        }
    }];
    self.userNameTextField.delegate=self;
    
}
#pragma mark - BZGFormFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end
