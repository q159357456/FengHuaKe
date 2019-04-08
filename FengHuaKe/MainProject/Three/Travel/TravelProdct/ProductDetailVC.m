//
//  ProductDetailVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ProductVM.h"
#import "ProductChooseView.h"
#import "ProductDetailView.h"
#import "ProductBottomView.h"
#import "UIViewController+NavBarHidden.h"
#import "ProductDetailModel.h"
#import "UIViewController+HUD.h"
@interface ProductDetailVC ()<UITextFieldDelegate,UIScrollViewDelegate,ProductChooseViewDelegate>
{
    ProductChooseView *choseView;
    CGPoint center;
    ProductDetailView *goodsDetail;
    ProductSpecModel *_chosenProduct;
    
}
@property(nonatomic,strong)ProductDetailModel *myProductModel;

@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //2.设置导航条内容
//    [self setUpNavBar];
    self.title=@"商品详情";
    
    //3.导航条上的自定义的子标签是否需要跟着隐藏.

    // self.isLeftAlpha = YES;
    [self getProductDetail];
    

}
#pragma mark - 获取产品详情
-(void)getProductDetail
{
    // sysmodel.para1:产品代码
    DefineWeakSelf;
    NSString *str=[DataProcess getJsonStrWithObj:@{@"para1":self.productNo,@"para2":UniqUserID,@"para3":userType}];
    [ProductVM ProductSingleSysmodel:str Success:^(id responseData) {
//        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=(NSDictionary*)responseData;
        NSString *jsonStr=dic[@"sysmodel"][@"strresult"];
        if (![jsonStr isEqual:[NSNull null]]) {
            NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSObject *obj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array=(NSArray*)obj;
            weakSelf.myProductModel=[ProductDetailModel getDatawithdic:array[0]][0];
            [weakSelf initview];
        }
    } Fail:^(id erro) {
        
    }];
}


#pragma mark - UIViewController+NavBarHidden

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [self setInViewWillAppear];
 
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
 
    [self setInViewWillDisappear];
  
}

#pragma mark - UI设置
- (void)setUpNavBar{
    
    
    //    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"商品详情";
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
  
    
}



