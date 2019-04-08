//
//  ZWHMyQRViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2019/2/22.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "ZWHMyQRViewController.h"
#import "ZSHttpTool.h"
#import "UMShare.framework/Headers/UMShare.h"

@interface ZWHMyQRViewController ()

@property(nonatomic,strong)UIImageView *qrCode;
@property(nonatomic,strong)QMUIGridView *bottomGridView;

@end

@implementation ZWHMyQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self setUI];
    [self getQrcode];
}

-(void)setUI{
    UIImageView *img = [[UIImageView alloc]init];
    img.layer.borderColor = MAINCOLOR.CGColor;
    img.layer.borderWidth = 3;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH_PRO(47));
        make.top.equalTo(self.view).offset(ZWHNavHeight+HEIGHT_PRO(4));
        make.width.height.mas_equalTo(WIDTH_PRO(70));
    }];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,userIcon]] placeholderImage:[UIImage imageNamed:@"default_head"]];
    img.layer.cornerRadius = WIDTH_PRO(35);
    img.layer.masksToBounds = YES;
    
    QMUILabel *name = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(16) textColor:[UIColor blackColor]];
    name.text = userNickNmae;
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(img.mas_centerY).offset(-3);
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(4));
    }];
    
    QMUILabel *tips = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:[UIColor qmui_colorWithHexString:@"#8A8A8A"]];
    tips.text = @"扫一扫二维码,加我好友";
    [self.view addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_centerY).offset(3);
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(4));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(4));
    }];
    
    _qrCode = [[UIImageView alloc]init];
    [self.view addSubview:_qrCode];
    [_qrCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(289));
        make.height.mas_equalTo(HEIGHT_PRO(320));
        make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(10));
        make.centerX.equalTo(self.view);
    }];
    
    QMUIButton *saveCode = [[QMUIButton alloc]qmui_initWithImage:nil title:@"保存二维码"];
    saveCode.titleLabel.font = ZWHFont(16);
    [saveCode setTitleColor:[UIColor whiteColor] forState:0];
    saveCode.backgroundColor = MAINCOLOR;
    saveCode.layer.cornerRadius = 3;
    saveCode.layer.masksToBounds = YES;
    [self.view addSubview:saveCode];
    [saveCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_qrCode.mas_bottom).offset(HEIGHT_PRO(15));
        make.width.mas_equalTo(WIDTH_PRO(130));
        make.height.mas_equalTo(HEIGHT_PRO(40));
        make.centerX.equalTo(_qrCode);
    }];
    
    [self.view addSubview:self.bottomGridView];
    [_bottomGridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        //make.top.equalTo(lab.mas_bottom).offset(HEIGHT_PRO(6));
        make.height.mas_equalTo(HEIGHT_PRO(95));
    }];
    
    
    QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:textDefault];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"------二维码分享给------";
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomGridView.mas_top).offset(-HEIGHT_PRO(4));
        make.centerX.equalTo(self.view);
    }];
    
    
}

-(void)getQrcode{
    
    NSString *str = [NSString stringWithFormat:@"http://fhtx.onedft.cn/content/h5/index.html?parenttype=M&userid=%@&username=%@",UniqUserID,userNickNmae];
    [HttpHandler appendGetUrl:@"/System/QrCodeTool" success:^(id obj) {
        _qrCode.image = [UIImage imageWithData:obj];
    } failed:^(id obj) {
    } postDict:@{@"data":str,@"icourl":[NSString stringWithFormat:@"%@%@",SERVER_IMG,userIcon]}];

}

//分享模块
-(QMUIGridView *)bottomGridView{
    if (!_bottomGridView) {
        NSArray *titleArr = @[@"微信好友",@"朋友圈",@"QQ好友",@"新浪微博"];
        NSArray *imageArr = @[@"weixin",@"pengyou",@"QQ",@"xinlang"];
        _bottomGridView = [[QMUIGridView alloc]initWithColumn:4 rowHeight:HEIGHT_PRO(95)];
        _bottomGridView.backgroundColor = [UIColor clearColor];
        for (NSInteger i=0;i<imageArr.count;i++) {
            QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:imageArr[i]] title:titleArr[i]];
            [btn setTitleColor:textDefault forState:0];
            btn.titleLabel.font = ZWHFont(13);
            btn.imagePosition = QMUIButtonImagePositionTop;
            btn.spacingBetweenImageAndTitle = 8.0f;
            btn.backgroundColor = [UIColor clearColor];
            [_bottomGridView addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(bottomGirdViewWith:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _bottomGridView;
}


#pragma mark - 分享
-(void)bottomGirdViewWith:(QMUIButton *)btn{
    switch (btn.tag) {
        case 0: {
            // 微信
            [self shareTextToPlatformType:UMSocialPlatformType_WechatSession];
        }
            break;
        case 1: {
            // 微信朋友圈
            [self shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
            
        }
            break;
        case 2: {
            // QQ
            [self shareTextToPlatformType:UMSocialPlatformType_QQ];
            
            
        }
            break;
        case 3: {
            // 微博
            //[self shareTextToPlatformType:UMSocialPlatformType_Sina];
        }
            break;
        default:
            break;
    }
}


//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    //UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:@"" thumImage:[UIImage imageNamed:@"logo"]];
    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:@"" descr:@"" thumImage:[UIImage imageNamed:@"WechatIMG2"]];
    NSString *shopname;
//    if (platformType==UMSocialPlatformType_QQ||platformType==UMSocialPlatformType_Qzone)
//    {
//        shopname=[gshopName URLEncodedString];
//    }else
//    {
//        shopname=gshopName;
//    }
    //NSString *url=[NSString stringWithFormat:@"%@?shopid=%@&shopname=%@",[userDefault objectForKey:@"codeUrl"],gSHOPID,shopname];
    
    //shareObject.webpageUrl =url;
    //ZWHShareCollectionViewCell *cell = [_scroImage curIndexCell];
    shareObject.shareImage = [UIImage qmui_imageWithView:_qrCode];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"分享成功");
            NSLog(@"response data is %@",data);
        }
    }];
}


@end
