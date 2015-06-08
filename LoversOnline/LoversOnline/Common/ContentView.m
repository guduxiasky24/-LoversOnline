//
//  ContentView.m
//  LoversOnline
//
//  Created by 吴金林 on 15/6/6.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import "ContentView.h"
#import "FDAlertView.h"
#import "MatchingInfoController.h"

@implementation ContentView


/**
 *  取消按钮的事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)cancel:(UIButton *)sender {
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}
/**
 *  发送短信按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)sendSMS:(id)sender {
    NSLog(@"%@",self.content);
}

/**
 *  添加联系人
 *
 *  @param sender <#sender description#>
 */
- (IBAction)addContact:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    picker.peoplePickerDelegate = self;
    //[self presentModalViewController:picker animated:YES];
    [self addSubview:picker];
}

@end