-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBottomView];
    [self initDetailView];

}
-(void)initChoseViewWithStyle:(ChooseStyle)chooseStyle
{
    //选择尺码颜色的视图
    choseView = [[ProductChooseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) Style:chooseStyle];
    choseView.proChoseDelegate=self;
    [self.view addSubview:choseView];
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    if (chooseStyle==AddShopCarMode)
    {
        [choseView.bt_sure addTarget:self action:@selector(sureToAddCar) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (chooseStyle==GoToPayMode)
    {
        [choseView.bt_sure addTarget:self action:@selector(sureToPay) forControlEvents:UIControlEventTouchUpInside];
        
    }else
    {
       [choseView.bt_addshopCar addTarget:self action:@selector(sureToAddCar) forControlEvents:UIControlEventTouchUpInside];
        [choseView.bt_goPay addTarget:self action:@selector(sureToPay) forControlEvents:UIControlEventTouchUpInside];
        
    }

    [choseView initViewWith:self.myProductModel];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
  
    
}
#pragma mark - ProductChooseViewDelegate
-(void)DidChosenProducct:(ProductSpecModel *)model
{
  
    _chosenProduct=model;
}

-(void)initDetailView
{
    NSMutableArray *urlArray=[NSMutableArray array];
    
    for (PictureModel *model in self.myProductModel.PictureList) {
        [urlArray addObject:[DataProcess PicAdress:model.url]];
    }
    //宝贝图片数组
    goodsDetail = [[ProductDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenHeight-59) andImageArr:urlArray];
    goodsDetail.delegate = self;

    [self.view addSubview:goodsDetail];
    //宝贝详情内容
    [goodsDetail initdata:self.myProductModel];
    
    [goodsDetail.bt_addSize addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
//    [goodsDetail.bt_judge addTarget:self action:@selector(goodsJudge) forControlEvents:UIControlEventTouchUpInside];
//    [goodsDetail.bt_shop addTarget:self action:@selector(seleteShop) forControlEvents:UIControlEventTouchUpInside];
    [goodsDetail.bt_share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //图文详情webview的网址
//    [goodsDetail initWebScro:@[@"http://www.cocoachina.com",@"http://www.baidu.com",@"http://code.cocoachina.com"]];
   self.keyScrollView = goodsDetail;
   
}

-(void)initBottomView
{
    
   ProductBottomView *bottom= [[ProductBottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-59, ScreenWidth, 59)];
    [bottom.addShopCar addTarget:self action:@selector(addShopCar) forControlEvents:UIControlEventTouchUpInside];
    [bottom.goPay addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    [bottom.collectB addTarget:self action:@selector(getCollectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    bottom.collectB.selected = YES;
    
    [bottom.collectB setImage:[UIImage imageNamed:_myProductModel.favorite==0?@"WechatIMG20":@"store"] forState:0];
    [self.view addSubview:bottom];
}

#pragma mark - productDetailAction action
//收藏
-(void)getCollectWithBtn:(UIButton *)btn{
    MJWeakSelf
    if (_myProductModel.favorite == 0) {
        [HttpHandler getFavoriteProductAdd:@{@"para1":UniqUserID,@"para2":userType,@"para3":_myProductModel.productno,@"para5":_myProductModel.firstclassify,@"para6":_myProductModel.secondclassify,@"para7":_myProductModel.shopid} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            if (ReturnValue == 1) {
                [self showHint:@"收藏成功"];
                weakSelf.myProductModel.favorite = 1;
                [btn setImage:[UIImage imageNamed:@"store"] forState:0];
            }
        } failed:^(id obj) {
            NSLog(@"%@",obj);
        }];
    }else{
        [HttpHandler getFavoriteProductDelete:@{@"para1":UniqUserID,@"para2":userType,@"para3":_myProductModel.productno} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
            if (ReturnValue == 1) {
                [self showHint:@"取消成功"];
                weakSelf.myProductModel.favorite = 0;
                [btn setImage:[UIImage imageNamed:@"WechatIMG20"] forState:0];
            }
        } failed:^(id obj) {
            
        }];
    }
}


//选择尺寸样式
-(void)show
{
    [self initChoseViewWithStyle:ChoosingMode];
    center = goodsDetail.center;
    center.y -= 64;
   
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        choseView.chooseStyle=ChoosingMode;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion: nil];
}
//加入购物车
-(void)addShopCar
{
    [self initChoseViewWithStyle:AddShopCarMode];
    center = goodsDetail.center;
    center.y -= 64;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
         choseView.chooseStyle=AddShopCarMode;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
       
    } completion:^(BOOL finished) {
      
    }];
}
//立即购买
-(void)goToPay
{
    [self initChoseViewWithStyle:GoToPayMode];
    center = goodsDetail.center;
    center.y -= 64;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        choseView.chooseStyle=GoToPayMode;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
         NSLog(@"立即购买");
    }];
}
-(void)dismiss
{
    center.y += 64;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        goodsDetail.bt_addSize.headLabel.text = choseView.lb_detail.text;
    } completion:^(BOOL finished) {
        [choseView removeFromSuperview];
        choseView=nil;
    }];
    
}
-(void)share
{
      NSLog(@"share");
    
}


#pragma mark - 确定加入购物车
-(void)sureToAddCar
{
    if ([self juge]) {
        [self dismiss];
        NSString *datalist=[DataProcess getJsonStrWithObj:@[@{@"prono":_chosenProduct.prono,@"prospecno":_chosenProduct.code,@"firstclassify":self.myProductModel.firstclassify,@"secondclassify":self.myProductModel.secondclassify,@"memberid":UniqUserID,@"membertype":@"M",@"shopid":self.myProductModel.shopid,@"nums":@"1"}]];
          
        [ProductVM CartModifyDataList:datalist Success:^(id responseData) {
            NSDictionary *dic=(NSDictionary*)responseData;
            NSLog(@"确定加入购物车:%@",responseData);
            NSString *blresult=dic[@"sysmodel"][@"blresult"];
            if (blresult.intValue) {
                  [self showHint:@"已经加入购物车"];
            }else
            {
                  [self showHint:blresult];
            }

        } Fail:^(id erro) {
            
        }];
      
    }

}
#pragma mark - 确定支付
-(void)sureToPay
{
    
    if ([self juge]) {
        [self dismiss];
       [self showHint:@"跳转支付"];
    }
    
}
-(BOOL)juge
{
   
    
    if (choseView.sizeView.seletIndex==-1) {
         NSLog(@"%ld",(long)choseView.sizeView.seletIndex);
        [self showHint:@"第一项未选"];
        return NO;
    }
    if (choseView.colorView.seletIndex==-1) {
         NSLog(@"%ld",(long)choseView.colorView.seletIndex);
        [self showHint:@"第二项未选"];
        return NO;
    }
    if (choseView.modelView.seletIndex==-1) {
        NSLog(@"%ld",(long)choseView.modelView.seletIndex);
        [self showHint:@"第三项未选"];
        return NO;
    }
    return YES;
}


#pragma mark - scroDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll");
    //rate将决定颜色变化程度,值越大,颜色变化越明显,rate的取值范围是0.01 - 0.999999
    if (scrollView == goodsDetail) {
        [self scrollControlByOffsetY:200];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
