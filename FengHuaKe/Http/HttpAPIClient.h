//
//  HttpAPIClient.h
//  MeetPet
//
//  Created by 张春 on 16/10/19.
//  Copyright © 2016年 张春. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
