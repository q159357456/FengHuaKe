//
//  GuidApplyAddPicView.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/14.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GuidApplyAddPicView.h"
#import "DataProcess.h"
@interface GuidApplyAddPicView()
@end
@implementation GuidApplyAddPicView
-(instancetype)initWithFrame:(CGRect)frame Num:(NSInteger)num
{
    if (self = [super initWithFrame:frame]) {
        
        for (NSInteger i=0; i<num; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.tag = i + 1;
            CGFloat temp = WIDTH_PRO(60);
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(temp, temp));
                make.left.mas_equalTo(self.label.mas_right).offset(10+i*(temp+10));
                
            }];
            [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.imageArray = [NSMutableArray array];
    }
    return self;
}
-(void)addPic:(UIButton*)sender{
    NSLog(@"选择图片");
    MJWeakSelf;
    [[DataProcess shareInstance] choosePhotoWithBlock:^(UIImage *image) {
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        UIImage * newImag = [self compressImageQuality:image toByte:1024*100];
        if (sender.tag == 1) {
            if (weakSelf.imageArray.count >= 1)
            {
                 [weakSelf.imageArray replaceObjectAtIndex:0 withObject:newImag];
            }else
            {
               
                [weakSelf.imageArray insertObject:newImag atIndex:0];
            }
          
        }else
        {
            if (weakSelf.imageArray.count>=2)
            {
                 [weakSelf.imageArray replaceObjectAtIndex:1 withObject:newImag];
            }else
            {
                 [weakSelf.imageArray insertObject:newImag atIndex:1];
            }
           
        }
    }];
    
}
//压缩图片
- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    NSLog(@"data.length===>%ld",data.length);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    while (data.length >= maxLength) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
//    NSLog(@"data.length===>%ld",data.length);
    UIImage *resultImage = [UIImage imageWithData:data];
//    CGFloat cgImageBytesPerRow = CGImageGetBytesPerRow(resultImage.CGImage); // 2560
//    CGFloat cgImageHeight = CGImageGetHeight(resultImage.CGImage); // 1137
//    NSUInteger size  = cgImageHeight * cgImageBytesPerRow;
//    NSLog(@"size===>%ld",size);
    return resultImage;
}

-(void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    for (NSInteger i =0; i<imageArray.count; i++) {
        UIButton * btn = [self viewWithTag:i+1];
        UIImage * image = _imageArray[i];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end
