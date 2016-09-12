# DNFMDBDemo
本地存储之FMDB使用

前面我们介绍了几种数据本地化存储的方法,都各有优劣,这次介绍的是iOS中常用的第三方本地存储[FMDB](https://github.com/ccgus/fmdb)的使用

在这里我们依旧以存储个人信息为例

###FMDB用法
在这里我对FMDB进行了封装,在存储信息的时候通过单利使用

####封装后的主要接口

1.添加和更新用户信息

    - (void)insertUserToDB:(DNUserInfo *)user;

2.获取单个用户的信息

    - (DNUserInfo *)getUserByUserId:(NSString *)userId;

3.获取所有用户信息

    - (NSArray *)getAllUserInfo;

4.删除单个用户信息

    - (void)deleteUserInfo:(NSString *)userId;

5.删除所有用户信息

    - (void)deleteAllUserInfo;


###主要思想

建表以用户ID为标准建立不同的数据库,实现一个用户管理一个数据库,一个数据库可以建立多个表实现不同类型数据的存储,
目前只添加用户信息表,如果想增加诸如好友,文章本地收藏,列表数据库存储之类的功能都可在DNDataBaseManager文件中建立与用户信息并列的表,
即在createUserTable方法中增加if并列语句添加多个表.写法和usertable类似即可

具体用法和实现可查看demo











