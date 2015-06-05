//
//  Regist2ViewController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/3.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "Regist2ViewController.h"

@interface Regist2ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (assign,nonatomic)BOOL flage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;//邮箱输入框
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;//密码框
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;//用户名框
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
    self.flage=NO;
    [super viewDidLoad];
    
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
    if (self.flage==NO) {
        UIImage *img=[UIImage imageNamed:@"协议选框对勾"];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
        imageView.image=img;
        [self.btn addSubview:imageView];
        self.flage=YES;
        NSLog(@"错");
    }
    if (self.flage==YES) {
        NSLog(@"对");
        self.flage=NO;
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
}

/**
 *  点击女按钮发生的事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)changeHeadGirlBtn:(UIButton *)sender {
    self.headImage.image=[UIImage imageNamed:@"头像女"];
}

#pragma mark 注册事件
- (IBAction)registerBtn:(UIButton *)sender {
    //判断文本是否有内容
    [self judgementTextField];
}

#pragma mark 判断文本框是否有内容
-(void)judgementTextField{
    if (_emailTextField.text.length>0) {
        _tickEmailImage.image=[UIImage imageNamed:@"对勾"];
    }
}

- (IBAction)EmailChanged:(id)sender {
    if (_emailTextField.text.length==0) {
        _tickEmailImage.image=[UIImage imageNamed:@"错"];
    }else
    {
     _tickEmailImage.image=[UIImage imageNamed:@"对勾"];
    }
}

@end
