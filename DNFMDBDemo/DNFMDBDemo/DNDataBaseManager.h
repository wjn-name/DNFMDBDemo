//
//  DNDataBaseManager.h
//  DNFMDBDemo
//
//  Created by mainone on 16/9/12.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNUserInfo.h"

@interface DNDataBaseManager : NSObject

+(DNDataBaseManager *)shareInstance;

/**
 *  存入用户信息
 *
 *  @param user 用户信息Model
 */
- (void)insertUserToDB:(DNUserInfo *)user;

/**
 *  获取用户信息
 *
 *  @param userId 用户ID
 *
 *  @return 该ID用户的全部信息
 */
- (DNUserInfo *)getUserByUserId:(NSString *)userId;

/**
 *  获取全部用户信息
 *
 *  @return 全部用户信息
 */
- (NSArray *)getAllUserInfo;

/**
 *  删除某个ID的用户信息
 *
 *  @param userId 用户ID
 */
- (void)deleteUserInfo:(NSString *)userId;

/**
 *  删除表中所有信息
 */
- (void)deleteAllUserInfo;

@end
