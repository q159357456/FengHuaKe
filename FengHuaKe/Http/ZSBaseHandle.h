//
//  ZSBaseHandle.h
//  PlayVR
//
//  Created by 赵升 on 2016/10/14.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSBaseHandle : NSObject

/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)();

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);




@end
