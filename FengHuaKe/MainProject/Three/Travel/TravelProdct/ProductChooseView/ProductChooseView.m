//
//  ProductChooseView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ProductChooseView.h"
@interface ProductChooseView()
{
    NSString *_size;
    NSString *_color;
    NSString *_mode;
}
@end
@implementation ProductChooseView
@synthesize alphaiView,whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cancle,lb_line,stock,modelView,bt_addshopCar,bt_goPay;
-(instancetype)initWithFrame:(CGRect)frame Style:(ChooseStyle)chooseStyle
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ScreenHeight)];
        alphaiView.backgroundColor = [UIColor blackColor];
        alphaiView.alpha = 0.2;
        [self addSubview:alphaiView];
        
        //装载商品信息的视图
        whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, ScreenHeight-200)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [whiteView addGestureRecognizer:tap];
        
        
        //商品图片
        img = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        img.image = [UIImage imageNamed:PLACEHOLDER];
        img.backgroundColor = [UIColor yellowColor];
        img.layer.cornerRadius = 4;
        img.layer.borderColor = [UIColor whiteColor].CGColor;
        img.layer.borderWidth = 5;
        [img.layer setMasksToBounds:YES];
        [whiteView addSubview:img];
        
        //取消
        bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cancle.frame = CGRectMake(whiteView.frame.size.width-40, 10,30, 30);
        [bt_cancle setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
        [whiteView addSubview:bt_cancle];
        
        //商品价格
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, 10, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_price.textColor = [UIColor redColor];
        lb_price.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_price];
        
        //商品库存
        lb_stock = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_price.frame.origin.y+lb_price.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_stock.textColor = [UIColor blackColor];
        lb_stock.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_stock];
        
        
        //用户所选择商品的尺码和颜色
        lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_stock.frame.origin.y+lb_stock.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 40)];
        lb_detail.numberOfLines = 2;
        lb_detail.textColor = [UIColor blackColor];
        lb_detail.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_detail];
        
        
        //分界线
        lb_line = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+20, whiteView.frame.size.width, 0.5)];
        lb_line.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:lb_line];
        
        
        //确定按钮
        if (chooseStyle==AddShopCarMode||chooseStyle==GoToPayMode)
        {
            bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
            bt_sure.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width, 50);
            [bt_sure setBackgroundColor:[UIColor redColor]];
            [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
            bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
            [bt_sure setTitle:@"确定" forState:0];
            [whiteView addSubview:bt_sure];
            
            
            //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
            mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
            mainscrollview.showsHorizontalScrollIndicator = NO;
            mainscrollview.showsVerticalScrollIndicator = NO;
            [whiteView addSubview:mainscrollview];
        }else
        {
          
            bt_addshopCar= [UIButton buttonWithType:UIButtonTypeCustom];
            bt_addshopCar.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width/2, 50);
            [bt_addshopCar setBackgroundColor:[UIColor orangeColor]];
            [bt_addshopCar setTitleColor:[UIColor whiteColor] forState:0];
            bt_addshopCar.titleLabel.font = [UIFont systemFontOfSize:20];
            [bt_addshopCar setTitle:@"加入购物车" forState:0];
            [whiteView addSubview:bt_addshopCar];

            bt_goPay= [UIButton buttonWithType:UIButtonTypeCustom];
            bt_goPay.frame = CGRectMake(whiteView.frame.size.width/2, whiteView.frame.size.height-50,whiteView.frame.size.width/2, 50);
            [bt_goPay setBackgroundColor:[UIColor redColor]];
            [bt_goPay setTitleColor:[UIColor whiteColor] forState:0];
            bt_goPay.titleLabel.font = [UIFont systemFontOfSize:20];
            [bt_goPay setTitle:@"立即购买" forState:0];
            [whiteView addSubview:bt_goPay];
            
            //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
            mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_addshopCar.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
            mainscrollview.showsHorizontalScrollIndicator = NO;
            mainscrollview.showsVerticalScrollIndicator = NO;
            [whiteView addSubview:mainscrollview];
        }

        
        

        
        //购买数量的视图
        countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [mainscrollview addSubview:countView];
        [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        countView.tf_count.delegate = self;
        [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



#pragma mark - public
-(void)initViewWith:(ProductDetailModel*)model
{
    self.productDetailModel=model;
    _SpecList=[NSMutableArray array];
    _ColorList=[NSMutableArray array];
    _ModelList=[NSMutableArray array];
    for (SpecModel *smodel in model.SpecList ) {
        if (smodel) {
             [_SpecList addObject:smodel.spec];
        }
       
    }
    for (ColorModel *smodel in model.ColorList ) {
           if (smodel) {
                [_ColorList addObject:smodel.color];
           }
       
    }
    for (SizeModel *smodel in model.ModelList) {
        if (smodel) {
              [_ModelList addObject:smodel.modelnum];
        }
      
    }
    //大小
    sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) andDatasource:_SpecList :@"尺码"];
    sizeView.delegate = self;
    [mainscrollview addSubview:sizeView];
    sizeView.frame = CGRectMake(0, 0, self.frame.size.width, sizeView.height);
    //颜色分类
    colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, sizeView.frame.size.height, self.frame.size.width, 50) andDatasource:_ColorList :@"颜色分类"];
    colorView.delegate = self;
    [mainscrollview addSubview:colorView];
    colorView.frame = CGRectMake(0,sizeView.frame.size.height, self.frame.size.width, colorView.height);
    //规格
    modelView = [[TypeView alloc] initWithFrame:CGRectMake(0, colorView.frame.size.height+colorView.frame.origin.y, self.frame.size.width, 50) andDatasource:_ModelList:@"规格"];
    modelView.delegate = self;
    [mainscrollview addSubview:modelView];
    modelView.frame = CGRectMake(0,colorView.frame.size.height+colorView.frame.origin.y, self.frame.size.width, modelView.height);
    //购买数量
    countView.frame = CGRectMake(0, modelView.frame.size.height+modelView.frame.origin.y, self.frame.size.width, 50);
    mainscrollview.contentSize = CGSizeMake(self.frame.size.width, countView.frame.size.height+countView.frame.origin.y);
   
    lb_price.text = [NSString stringWithFormat:@"¥%@",model.minsaleprice];
    lb_stock.text = [NSString stringWithFormat:@"库存%@件",model.total];
    lb_detail.text = @"请选择 尺码 颜色分类";
    
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    img.userInteractionEnabled = YES;
    [img addGestureRecognizer:tap1];
}
#pragma mark - private
-(void)tap
{
    mainscrollview.contentOffset = CGPointMake(0, 0);
    [countView.tf_count resignFirstResponder];
}
#pragma mark - action
-(void)add
{
    int count =[countView.tf_count.text intValue];
    if (count < self.productDetailModel.total.intValue) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)reduce
{
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }else
    {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 100;
                [alert show];
    }
}

