//
//  MatchingWaitingController.h
//  LoversOnline
//
//  Created by 吴金林 on 15/6/5.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FDAlertView.h"
#import "ContentView.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
@interface MatchingWaitingController : UIViewController<MFMessageComposeViewControllerDelegate,UIAlertViewDelegate,ABPeoplePickerNavigationControllerDelegate,FDAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (retain,nonatomic)UIAlertView *alert;
@property (retain,nonatomic)UIView *phoneView;
@property (retain,nonatomic)UITextField *phoneNumberInput;
@end
