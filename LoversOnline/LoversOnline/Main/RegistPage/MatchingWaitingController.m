//
//  MatchingWaitingController.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/5.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "MatchingWaitingController.h"
#import "ContentViewController.h"
//获得当前屏幕宽高点数（非像素）

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface MatchingWaitingController ()
@end

@implementation MatchingWaitingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  通知事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)smsMessageBtn:(UIButton *)sender {
    
    self.alert=[[UIAlertView alloc]initWithTitle:@"手机号码" message:@"请输入手机号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
    //创建一个Uiview 把text喝button放在uivew上
    self.phoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,230, 30)];
    self.phoneNumberInput=[[UITextField alloc]initWithFrame:CGRectMake(10, 0,220, 25)];
    self.phoneNumberInput.borderStyle=UITextBorderStyleRoundedRect;
    self.phoneNumberInput.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.phoneNumberInput.keyboardType=UIKeyboardTypeNumberPad;
    [self.phoneView addSubview:self.phoneNumberInput];
    //添加联系人按钮
    UIButton *addContactBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    addContactBtn.frame=CGRectMake(self.phoneNumberInput.frame.origin.x+self.phoneNumberInput.frame.size.width+5, 2, 20, 20);
    [addContactBtn addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneView addSubview:addContactBtn];
    //check if os version is 7 or above
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [self.alert setValue:self.phoneView forKey:@"accessoryView"];
    }else{
        [self.alert addSubview:self.phoneView];
    }
    [self.alert show];
}
#pragma mark实现alertView代理
/**
 *  alertView代理事件
 *
 *  @param alertView   <#alertView description#>
 *  @param buttonIndex <#buttonIndex description#>
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    //UITextField *phoneText=[alertView textFieldAtIndex:0];
    NSString *phone=self.phoneNumberInput.text;
    NSString *body = self.codeLabel.text;//内容
    NSArray *phoneArray=[NSArray arrayWithObjects:phone, nil];
    if (buttonIndex==1) {
        [self showMessageView:phoneArray title:@"邀请码" body:body];
//        if(phoneText.text.length!=11)
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"您输入的号码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }else
//        {
//            [self showMessageView:phoneArray title:@"邀请码" body:body];
//        }
    }else if (buttonIndex==0)
    {
        [self.alert dismissWithClickedButtonIndex:0 animated:YES];
    }
}

-(void)addContact:(UIButton *)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    picker.peoplePickerDelegate = self;
    //隐藏UIAlertView
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark 实现短信代理方法
/**
 *  短信状态
 *
 *  @param controller <#controller description#>
 *  @param result     <#result description#>
 */
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}
/**
 *  发生短信
 *
 *  @param phones 发短信的手机号码的数组，数组中是一个即单发,多个即群发。
 *  @param title  <#title description#>
 *  @param body   内容
 */
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark实现通讯录的代理
- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
   // [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

/**
 *   选中某一个联系人的某一个属性时就会调用 --IOS7
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 *  @param property     <#property description#>
 *  @param identifier   <#identifier description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
    if ([self.phoneNumberInput.text length] == 0) {
        self.phoneNumberInput.text = phone;
    } else {
        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", self.phoneNumberInput.text, phone];
        NSLog(@"%@", fullNumbers);
        self.phoneNumberInput.text = fullNumbers;
    }
    
    
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.alert show];
    return NO;
}

/**
 *  选中某一个联系人的某一个属性时就会调用 --IOS8
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 *  @param property     <#property description#>
 *  @param identifier   <#identifier description#>
 */
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
    //retrieve first and last name
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"retrieved first name: %@", firstName);
    NSLog(@"retrieve last name: %@", lastName);
    
    
    if ([self.phoneNumberInput.text length] == 0) {
        self.phoneNumberInput.text = phone;
    } else {
        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", self.phoneNumberInput.text, phone];
        NSLog(@"%@", fullNumbers);
        self.phoneNumberInput.text = fullNumbers;
    }
    
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.alert show];
}
@end
