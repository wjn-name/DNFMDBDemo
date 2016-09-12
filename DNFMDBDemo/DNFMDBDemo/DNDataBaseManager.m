//
//  DNDataBaseManager.m
//  DNFMDBDemo
//
//  Created by mainone on 16/9/12.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNDataBaseManager.h"
#import "FMDB.h"
#import "DNDataBaseHelper.h"

static NSString * const userTableName = @"USERTABLE";
// 如果有另一项数据需要存储,则建立另一个表和user并列创建即可
static NSString * const friendTableName = @"USERTABLE";


@implementation DNDataBaseManager

+ (DNDataBaseManager *)shareInstance {
    static DNDataBaseManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        [instance createUserTable];
    });
    return instance;
}

- (void)createUserTable {
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    if (queue == nil) { return; }
    [queue inDatabase:^(FMDatabase *db) {
        if (![DNDataBaseHelper isTableOK:userTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE USERTABLE (id integer PRIMARY KEY autoincrement, userid text,name text, portraitUrl text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_userid ON USERTABLE(userid);";
            [db executeUpdate:createIndexSQL];
        }
    }];
}

- (void)insertUserToDB:(DNUserInfo *)user {
    NSString *insertSql = @"REPLACE INTO USERTABLE (userid, name, portraitUrl) VALUES (?, ?, ?)";
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql, user.userId, user.name, user.portraitUrl];
    }];
}

- (DNUserInfo *)getUserByUserId:(NSString *)userId {
    __block DNUserInfo *model = nil;
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    if (queue == nil) { return nil; }
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM USERTABLE where userid = ?",userId];
        while ([result next]) {
            model             = [[DNUserInfo alloc] init];
            model.userId      = [result stringForColumn:@"userid"];
            model.name        = [result stringForColumn:@"name"];
            model.portraitUrl = [result stringForColumn:@"portraitUrl"];
        }
        [result close];
    }];
    return model;
}

- (NSArray *)getAllUserInfo {
    NSMutableArray *allUsers = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM USERTABLE"];
        while ([result next]) {
            DNUserInfo *model = [[DNUserInfo alloc] init];
            model.userId      = [result stringForColumn:@"userid"];
            model.name        = [result stringForColumn:@"name"];
            model.portraitUrl = [result stringForColumn:@"portraitUrl"];
            [allUsers addObject:model];
        }
        [result close];
    }];
    return allUsers;
}

- (void)deleteUserInfo:(NSString *)userId {
    NSString *deleteSql =[NSString stringWithFormat: @"DELETE FROM USERTABLE WHERE userid= %@",userId];
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    if (queue == nil) {
        return;
    }
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

- (void)deleteAllUserInfo {
    NSString *deleteSql = @"DELETE FROM USERTABLE";
    FMDatabaseQueue *queue = [DNDataBaseHelper getDatabaseQueue];
    if (queue==nil) {
        return ;
    }
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];

}

@end
