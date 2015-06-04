//
//  NewFeatureViewController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/2.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "Regist1ViewController.h"
#import "LoginViewController.h"
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//图片数量
#define NewfeatureCount 4
@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, retain) MyPageControl *pageControl;
@property (nonatomic, retain) UIScrollView *scrollView;
@end

@implementation NewFeatureViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个scrollview:显示所有的新特性图片
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,-20, kScreenWidth, kScreenHeight+20)];
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    //2.添加图片到scrollview中
    for (int i=0; i<NewfeatureCount; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight+20)];
        //显示图片
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"New_%i.png",i]];
        [scrollView addSubview:imageView];
        if(i==NewfeatureCount-1)
        {
            [self setupLastImageView:imageView];
        }
    }
    //3.设置scrollview其它属性
    //如果想要某个方向不能滚动，那么这个方向对应的数值设置为0
    scrollView.contentSize=CGSizeMake(NewfeatureCount*kScreenWidth, 0);
    //去除弹簧效果
    scrollView.bounces=NO;
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    //水平滚动
    scrollView.showsHorizontalScrollIndicator=NO;
    //4.添加pageControl:分页，展示目前看的是第几页
    MyPageControl *pageControl=[[MyPageControl alloc]initWithFrame:CGRectMake(scrollView.center.x*0.7, scrollView.frame.size.height-100, 120, 18)];
    pageControl.userInteractionEnabled=NO;
    pageControl.numberOfPages=NewfeatureCount;
    pageControl.currentPage=0;
    pageControl.indicatorDiameter=10.0f;
    //设置间距
    pageControl.indicatorMargin=10.0f;
    //缩放
    pageControl.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    [pageControl setPageIndicatorImage:[UIImage imageNamed:@"预显钮.png"]];
    [pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"当前钮.png"]];
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
}
#pragma mark吃 初始化最后一个imageView
/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    //登陆按钮
    UIButton *loginBtn=[[UIButton alloc]init];
    loginBtn.frame=CGRectMake(self.view.frame.origin.x+20, self.scrollView.frame.size.height-70, kScreenWidth*0.4, 40);
    [loginBtn setImage:[UIImage imageNamed:@"登录2.png"] forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"登录3.png"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:loginBtn];
    
    //注册按钮
    UIButton *regitBtn=[[UIButton alloc]init];
    regitBtn.frame=CGRectMake(kScreenWidth-(loginBtn.frame.size.width+loginBtn.frame.origin.x), self.scrollView.frame.size.height-70, kScreenWidth*0.4, 40);
    [regitBtn setImage:[UIImage imageNamed:@"注册2.png"] forState:UIControlStateNormal];
    [regitBtn setImage:[UIImage imageNamed:@"注册3.png"] forState:UIControlStateHighlighted];
    [regitBtn addTarget:self action:@selector(regit:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:regitBtn];
}
#pragma mark 登陆
/**
 *  登陆事件
 *
 *  @param sender <#sender description#>
 */
-(void)login:(UIButton *)sender
{
    //设置故事板为第一启动
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *login=[storyboard instantiateViewControllerWithIdentifier:@"登录爱语Controller"];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark  注册
/**
 *  注册点击事件
 *
 *  @param sender <#sender description#>
 */
-(void)regit:(UIButton *)sender
{
    //设置故事板为第一启动
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Regist1ViewController *r1=[storyboard instantiateViewControllerWithIdentifier:@"注册爱语Controller"];
    [self.navigationController pushViewController:r1 animated:YES];
}
@end
