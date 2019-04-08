//
//  ZWHHotelViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelViewController.h"
#import "ZWHHotelHomeTableViewCell.h"
#import "ZWHHotelHomeSectionTableViewCell.h"
#import "ZWHHotelListViewController.h"
#import "NSDate+Extension.h"
#import "BPPCalendar.h"

@interface ZWHHotelViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *hotelTable;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray *timeArr;

@property(nonatomic,strong)NSArray *placeArr;

@property(nonatomic,strong)QMUIButton *typeBusiness;
@property(nonatomic,strong)QMUIButton *typeTravel;

@property(nonatomic,strong)NSString *startData;
@property(nonatomic,strong)NSString *endData;

@property(nonatomic,strong)BPPCalendar *clender;


@end

@implementation ZWHHotelViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店";
    _titleArr = @[@"目的地",@"入住时间",@"离店时间"];
    _placeArr = @[@"位置/酒店名/品牌",@"价格/星级"];
    
    
    
    //获取日期
    NSDate *nowDate=[NSDate date];
    
    
    NSDate *tomorrow=[NSDate dateTomorrow];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    formater.dateFormat=@"yyyy-MM-dd";
    NSString *t=[formater stringFromDate:tomorrow];
    NSString *n=[formater stringFromDate:nowDate];
    _startData = n;
    _endData = t;
    formater.dateFormat=@"MM月dd日";
    _timeArr = [NSMutableArray arrayWithArray:@[[formater stringFromDate:nowDate],[formater stringFromDate:tomorrow]]];
    
    [self setUI];
    [self setFooterView];
}

-(void)setUI{
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hotel"]];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.height.mas_equalTo(HEIGHT_PRO(183));
    }];
    
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WIDTH_PRO(15));
        make.right.equalTo(self.view).offset(-WIDTH_PRO(15));
        make.top.equalTo(self.view).offset(HEIGHT_PRO(60)+(ZWHNavHeight));
        make.height.mas_equalTo(HEIGHT_PRO(404));
    }];
    
    [self setShowdownWith:backView];
    
    
    _hotelTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [backView addSubview:_hotelTable];
    [_hotelTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(backView);
    }];
    _hotelTable.layer.cornerRadius = 8;
    _hotelTable.layer.masksToBounds = YES;
    _hotelTable.delegate = self;
    _hotelTable.dataSource = self;
    _hotelTable.separatorStyle = 0;
    _hotelTable.backgroundColor = [UIColor whiteColor];
    _hotelTable.showsVerticalScrollIndicator = NO;
    [_hotelTable registerClass:[ZWHHotelHomeTableViewCell class] forCellReuseIdentifier:@"ZWHHotelHomeTableViewCell"];
    [_hotelTable registerClass:[ZWHHotelHomeSectionTableViewCell class] forCellReuseIdentifier:@"ZWHHotelHomeSectionTableViewCell"];
    _hotelTable.bounces = NO;
    self.keyTableView = _hotelTable;
    [_hotelTable layoutIfNeeded];
}

