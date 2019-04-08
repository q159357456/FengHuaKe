//
//  UIButton+IndexPath.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "UIButton+IndexPath.h"

@implementation UIButton (IndexPath)


//定义关联的Key
static const char * keyIndexPath = "syindexPath";

-(NSIndexPath *)syindexPath{
    return objc_getAssociatedObject(self, keyIndexPath);
}

-(void)setSyindexPath:(NSIndexPath *)syindexPath{
    objc_setAssociatedObject(self, keyIndexPath, syindexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