/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}

#pragma mark - UItextField
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int count =[countView.tf_count.text intValue];
    if (count > self.stock) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];

    }
}

#pragma mark - TypeViewAction
-(void)btnindex:(int)tag
{

    if (sizeView.seletIndex>=0) {
    
        _size=_SpecList[sizeView.seletIndex];
    }else
    {
        _size=@"";
    }
    
    if (colorView.seletIndex>=0) {
        _color=_ColorList[colorView.seletIndex];
        
    }else
    {
         _color=@"";
    }
    
    if (modelView.seletIndex>=0)
    {
        _mode=_ModelList[modelView.seletIndex];
    }else
    {
        _mode=@"";
    }
    self.chooseProduct=[NSString stringWithFormat:@"%@%@%@",_size,_color,_mode];
      NSLog(@"%@",self.chooseProduct);
    ProductSpecModel *model=[self ExitProduct:self.chooseProduct];
  
  
    if (model) {
        
        lb_price.text=[NSString stringWithFormat:@"¥%@",model.buyprice];
        lb_stock.text=[NSString stringWithFormat:@"库存%@件",model.safestock];
        lb_detail.text=self.chooseProduct;
          bt_sure.enabled=YES;

    }else
    {
        
        bt_sure.enabled=NO;
    }
//
    
    if (self.proChoseDelegate && [self.proChoseDelegate respondsToSelector:@selector(DidChosenProducct:)]) {
        [self.proChoseDelegate DidChosenProducct:model];
    }

    
//    if (sizeView.seletIndex>=0&&colorView.seletIndex==-1&&modelView.seletIndex==-1)
//    {
//          //只选择了尺码
//        for (SpecTreeModel *model in self.productDetailModel.SpecTree) {
//            if ([model.key isEqualToString:@"spec"]&&[model.Value isEqualToString:_SpecList[tag]]) {
//                [self ConfirmUnSeletWithModel:model];
//            }
//        }
//
//    }else if (colorView.seletIndex>=0&&sizeView.seletIndex==-1&&modelView.seletIndex==-1)
//    {
//         //只选择了颜色
//
//    }else if (modelView.seletIndex>=0&&sizeView.seletIndex==-1&&colorView.seletIndex==-1)
//    {
//          //只选择了规格
//
//    }else if(colorView.seletIndex>=0&&sizeView.seletIndex>=0&&modelView.seletIndex==-1)
//    {
//        //选择了尺码和颜色
//
//    }else if (sizeView.seletIndex>=0&&modelView.seletIndex>=0&&colorView.seletIndex==-1)
//    {
//         //选择了尺码和规格
//
//    }else if (colorView.seletIndex>=0&&colorView.seletIndex>=0&&sizeView.seletIndex==-1)
//    {
//         //选择了颜色和规格
//
//    }else
//    {
//        //全都选了
//    }
    
}
#pragma mark - Private
-(void)ConfirmUnSeletWithModel:(SpecTreeModel*)model
{
    //size
    if ([model.key isEqualToString:@"spec"])
    {
        //获取所有 color
        //获取所有 model
        for (TableModel *tmodel in model.Table)
        {
            if (![_ColorList containsObject:tmodel.color])
            {
                
                
            }
            
            
            if (![_ModelList containsObject:tmodel.modelnum] )
            {
                
            }
            
        }
        
    }
    
    //color
    if ([model.key isEqualToString:@"color"])
    {
        //获取所有 size
        //获取所有 model
        for (TableModel *tmodel in model.Table)
        {
            if (![_SpecList containsObject:tmodel.spec])
            {
                
            }
            
            
            if (![_ModelList containsObject:tmodel.modelnum] )
            {
                
            }
            
        }
        
    }
    
    //model
    if ([model.key isEqualToString:@"modelnum"])
    {
        //获取所有 size
        //获取所有 color
        for (TableModel *tmodel in model.Table)
        {
            if (![_SpecList containsObject:tmodel.spec])
            {
                
            }
            
            
            if (![_ColorList containsObject:tmodel.color] )
            {
                
            }
            
        }
    }
    
    
}

-(void)FirstUnSeletWith:(NSArray*)tableArray
{
    
}
#pragma mark - 所有的有库存的组合
-(ProductSpecModel*)ExitProduct:(NSString*)chooseStr
{
    if (chooseStr.length>0) {
        for (ProductSpecModel *mode in self.productDetailModel.ProductSpecList)
        {
            NSLog(@"mode.remark:%@",mode.remark);
            if ([mode.remark isEqualToString:chooseStr]) {
                return mode;
            }
        }
    }

    return nil;
    
}

@end
