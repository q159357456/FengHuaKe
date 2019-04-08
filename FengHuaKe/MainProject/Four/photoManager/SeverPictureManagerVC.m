//
//  SeverPictureManagerVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "SeverPictureManagerVC.h"
#import "PictureManagerCell.h"
#import "FriendsShowVM.h"
#import "PictureManagerModel.h"
#import "PhotoBrowser.h"
#import "UIViewController+HUD.h"
#import "ZWHShowPViewController.h"
#import "ZWHUploadPictureViewController.h"

@interface SeverPictureManagerVC ()<PhotoBrowserDelegate,QMUIImagePreviewViewDelegate>
{
    UIButton *_buttton;
    BOOL isopen;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic, strong)ZWHShowPViewController *imagePreviewViewController;
@end

@implementation SeverPictureManagerVC

static NSString * const reuseIdentifier = @"PictureManagerCell";
- (instancetype)init{
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    // 定义大小
    layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = 2;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 2;
    // 设置滚动方向（默认垂直滚动）
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
    return [self initWithCollectionViewLayout:layout];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"照片";
    _dataArray=[NSMutableArray array];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureManagerCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.delegate=self;
    
    [self rightItem];
    [self setRefresh];
    NOTIFY_ADD(zwhRefreshPicture, NOTIF_PICTURE);
}

#pragma mark - 通知刷新
-(void)zwhRefreshPicture{
    [self.collectionView.mj_header beginRefreshing];
}

-(void)dealloc{
    NOTIFY_REMOVEALL;
}

#pragma mark - 添加
-(void)zwhAddPicture{
    ZWHUploadPictureViewController *vc = [[ZWHUploadPictureViewController alloc]init];
    vc.model = _model;
    vc.code = _model.code;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - ui
-(void)rightItem
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,25)];
    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(manager:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightCustomView = [[UIView alloc] initWithFrame: rightButton.frame];
    [rightCustomView addSubview: rightButton];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightCustomView];
    
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [addButton addTarget:self action:@selector(zwhAddPicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,[[UIBarButtonItem alloc] initWithCustomView:addButton]];
}
-(void)showButton
{
   
    if (!_buttton) {
       _buttton=[UIButton new];
        _buttton.backgroundColor=MainColor;
        [_buttton setTitle:@"删除" forState:UIControlStateNormal];
        [_buttton addTarget:self action:@selector(delet)
           forControlEvents:UIControlEventTouchUpInside];
    }
     [self.view addSubview:_buttton];
    if (isopen) {
        _buttton.frame = CGRectMake(0, ScreenHeight-64-50, ScreenWidth,50);
    }else
    {
        [_buttton  setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 0)];
    }
    
   
}


#pragma mark - action
-(void)delet
{
    [self deletpic];
}
-(void)manager:(UIButton*)butt
{
 
    isopen=!isopen;
    if (!isopen)
    {
        

        [butt setTitle:@"管理" forState:UIControlStateNormal];
     
    
        
    }else
    {
        

           [butt setTitle:@"取消" forState:UIControlStateNormal];
   
    }
    [self.collectionView reloadData];
    [self showButton];
    
}
#pragma mark- -net

-(void)getDataSource{
    NSNumber *startIndex = [NSNumber numberWithInteger:_index];
    MJWeakSelf
    [HttpHandler getDynamicPicture:@{@"para1":self.code,@"para2":UniqUserID} start:startIndex end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            if (ary.count == 0) {
                [weakSelf.collectionView.mj_header endRefreshing];
                weakSelf.collectionView.mj_footer.hidden = YES;
            }else{
                [weakSelf.dataArray addObjectsFromArray: [PictureManagerModel mj_objectArrayWithKeyValuesArray:ary]];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshing];
                weakSelf.collectionView.mj_footer.hidden = NO;
            }
            [weakSelf.collectionView reloadData];
        }
    } failed:^(id obj) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

-(void)setRefresh{
    MJWeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArray = [NSMutableArray array];
        weakSelf.index = 1;
        [weakSelf getDataSource];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.index ++ ;
        [weakSelf getDataSource];
    }];
    [self.collectionView.mj_header beginRefreshing];
}


