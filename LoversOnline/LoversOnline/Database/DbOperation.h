//
//  DbOperation.h
//  LoversOnline
//
//  Created by 吴金林 on 15/6/5.
//  Copyright (c) 2015年 winainfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UserModel.h"
@interface DbOperation : NSObject
@property (nonatomic)sqlite3 *database;
-(BOOL)openDB;//创建，打开数据库
-(BOOL)createDataList:(sqlite3 *)db;//创建数据库
-(BOOL)insertUserList:(UserModel *)insertList;//插入数据
-(BOOL)updateUserList:(UserModel *)updateList andBid:(int)userid;//更新数据
-(BOOL)deleteUserList:(int)bid;//删除数据
-(NSString *)selectUserName:(NSString *)userName;//查询用户名是否存在
-(NSArray *)getUserList;//获取全部数据
//-(NSMutableArray *)searchBookList:(NSString *)searchName;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(NSArray *)getIdList:(int)bid;//根据id获取数据
-(NSArray *)searchUserList:(NSString *)searchaName andPas:(NSString *)searchPassword;
@end
