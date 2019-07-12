//
//  WechatManager.h
//  FengHuaKe
//
//  Created by chenheng on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WeChatManagerDelegate

-(void) wechatLoginSuccessWithDictionary:(NSDictionary *)dic;

/**拉起微信登录成功回调code*/
-(void)wechatLoginWithCode:(NSString*)code;
/**拉起微信登录失败回调*/
-(void)wechatLoginError;
@end
@interface WechatManager : NSObject
@property(nonatomic,assign) id delegate;
+(instancetype) sharedManager;
@end

NS_ASSUME_NONNULL_END
