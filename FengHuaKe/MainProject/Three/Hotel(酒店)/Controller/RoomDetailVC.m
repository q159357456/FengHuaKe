//
//  RoomDetailVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/16.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "RoomDetailVC.h"
#import "HotelViewModel.h"
#import "UIViewController+HUD.h"
#import "RoomModel.h"
#import "NSString+Addition.h"
@interface RoomDetailVC ()
@property(nonatomic,strong)RoomModel *roomModel;
@end

@implementation RoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self HotelRoom];
}

-(void)HotelRoom{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.hotelID,@"para2":self.roomID}];
    [HotelViewModel HotelRoomSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
            NSArray *arr = [HttpTool getArrayWithData:dic[@"sysmodel"][@"strresult"]];
            if (![jsonStr isEqual:[NSNull null]]) {
                DefineWeakSelf;
                NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array=(NSArray*)obj;
                weakSelf.roomModel=[RoomModel getDatawitharray:array][0];
//                [weakSelf.tableview reloadData];
                [weakSelf setUI];
            }
        }else
        {
            
            [self showHint:@"获取群组失败"];
        }
    } Fail:^(id erro) {
        
    }];
}

-(void)setUI{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, ZWHNavHeight, ScreenWidth, ScreenWidth*0.5)];
    NSString *url=[DataProcess PicAdress:[self.roomModel.url URLEncodedString]];
    NSLog(@"%@",url);
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_roomModel.url]] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    [self.view addSubview:imageView];
    
    UIView *infoView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), ScreenWidth, ScreenWidth*0.6)];
    [self.view addSubview:infoView];
    NSArray *titles=@[@"面积",@"卫浴",@"楼层",@"早餐",@"床位",@"宽带",@"浴室",@"窗户"];
  
    NSInteger k=titles.count;
    NSInteger row=ceil((CGFloat)k/2);
    for (NSInteger i=0; i<k; i++) {
        
        CGFloat w=(ScreenWidth-20)/2;
        CGFloat h=infoView.frame.size.height/row;
        CGFloat x=i%2?20+w:20;
        CGFloat y=(ceil((CGFloat)(i+1)/2) -1)*h;
        InfoView *info=[[InfoView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        info.lable1.text=titles[i];
        [infoView addSubview:info];
        switch (i) {
            case 0:
            {
                info.lable2.text=self.roomModel.spec;
            }
                break;
                
            case 1:
            {
                info.lable2.text=self.roomModel.brand;
            }
                break;
            case 2:
            {
                info.lable2.text=self.roomModel.fitscene;
            }
                break;
            case 3:
            {
                info.lable2.text=[_roomModel.saleunit boolValue]?@"包含":@"不包含";
            }
                break;
            case 4:
            {
                info.lable2.text=_roomModel.modelnum;
            }
                break;
            case 5:
            {
                info.lable2.text=self.roomModel.fitobject;
                //info.lable2.text=self.roomModel.modelnum;
            }
                break;
            case 6:
            {
                info.lable2.text=self.roomModel.proplace;
                //info.lable2.text=self.roomModel.fitobject;
            }
                break;
            case 7:
            {
                info.lable2.text=self.roomModel.material;
                //info.lable2.text=self.roomModel.proplace;
            }
                break;
            case 8:
            {
                info.lable2.text=self.roomModel.material;
            }
                break;
            case 9:
            {
                info.lable2.text=@"--";            }
                break;
            case 10:
            {
                info.lable2.text=self.roomModel.material;
            }
                break;
        }


    }
    
    
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame)+20, ScreenWidth, 1)];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 45)];
    button.center=CGPointMake(ScreenWidth/2, ScreenHeight-80-64);
    button.backgroundColor=MainColor;
    [button setTitle:@"下单" forState:UIControlStateNormal];
    //[self.view addSubview:button];
    
    
    
}




@end
@implementation InfoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, frame.size.height)];
        self.lable2=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, frame.size.width-60, frame.size.height)];
        self.lable1.text=@"xx";
        self.lable1.font=[UIFont systemFontOfSize:14];
        self.lable2.font=[UIFont systemFontOfSize:14];
        self.lable2.textColor=[UIColor darkGrayColor];
//        self.lable2.text=@"xxxxxxxxxxx";
        [self addSubview:self.lable1];
        [self addSubview:self.lable2];
        
    }
    return self;
}
@end

