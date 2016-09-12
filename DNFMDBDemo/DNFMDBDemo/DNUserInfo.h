//
//  DNUserInfo.h
//  DNFMDBDemo
//
//  Created by mainone on 16/9/12.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNUserInfo : NSObject

// 用户ID
@property(nonatomic, strong) NSString *userId;

// 用户名称
@property(nonatomic, strong) NSString *name;

// 用户头像的URL
@property(nonatomic, strong) NSString *portraitUrl;


@end
