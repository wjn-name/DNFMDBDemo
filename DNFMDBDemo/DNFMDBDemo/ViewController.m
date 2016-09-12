//
//  ViewController.m
//  DNFMDBDemo
//
//  Created by mainone on 16/9/9.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ViewController.h"
#import "DNDataBaseManager.h"
#import "DNSecretInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 先确定是哪一个用户要建的数据库
    [DNSecretInfo saveUserID:@"1002"];
    
    // 设置要存入的用户信息
    
    for (NSInteger i = 0; i < 10; i++) {
        DNUserInfo *model = [[DNUserInfo alloc] init];
        model.userId      = [NSString stringWithFormat:@"%d",(int)i + 1000];
        model.name        = @"张三";
        model.portraitUrl = @"http://pic14.nipic.com/20110610/7181928_110502231129_2.jpg";
        
        // 存入用户信息
        [[DNDataBaseManager shareInstance] insertUserToDB:model];
    }
    
    
    // 后去所有用户信息
    NSLog(@"%@",[[DNDataBaseManager shareInstance] getAllUserInfo]);
    
    // 删除id是1002的用户信息
    [[DNDataBaseManager shareInstance] deleteUserInfo:@"1002"];
    
    //获取用户Id是1003的用户信息
    NSLog(@"%@",[[DNDataBaseManager shareInstance] getUserByUserId:@"1003"]);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
