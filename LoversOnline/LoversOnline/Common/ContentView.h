//
//  ContentView.h
//  LoversOnline
//
//  Created by 吴金林 on 15/6/6.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
@interface ContentView : UIView<ABPeoplePickerNavigationControllerDelegate>
@property (retain,nonatomic)NSString *content;//内容
@end
