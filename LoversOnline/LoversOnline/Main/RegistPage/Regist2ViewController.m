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
    [back setFrame:CGRectMake(5, 10, 25, 20 )];
    [back setBackgroundImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;

    
    
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
 *  注册按钮事件
 *
 *  @param sender <#sender description#>
 */
-(void)regist:(UIButton *)sender{
    NSLog(@"注册");
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

@end
