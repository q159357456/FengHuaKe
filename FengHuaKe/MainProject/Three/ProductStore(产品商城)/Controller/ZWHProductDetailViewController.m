//
//  ZWHProductDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductDetailViewController.h"
#import "UIViewController+NavBarHidden.h"
#import "ProductBottomView.h"
#import "ZWHProductDetailView.h"
#import "ProductDetailModel.h"
#import "ZWHChooseProView.h"
#import "ConfirmBillVC.h"

@interface ZWHProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *detailTable;
//头部视图
@property(nonatomic,strong)ZWHProductDetailView *detailView;

@property(nonatomic,strong)ProductDetailModel *myProductModel;

@property(nonatomic,strong)ProductSpecModel *ProductSpecModel;

@property(nonatomic,strong)ZWHChooseProView *chooseView;


@end

@implementation ZWHProductDetailViewController

#pragma mark - UIViewController+NavBarHidden

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setInViewWillAppear];
    if (_detailTable) {
        [self scrollViewDidScroll:_detailTable];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self setInViewWillDisappear];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    
    [self getDataSource];
}

-(void)getDataSource{
    [HttpHandler getProductSingle:@{@"para1":_productNo,@"para2":UniqUserID,@"para3":userType} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            [ProductDetailModel mj_objectClassInArray];
            [SpecTreeModel mj_objectClassInArray];
            NSArray *arr = [HttpTool getArrayWithData:obj[@"sysmodel"][@"strresult"]];
            _myProductModel = [ProductDetailModel mj_objectWithKeyValues:arr[0]];
            NSLog(@"加载完毕");
            [self setUI];
        }
    } failed:^(id obj) {
        
    }];
}


-(void)setUI{
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = LINECOLOR;
    _detailTable.showsVerticalScrollIndicator = NO;
    [_detailTable registerClass:[QMUITableViewCell class] forCellReuseIdentifier:@"QMUITableViewCell"];
    self.keyTableView = _detailTable;
    
    [self initBottomView];
    [self setHeaderView];
}



-(void)setHeaderView{
    _detailView = [[ZWHProductDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(321))];
    _detailTable.tableHeaderView = _detailView;
    _detailView.model = _myProductModel;
}

-(void)initBottomView
{
    ProductBottomView *bottom= [[ProductBottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-59, ScreenWidth, 59)];
    [bottom.addShopCar addTarget:self action:@selector(addProductWith:) forControlEvents:UIControlEventTouchUpInside];
    [bottom.goPay addTarget:self action:@selector(goToPayWith:) forControlEvents:UIControlEventTouchUpInside];
    [bottom.collectB addTarget:self action:@selector(getCollectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
//    bottom.collectB.selected = YES;
    
    [bottom.collectB setImage:[UIImage imageNamed:_myProductModel.favorite==0?@"WechatIMG20":@"store"] forState:0];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_offset(HEIGHT_PRO(50));
    }];
}

#pragma mark - 加入购物车 立即购买
-(void)addProductWith:(UIButton *)btn{
    _chooseView = [[ZWHChooseProView alloc]init];
    _chooseView.detailModel = _myProductModel;
    MJWeakSelf
    _chooseView.goCar = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf addProductToCarWith:model Withnum:number];
    };
    _chooseView.payNow = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf goToPayWith:model Withnum:number];
    };
    [self.chooseView ShowView];
}

-(void)goToPayWith:(UIButton *)btn{
    _chooseView = [[ZWHChooseProView alloc]init];
    _chooseView.detailModel = _myProductModel;
    MJWeakSelf
    _chooseView.goCar = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf addProductToCarWith:model Withnum:number];
    };
    _chooseView.payNow = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf goToPayWith:model Withnum:number];
    };
    [self.chooseView ShowView];
}

//加入购物车
-(void)addProductToCarWith:(ProductSpecModel *)model Withnum:(NSInteger)num{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.prono forKey:@"prono"];
    [dict setValue:model.code forKey:@"prospecno"];
    [dict setValue:_myProductModel.firstclassify forKey:@"firstclassify"];
    [dict setValue:_myProductModel.secondclassify forKey:@"secondclassify"];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"membertype"];
    [dict setValue:_myProductModel.shopid forKey:@"shopid"];
    [dict setValue:[NSString stringWithFormat:@"%ld",num] forKey:@"nums"];
    //[self showHudInView:self.chooseView hint:@"正在加入购物车....."];
    [HttpHandler getCartModify:@{} DataList:@[dict] start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        if (ReturnValue==1) {
            [self showHint:@"加入购物车成功"];
            [self.chooseView HiddenView];
        }else{
            [self showHint:@"加入购物车失败"];
        }
    } failed:^(id obj) {
    }];
}

//购买
-(void)goToPayWith:(ProductSpecModel *)model Withnum:(NSInteger)num{
    
    [self.chooseView HiddenView];
    
    ConfirmBillVC *bill=[[ConfirmBillVC alloc]init];
    model.nums = [NSString stringWithFormat:@"%ld",num];
    bill.billData=@[model];
    float sum = [model.saleprice1 floatValue] * num;
    bill.totalPrice=[NSString stringWithFormat:@"%.3f",sum];
    bill.blresult=false;
    bill.state = 1;
    [self.navigationController pushViewController:bill animated:YES];
}


#pragma mark - uitableviewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PRO(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PRO(40);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QMUITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"请选择规格";
    cell.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _chooseView = [[ZWHChooseProView alloc]init];
    _chooseView.detailModel = _myProductModel;
    MJWeakSelf
    _chooseView.goCar = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf addProductToCarWith:model Withnum:number];
    };
    _chooseView.payNow = ^(ProductSpecModel *model, NSInteger number) {
        [weakSelf goToPayWith:model Withnum:number];
    };
    [self.chooseView ShowView];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minAlphaOffset = 0;//- 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    //_barImageView.alpha = alpha;
    UIColor *color = [[UIColor alloc]initWithRed:75/255.0f green:164/255.0f blue:255/255.0f alpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:[DataProcess imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
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



@end
