//
//  LoginViewController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/2.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController
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
//    /*邮箱注册*/
//    //添加手势
//     UITapGestureRecognizer *tapGestureEmail=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
//      [self.emailLoginView addGestureRecognizer:tapGestureEmail];
//    //设置viewtag值
//     self.emailLoginView.tag=100;
//    //设置圆角
//    [self.emailLoginView.layer setCornerRadius:5.0];
//    /*QQ注册*/
//    //添加手势
//    UITapGestureRecognizer *tapGestureQQ=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
//    [self.qqLoginView addGestureRecognizer:tapGestureQQ];
//    //设置圆角
//    [self.qqLoginView.layer setCornerRadius:5.0];
//    //设置viewtag值
//    self.qqLoginView.tag=101;
//    /*新浪微博注册*/
//    UITapGestureRecognizer *tapGestureSina=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
//    [self.sinaLoginView addGestureRecognizer:tapGestureSina];
//    //设置圆角
//    [self.sinaLoginView.layer setCornerRadius:5.0];
//    //设置viewtag值
//    self.sinaLoginView.tag=102;
    
    /*导航控制器*/
    self.title=@"登录爱语";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(5, 10, 25, 20 )];
    [back setBackgroundImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
}

-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)event:(UITapGestureRecognizer *)sender
{
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)sender;
    NSLog(@"%ld",(long)[tap view].tag);
    if([tap view].tag==100)
    {
        NSLog(@"邮箱注册");
    }
    if([tap view].tag==101)
    {
        NSLog(@"QQ注册");
    }
    if([tap view].tag==102)
    {
        NSLog(@"新浪注册");
    }
}
@end
