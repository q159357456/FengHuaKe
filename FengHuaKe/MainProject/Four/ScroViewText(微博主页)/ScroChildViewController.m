//
//  ScroChildViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ScroChildViewController.h"

@interface ScroChildViewController ()<UITableViewDelegate,UITableViewDataSource>



//判断是否能够滑动
@property(nonatomic,assign)BOOL zwhCanScroaEnble;

@end

@implementation ScroChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _zwhCanScroaEnble = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childTabCanScro:) name:childTab object:nil];
    
    //为两个表格冲突的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childCanOffset:) name:INSIDE object:nil];
    
    [self setUI];
}

//控制子视图是否能偏移(用于解决内外表格谁滑动谁不动)
-(void)childCanOffset:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"NO"]) {
        _zwhCanScroaEnble = NO;
    }else{
        _zwhCanScroaEnble = YES;
    }
}


//控制是否滑动(用于解决表格视图和分页容器的上下 左右手势冲突)
-(void)childTabCanScro:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"NO"]) {
        _ticketTable.scrollEnabled = NO;
    }else{
        _ticketTable.scrollEnabled = YES;
    }
}

-(void)setUI{
    
    
    _ticketTable = [[ZWHBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_ticketTable];
    [_ticketTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    _ticketTable.delegate = self;
    _ticketTable.dataSource = self;
    //_ticketTable.separatorStyle = 0;
    _ticketTable.backgroundColor = LINECOLOR;
    _ticketTable.showsVerticalScrollIndicator = NO;
    [_ticketTable registerClass:[QMUITableViewCell class] forCellReuseIdentifier:@"QMUITableViewCell"];
    self.keyTableView = _ticketTable;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QMUITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"NO"];
        if (_zwhCanScroaEnble) {
            if (scrollView.contentOffset.y<0) {
                _parentVc.currentIndex = _index;
                [[NSNotificationCenter defaultCenter] postNotificationName:OUTSIDE object:@"YES"];
                _zwhCanScroaEnble = NO;
                _parentVc.isSpec = NO;
            }
        }else{
//            if (scrollView.contentOffset.y > 0 && _index!=_parentVc.currentIndex) {
//                _zwhCanScroaEnble = YES;
//                _parentVc.isSpec = YES;
//                [[NSNotificationCenter defaultCenter] postNotificationName:OUTSIDE object:@"NO"];
//            }else{
                scrollView.contentOffset = CGPointMake(0, 0);
            //}
            
//            if (_parentVc.zwhCanScroaEnble) {
//
//            }
//            if (_index == _parentVc.currentIndex) {
//                scrollView.contentOffset = CGPointMake(0, 0);
//            }
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"YES"];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _ticketTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentTab object:@"YES"];
    }
}


@end