//删除照片
-(void)deletpic
{
    // code：照片ID，memberid：操作人ID，parenttype：照片类型【P：相册；D：朋友圈；G：到此一游】，parentid：上级ID
    NSMutableArray *seleArray=[NSMutableArray array];
    for (PictureManagerModel *model in self.dataArray) {
        if (model.isSelected) {
            [seleArray addObject:model];
        }
        continue;
    }
    if (seleArray.count==0) {
        [self showHint:@"请选中要删除的图片!"];
        return;
    }
    NSMutableArray *datalistArray=[NSMutableArray array];
    for (PictureManagerModel *model in seleArray) {
        NSDictionary *dic=@{@"code":model.code,@"memberid":model.memberid,@"parenttype":@"P",@"parentid":model.parentid};
        [datalistArray addObject:dic];
    }
    NSString *datalistStr=[DataProcess getJsonStrWithObj:datalistArray];
    DefineWeakSelf;
    [FriendsShowVM DynamicPictureDelDataList:datalistStr Success:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
        NSDictionary *dic=(NSDictionary*)responseData;
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            
            [weakSelf showHint:@"删除成功!"];
            [weakSelf.dataArray removeObjectsInArray:seleArray];
            [weakSelf.collectionView reloadData];
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
        
    } Fail:^(id erro) {
        
    }];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureManagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PictureManagerModel *model=self.dataArray[indexPath.item];
    // Configure the cell
    if (isopen)
    {
        if (model.isSelected)
        {
            cell.selectedImage.image=[UIImage imageNamed:@"picture_seleted"];
        }else
        {
            cell.selectedImage.image=[UIImage imageNamed:@"picture_selet"];
        }
        
    }else
    {
        cell.selectedImage.image=nil;
    }

    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    cell.imageview.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}
//设置section的上左下右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上  左   下  右
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth-40)/3,(ScreenWidth-40)/3);
    
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

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isopen)
    {
        PictureManagerModel *model=self.dataArray[indexPath.item];
        model.isSelected=!model.isSelected;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }else
    {
        //大图
        /*PhotoBrowser *browser = [[PhotoBrowser alloc] init];
        browser.currentImageIndex = indexPath.row;
        browser.sourceImagesContainerView = self.collectionView;
        browser.imageCount = self.dataArray.count;
        browser.delegate = self;
        [browser show];*/
        
        
        if (!self.imagePreviewViewController) {
            self.imagePreviewViewController = [[ZWHShowPViewController alloc] init];
            self.imagePreviewViewController.imagePreviewView.delegate = self;
            self.imagePreviewViewController.imagePreviewView.currentImageIndex = indexPath.isProxy;// 默认查看的图片的 index
            MJWeakSelf;
            //拖拽手势 点击手势回调
            
            self.imagePreviewViewController.customGestureExitBlock = ^(QMUIImagePreviewViewController *aImagePreviewViewController, QMUIZoomImageView *currentZoomImageView) {
                PictureManagerCell *cell = (PictureManagerCell *)[weakSelf.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:aImagePreviewViewController.imagePreviewView.currentImageIndex inSection:0]];
                [aImagePreviewViewController exitPreviewToRectInScreenCoordinate:[cell convertRect:cell.imageview.frame toView:nil]];
            };
        }
        PictureManagerCell *cell = (PictureManagerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        self.imagePreviewViewController.imagePreviewView.currentImageIndex = indexPath.item;
        [self.imagePreviewViewController startPreviewFromRectInScreenCoordinate:[cell convertRect:cell.frame toView:nil] cornerRadius:cell.layer.cornerRadius];
    }
    
    
}

#pragma mark - <QMUIImagePreviewViewDelegate>

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return _dataArray.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    PictureManagerCell *cell = (PictureManagerCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    zoomImageView.image = cell.imageview.image;
}

- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index {
    return QMUIImagePreviewMediaTypeImage;
}
#pragma mark - <QMUIZoomImageViewDelegate>

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView location:(CGPoint)location {
    self.imagePreviewViewController.customGestureExitBlock(self.imagePreviewViewController, zoomImageView);
}

-(void)longPressInZoomingImageView:(QMUIZoomImageView *)zoomImageView{
    NSLog(@"长按手势");
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"" message:@"是否保存图片？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"保存");
        UIImage *img = zoomImageView.image;
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alvc addAction:act1];
    [alvc addAction:act2];
    [self.imagePreviewViewController presentViewController:alvc animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (error==nil){
        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self.imagePreviewViewController presentViewController:alvc animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alvc dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }else{
        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self.imagePreviewViewController presentViewController:alvc animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alvc dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    NSIndexPath *path=[NSIndexPath indexPathForItem:index inSection:0];
    PictureManagerCell *cell=(PictureManagerCell*)[self.collectionView cellForItemAtIndexPath:path];
    UIImageView *imageView = cell.imageview;
    return imageView.image;
}
@end
