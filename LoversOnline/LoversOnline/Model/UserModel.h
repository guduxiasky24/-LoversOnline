//
//  UserModel.h
//  LoversOnline
//
//  Created by 吴金林 on 15/6/5.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (assign,nonatomic)int UserId;//用户id
@property (retain,nonatomic)NSString *userName;//用户名
@property (retain,nonatomic)NSString *userEmail;//用户邮箱
@property (retain,nonatomic)NSString *userPassword;//用户密码
@property (retain,nonatomic)NSString *userHead;//用户头像
@property (retain,nonatomic)NSString *userSex;//用户性别
@end
