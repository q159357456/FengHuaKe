//
//  BlogDetailViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BlogDetailViewController.h"
#import "BlogsModel.h"
#import "CommentListModel.h"
#import "BlogCommentCell.h"
#import <IQKeyboardManager.h>
@interface BlogDetailViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)BlogsModel * blogModel;
@property(nonatomic,strong)NSMutableArray * commentListArr;
@property (nonatomic, strong) UITextField *textField;
@property(nonatomic,copy)NSString * paramCode;
@property(nonatomic,copy)NSString * type;
@end

@implementation BlogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentListArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary * param = @{@"para1":self.code,@"para2":UniqUserID};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:Blogs_Single RequestStr:GETRequestStr(nil, param, nil, nil, nil) Result:^(id obj, id erro) {

         NSLog(@"obj1===>%@",obj);
         weakSelf.blogModel = [BlogsModel mj_objectWithKeyValues:obj[@"DataList"][0]];
         [weakSelf setUI];
         [weakSelf getCommentData];

    }];
    [self setupTextField];
    

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    NOTIFY_REMOVE(UIKeyboardWillChangeFrameNotification);
    [_textField resignFirstResponder];
}
-(void)getCommentData{
    DefineWeakSelf;
    NSDictionary * param1 = @{@"para1":self.code,@"blresult":@"true"};
    [DataProcess requestDataWithURL:Blogs_CommentList RequestStr:GETRequestStr(nil, param1, @1, @100, nil) Result:^(id obj, id erro) {
        
        NSLog(@"obj2===>%@",obj);
        weakSelf.commentListArr = [CommentListModel mj_objectArrayWithKeyValuesArray:obj[@"DataList"]];
//        NSLog(@"obj===>%@",weakSelf.commentListArr);
        [weakSelf.tableView reloadData];
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 200;
        [_tableView registerClass:[BlogCommentCell class] forCellReuseIdentifier:@"BlogCommentCell"];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(void)setUI{
    
    UIView * headView = [[UIView alloc]init];
    
    CGFloat space = MULPITLE*10;
    CGFloat tempW = SCREEN_WIDTH - 2*space;
    
    UIView * view1 = [[UIView alloc]init];
    UILabel * label1 = [[UILabel alloc]init];
    label1.font = ZWHFont(14*MULPITLE);
    label1.numberOfLines = 0;
    label1.text = self.blogModel.title;
    CGSize  size1 = [label1 sizeThatFits:CGSizeMake(tempW, MAXFLOAT)];
    label1.frame = CGRectMake(space, space, tempW, size1.height);
    view1.frame = CGRectMake(0, 0, SCREEN_WIDTH, size1.height+2*space);
    
    view1.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    view1.qmui_borderWidth = 1;
    view1.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [view1 addSubview:label1];
    [headView addSubview:view1];
    
    UIView * view2 = [[UIView alloc]init];
    UIImageView * logo = [[UIImageView alloc]init];
    UILabel * nike = [[UILabel alloc]init];
    nike.font = ZWHFont(14*MULPITLE);
    
    ImageCacheDefine(logo, self.blogModel.logo);
    nike.text = self.blogModel.author;
    view2.frame = CGRectMake(0, CGRectGetMaxY(view1.frame), SCREEN_WIDTH, 60*MULPITLE);
    logo.frame = CGRectMake(space, space, WIDTH_PRO(40), WIDTH_PRO(40));
    nike.frame = CGRectMake(CGRectGetMaxX(logo.frame)+3, space, WIDTH_PRO(200), WIDTH_PRO(40));
    logo.layer.cornerRadius = WIDTH_PRO(40)/2;
    logo.layer.masksToBounds = YES;
    [view2 addSubview:logo];
    [view2 addSubview:nike];
    [headView addSubview:view2];
    
    UIView * line1 = [[UIView alloc]init];
    line1.frame = CGRectMake(0, CGRectGetMaxY(view2.frame), SCREEN_WIDTH, space);
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headView addSubview:line1];
    
    UIView * view3 = [[UIView alloc]init];
    UILabel * label3 = [[UILabel alloc]init];
    label3.font = ZWHFont(14*MULPITLE);
    label3.numberOfLines = 0;
    label3.text = self.blogModel.content;
    CGSize size2 = [label3 sizeThatFits:CGSizeMake(tempW, MAXFLOAT)];
    label3.frame = CGRectMake(space, space, SCREEN_WIDTH - 2*space, size2.height);
    view3.frame =CGRectMake(0, CGRectGetMaxY(line1.frame), SCREEN_WIDTH, size2.height+2*space);
    
    [view3 addSubview:label3];
    [headView addSubview:view3];
    
    UIView * line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line2.frame = CGRectMake(0, CGRectGetMaxY(view3.frame), SCREEN_WIDTH, space);
    [headView addSubview:line2];
    
    UIView * view4 = [[UIView alloc]init];
    UILabel * label4 = [[UILabel alloc]init];
    label4.font = ZWHFont(14*MULPITLE);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    label4.text = @"评论内容";
    view4.frame = CGRectMake(0, CGRectGetMaxY(line2.frame), SCREEN_WIDTH, MULPITLE*40);
    label4.frame = CGRectMake(space, 0, 80*MULPITLE, view4.height);
    btn.frame = CGRectMake(view4.width - MULPITLE*50 - space , space, MULPITLE*50, MULPITLE*20);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4*MULPITLE;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    btn.titleLabel.font = ZWHFont(12*MULPITLE);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [view4 addSubview:label4];
    [view4 addSubview:btn];
    view4.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    view4.qmui_borderWidth = 1;
    view4.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [headView addSubview:view4];
    
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(view4.frame));
    
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    
}

-(void)comment:(NSString*)detail Code:(NSString*)code Type:(NSString*)type{
    DefineWeakSelf;
    NSArray * dataList = @[@{@"parenttype":type,@"parentid":code,@"memberid":UniqUserID,@"details":detail}];
    
    [DataProcess requestDataWithURL:Dynamic_CommentAdd RequestStr:GETRequestStr(dataList, nil, nil, nil, nil) Result:^(id obj, id erro) {
        
        NSLog(@"commentobj===>%@",obj);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentListArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentListModel * model = self.commentListArr[indexPath.row];
    BlogCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BlogCommentCell"];
    [cell loadData:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    DefineWeakSelf;
    cell.rePlyCallBack = ^(NSString * _Nonnull code) {
        if ([weakSelf.textField becomeFirstResponder]) {
             weakSelf.paramCode = code;
             weakSelf.type = @"B";
           
        }
       
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentListModel * model = self.commentListArr[indexPath.row];
    return [BlogCommentCell cellHeight:model];
}

-(void)comment:(UIButton*)btn{
    
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - 40, rect.size.width, 40);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
   
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
  
}

- (void)setupTextField{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, 40);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textColor = [UIColor blackColor];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
         NSLog(@"model.code1==>%@",self.paramCode);
         NSLog(@"model.code1==>%@",self.type);
        [self comment:textField.text Code:self.paramCode Type:self.type];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
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
