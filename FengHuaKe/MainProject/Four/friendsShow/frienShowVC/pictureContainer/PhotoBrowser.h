//
//  PhotoBrowser.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/8.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowserConfig.h"
@class PhotoBrowser;
@protocol PhotoBrowserDelegate <NSObject>
@required
- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
@optional
- (NSURL *)photoBrowser:(PhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;
@end
@interface PhotoBrowser : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, weak) id<PhotoBrowserDelegate> delegate;

- (void)show;
@end
