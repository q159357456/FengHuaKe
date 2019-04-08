//
//  User.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/26.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "User.h"

@implementation User
-(NSString *)sex
{
    if (!_sex) {
        _sex=@"3";
    }
    return _sex;
}

-(NSString *)doc_type
{
    if (!_doc_type) {
        _doc_type=@"01";
    }
    return _doc_type;
}
-(NSString *)birth_date
{
    if (!_birth_date) {
        _birth_date=@"19960821";
    }
    return _birth_date;
}
@end
