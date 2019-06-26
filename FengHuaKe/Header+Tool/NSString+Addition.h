//
//  NSString+Addition.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/5.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)
-(NSString *)URLEncodedString;
-(NSMutableAttributedString*)Color:(UIColor*)color ColorRange:(NSRange)range Font:(UIFont*)font FontRange:(NSRange)fontRange;
- (NSDictionary *)toDictionary;
@end
