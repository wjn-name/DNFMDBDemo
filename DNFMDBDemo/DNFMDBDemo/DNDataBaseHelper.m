//
//  DNDataBaseHelper.m
//  DNFMDBDemo
//
//  Created by mainone on 16/9/12.
//  Copyright © 2016年 wjn. All rights reserved.
//


#import "DNDataBaseHelper.h"
#import "DNSecretInfo.h"

@implementation DNDataBaseHelper

+ (FMDatabaseQueue *)getDatabaseQueue {
    static FMDatabaseQueue *databaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"DBInfo%@", [DNSecretInfo readUID]]];
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    });
    return databaseQueue;
}

+ (BOOL)isTableOK:(NSString *)tableName withDB:(FMDatabase *)db {
    BOOL isOK = NO;
    FMResultSet *result = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        if (count == 0) {
            isOK = NO;
        } else {
            isOK = YES;
        }
    }
    [result close];
    return isOK;
}

@end
