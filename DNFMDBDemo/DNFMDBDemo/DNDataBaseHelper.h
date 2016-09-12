//
//  DNDataBaseHelper.h
//  DNFMDBDemo
//
//  Created by mainone on 16/9/12.
//  Copyright © 2016年 wjn. All rights reserved.
//

// FMDB https://github.com/ccgus/fmdb

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DNDataBaseHelper : NSObject

+ (FMDatabaseQueue *)getDatabaseQueue;

/**
 *  判断表是否存在
 *
 *  @param tableName 表名
 *  @param db        数据库
 *
 *  @return YES存在,NO不存在
 */
+ (BOOL)isTableOK:(NSString *)tableName withDB:(FMDatabase *)db;

@end