#pragma mark - uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ZWHHotelHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHHotelHomeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.title.text = _titleArr[indexPath.row];
        if (indexPath.row==0) {
            cell.right.hidden = YES;
            cell.name.text = userCity;
        }else{
            cell.Location.hidden = YES;
            cell.name.text = _timeArr[indexPath.row-1];
        }
        return cell;
    }else{
        ZWHHotelHomeSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWHHotelHomeSectionTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        if (indexPath.row==0) {
            cell.title.text = @"搜索条件";
        }
        cell.name.placeholder = _placeArr[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0?HEIGHT_PRO(35):HEIGHT_PRO(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?0:HEIGHT_PRO(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row>0) {
            MJWeakSelf
            self.clender=[[BPPCalendar alloc]initWithFrame:[UIScreen mainScreen].bounds SlectBlock:^(NSInteger year,NSInteger moth, NSInteger day) {
                
                switch (indexPath.row) {
                    case 1:
                        {
                            if ([weakSelf compareOneDay:[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day] withAnotherDay:weakSelf.endData]>=0) {
                                [weakSelf showHint:@"出发日期晚于结束日期"];
                            }else{
                                weakSelf.startData=[NSString stringWithFormat:@"%ld-%02ld-%02ld",year,moth,day];
                                [weakSelf.timeArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%02ld月%02ld日",moth,day]];
                            }
                        }
                        break;
                    case 2:
                    {
                        if ([weakSelf compareOneDay:[NSString stringWithFormat:@"%ld-%ld-%ld",year,moth,day] withAnotherDay:weakSelf.startData]<=0) {
                            [weakSelf showHint:@"结束日期早于出发日期"];
                        }else{
                            weakSelf.endData=[NSString stringWithFormat:@"%ld-%02ld-%02ld",year,moth,day];
                            [weakSelf.timeArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%02ld月%02ld日",moth,day]];
                        }
                    }
                        break;
                    default:
                        break;
                }
                [weakSelf.hotelTable reloadData];
            }];
            self.clender.minDate=[NSDate date];
            [self.view addSubview:self.clender];
        }
    }
}

- (NSInteger)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}


#pragma mark - 设置尾部视图
-(void)setFooterView{
    UIView *footerView = [[UIView alloc]init];
    
    QMUILabel *typeL = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"#808080")];
    typeL.text = @"出行类型";
    [footerView addSubview:typeL];
    [typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(WIDTH_PRO(8));
        make.top.equalTo(footerView).offset(WIDTH_PRO(20));
    }];
    
    _typeBusiness = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"picture_seleted"] title:@"商务出差"];
    [_typeBusiness setTitleColor:[UIColor blackColor] forState:0];
    _typeBusiness.tag = 1;
    [footerView addSubview:_typeBusiness];
    [_typeBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeL);
        make.left.equalTo(footerView).offset(WIDTH_PRO(81));
    }];
    
    _typeTravel = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"picture_selet"] title:@"休闲旅游"];
    [_typeTravel setTitleColor:[UIColor blackColor] forState:0];
    _typeTravel.tag = 2;
    [footerView addSubview:_typeTravel];
    [_typeTravel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeL);
        make.left.equalTo(_typeBusiness.mas_right).offset(WIDTH_PRO(52));
    }];
    
    [_typeBusiness addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
    [_typeTravel addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *search = [[QMUIButton alloc]init];
    search.titleLabel.font = HTFont(32);
    [search setTitleColor:[UIColor whiteColor] forState:0];
    search.backgroundColor = MAINCOLOR;
    search.layer.cornerRadius = 5;
    search.layer.masksToBounds = YES;
    [search setTitle:@"搜索" forState:0];
    [footerView addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(220));
        make.height.mas_equalTo(HEIGHT_PRO(40));
        make.centerX.equalTo(footerView);
        make.top.equalTo(_typeBusiness.mas_bottom).offset(HEIGHT_PRO(20));
    }];
    [search addTarget:self action:@selector(searchHotel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = ZWHCOLOR(@"#F7F7F7");
    bottomView.layer.cornerRadius = 5;
    bottomView.layer.masksToBounds = YES;
    [footerView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(search.mas_bottom).offset(HEIGHT_PRO(25));
        make.left.equalTo(footerView).offset(WIDTH_PRO(20));
        make.right.equalTo(footerView).offset(-WIDTH_PRO(20));
        make.height.mas_equalTo(HEIGHT_PRO(45));
    }];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ceshi_3_3"]];
    [bottomView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(WIDTH_PRO(25));
        make.centerY.equalTo(bottomView);
        make.width.mas_equalTo(WIDTH_PRO(15));
        make.height.mas_equalTo(HEIGHT_PRO(20));
    }];
    
    QMUILabel *detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:MAINCOLOR];
    detail.text = @"我的酒店(收藏、评价、历史入住、优惠)";
    NSString *text = detail.text;
    NSRange range1 = [text rangeOfString:@"(收藏、评价、历史入住、优惠)"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:ZWHCOLOR(@"#808080") range:range1];
    [str addAttribute:NSFontAttributeName value:HTFont(24) range:range1];
    detail.attributedText = str;
    [bottomView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(WIDTH_PRO(8));
        make.centerY.equalTo(bottomView);
    }];
    
    UIImageView *right = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_t"]];
    [bottomView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-WIDTH_PRO(6));
        make.centerY.equalTo(bottomView);
    }];
    
    
    footerView.frame = CGRectMake(0, 0, _hotelTable.width, HEIGHT_PRO(200));
    _hotelTable.tableFooterView = footerView;
}

#pragma mark - 选择出行类型  搜索
-(void)chooseType:(QMUIButton *)btn{
    [btn setImage:[UIImage imageNamed:@"picture_seleted"] forState:0];
    QMUIButton *oldBtn = btn.tag==1?_typeTravel:_typeBusiness;
    [oldBtn setImage:[UIImage imageNamed:@"picture_selet"] forState:0];
}

-(void)searchHotel:(QMUIButton *)btn{
    
    ZWHHotelListViewController *vc = [[ZWHHotelListViewController alloc]init];
    vc.timeArr = @[self.startData,self.endData];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 设置阴影
-(void)setShowdownWith:(UIView *)view{
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = WIDTH_PRO(8);
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    //view.layer.shadowColor = [UIColor redColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    //view.layer.shadowRadius = 10;//阴影半径，默认3
    //view.layer.masksToBounds = YES;
}



@end
