//
//  DemoConfManager.h
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 23/11/2016.
//  Copyright © 2016 XieYajie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hyphenate/Hyphenate.h>
#define KNOTIFICATION_CONFERENCE @"conference"

@class MainTabBarController;
@interface DemoConfManager : NSObject

#if DEMO_CALL == 1

@property (strong, nonatomic) MainTabBarController *mainController;

+ (instancetype)sharedManager;

- (void)createConferenceWithType:(EMCallType)aType;

#endif

@end
