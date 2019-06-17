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
        if (sender.tag == 1) {
            [weakSelf.imageArray insertObject:image atIndex:0];
        }else
        {
            [weakSelf.imageArray insertObject:image atIndex:1];
        }
    }];
    
}
@end
