//
//  UpLoadPicToPhotoVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "UpLoadPicToPhotoVC.h"
#import "PublishCollectionViewCell.h"
#import "UITextView+PlaceHolder.h"
#import "UIViewController+HUD.h"
#import "ChoosePhotoVC.h"
#import "FriendsShowVM.h"
static NSString *imageStr=@"add";
@interface UpLoadPicToPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *photoName;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIView *choosePhotoView;

//参数
@property(nonatomic,copy)NSString *code;

@end

@implementation UpLoadPicToPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"上传照片";
    [_textview addPlaceHolder:@"发表点什么。。。。"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PublishCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishCollectionViewCell"];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePhoto)];
    _choosePhotoView.userInteractionEnabled=YES;
    [_choosePhotoView addGestureRecognizer:tap];
    [self rightItem];
}
-(void)rightItem
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,25)];
    [rightButton setTitle:@"上传" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightCustomView = [[UIView alloc] initWithFrame: rightButton.frame];
    [rightCustomView addSubview: rightButton];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightCustomView];
    self.navigationItem.rightBarButtonItem=rightItem;
}
#pragma mark - action
-(void)upload
{
    NSMutableArray *array=[NSMutableArray arrayWithArray:self.dataArray];
    [array removeLastObject];
    if (self.code.length==0) {
        [self showHint:@"请选择相册!"];
        return;
    }
    if (_textview.text==0) {
        _textview.text=@"";
    }
    if (array.count==0) {
        [self showHint:@"请选择照片!"];
        
        return;
    }
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.code,@"para2":UniqUserID,@"para3":@"0",@"para4":@"0",@"para5":@"",@"para6":_textview.text,@"blresult":@"true"}];
    DefineWeakSelf;
    [FriendsShowVM DynamicPictureAddSysmodel:sysmodel DataArray:array Success:^(id responseData){
        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
           
            [weakSelf showHint:@"上传成功!"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
        
        }
        
    } Fail:^(id erro) {
//        NSLog(@"!%@",erro);
    }];
}
-(void)choosePhoto
{
    ChoosePhotoVC *vc=[[ChoosePhotoVC alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    DefineWeakSelf;
    vc.backBlock=^(UIImage *coverImage, NSString *name,NSString *photoCode){
        weakSelf.photoImage.image=coverImage;
        weakSelf.photoName.text=name;
        weakSelf.code=photoCode;
    };
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark - upload/net


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
            [weakSelf.collectionView reloadData];
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


@end
