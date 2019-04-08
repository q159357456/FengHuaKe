//
//  JsonTools.h
//  Reservation ordering
//
//  Created by 张帆 on 16/8/9.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonTools : NSObject

+(NSDictionary *)getData:(NSData *)data;

+(NSString *)getNSString:(NSData *)data;
@end
