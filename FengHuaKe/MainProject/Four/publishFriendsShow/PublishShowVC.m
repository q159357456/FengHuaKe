//
//  PublishShowVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/9.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "PublishShowVC.h"
#import "PublishCollectionViewCell.h"
#import "UITextView+PlaceHolder.h"
#import "FriendsShowVM.h"
#import "UIViewController+HUD.h"
static NSString *imageStr=@"add";
@interface PublishShowVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PublishShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发表";
    [_textView addPlaceHolder:@"发表点什么。。。。"];
    [_collectionview registerNib:[UINib nibWithNibName:@"PublishCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishCollectionViewCell"];
    
    //
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定发表" style:UIBarButtonItemStyleDone target:self action:@selector(publish)];
    [rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - action
-(void)publish
{
    if (self.dataArray.count>=2) {
        [self upLoad];
    }else
    {
        if (_textView.text.length==0) {
            [self showHint:@"没有发布内容"];
        }else
        {
            [self upload2];
        }
       
    }
    
}

#pragma mark - set/get
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithObject:imageStr];
    }
    return _dataArray;
}
#pragma mark - collectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PublishCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PublishCollectionViewCell" forIndexPath:indexPath];
    
    
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]])
    {
        
        cell.imageview.image=[UIImage imageNamed:self.dataArray[indexPath.row]];
    
        
        
    }else if([self.dataArray[indexPath.row] isKindOfClass:[NSData class]])
    {
        cell.imageview.image=[UIImage imageWithData:self.dataArray[indexPath.row]];
  
   
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]])
    {
         //选择照片
        DefineWeakSelf;
        [[DataProcess shareInstance]choosePhotoWithBlock:^(UIImage *image) {
              NSData *data =UIImageJPEGRepresentation(image, 0.8f);
            [weakSelf.dataArray insertObject:data atIndex:indexPath.row ];
            [weakSelf.collectionview reloadData];
        }];
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth-40)/3,(ScreenWidth-40)/3);
    
}
//设置section的上左下右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}
// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10;
    
}

#pragma mark - net
//上传到服务器
-(void)upLoad
{
    if (_textView.text==nil) {
        _textView.text=@"";
    }
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":_textView.text,@"para3":@"0",@"para4":@"0",@"para5":@"",@"blresult":@"true"}];

    NSMutableArray *array=[NSMutableArray arrayWithArray:self.dataArray];
    [array removeLastObject];
    DefineWeakSelf;
    [FriendsShowVM DynamicPublishDynamicImagesSysmodel:sysmodel DataArray:array Success:^(id responseData) {
       
        if (responseData) {
            NSDictionary *dic=(NSDictionary*)responseData;
            if ([dic[@"sysmodel"][@"blresult"] intValue]) {
                [self showHint:@"发表成功!"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } Fail:^(id erro) {
        
        
    }];
    
}
//纯文字
-(void)upload2
{
   DefineWeakSelf;
     NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":UniqUserID,@"para2":_textView.text,@"para3":@"0",@"para4":@"0",@"para5":@"",@"blresult":@"true"}];
    [FriendsShowVM DynamicPublishDynamicSysmodel:sysmodel Success:^(id responseData) {
        if (responseData) {
            NSDictionary *dic=(NSDictionary*)responseData;
            if ([dic[@"sysmodel"][@"blresult"] intValue]) {
                [self showHint:@"发表成功!"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } Fail:^(id erro) {
        
    }];
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
