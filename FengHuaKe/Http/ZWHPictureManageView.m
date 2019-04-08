//
//  ZWHPictureManageView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPictureManageView.h"
#import "ZWHShowPViewController.h"
#import "ZWHBaseNavigationViewController.h"
#import "ZWHAlbumViewController.h"
#import "GBNavigationController.h"
#import <SDWebImage/UIButton+WebCache.h>

#define NormalImagePickingTag 1045
#define ModifiedImagePickingTag 1046
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048

static QMUIAlbumContentType const kAlbumContentType = QMUIAlbumContentTypeOnlyPhoto;

@interface ZWHPictureManageView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QMUIImagePreviewViewDelegate,QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate,QMUIImagePickerPreviewViewControllerDelegate>

//一共可以选多少张图片
@property(nonatomic,assign)NSInteger pictureNum;
//每行多少张
@property(nonatomic,assign)NSInteger rowNum;

//每张图片的宽高
@property(nonatomic,assign)CGFloat pictureWid;



@property(nonatomic, strong) QMUIFloatLayoutView *floatLayoutView;
//选择按钮
@property(nonatomic, strong) QMUIButton *chooseBtn;

//根视图
@property(nonatomic, strong) UIViewController *rootVc;

@property(nonatomic, strong) ZWHShowPViewController *imagePreviewViewController;

@property(nonatomic, strong) ZWHAlbumViewController *albumViewController;


//通过这按钮进入图片展示
@property(nonatomic, strong) QMUIButton *showBtn;
//网络加载时保存展示图片的按钮
@property(nonatomic, strong) NSMutableArray *showPictureBtnArr;

@end

@implementation ZWHPictureManageView

- (instancetype)initWithNum:(NSInteger)num withRowNum:(NSInteger)rownum
{
    self = [super init];
    if (self) {
        _pictureNum = num;
        _rowNum = rownum;
        _pictureDataArr = [NSMutableArray array];
        _pictureWid = (SCREEN_WIDTH-8*(_rowNum+1))/_rowNum;
        _rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    UIImageView *title = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"相机"]];
    title.tintColor = MAINCOLOR;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(8);
        make.width.height.mas_offset(20);
    }];
    [title layoutIfNeeded];
    
    self.floatLayoutView = [[QMUIFloatLayoutView alloc] init];
    self.floatLayoutView.padding = UIEdgeInsetsMake(8, 8, 8, 8);
    self.floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 8, 8);
    self.floatLayoutView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
    self.floatLayoutView.layer.borderWidth = PixelOne;
    self.floatLayoutView.layer.borderColor = UIColorSeparator.CGColor;
    
    self.floatLayoutView.minimumItemSize = CGSizeMake(_pictureWid, _pictureWid);
    self.floatLayoutView.maximumItemSize = CGSizeMake(_pictureWid, _pictureWid);
    [self addSubview:self.floatLayoutView];
    [self.floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(title.mas_bottom).offset(3);
    }];
    
    
    [self.floatLayoutView addSubview:self.chooseBtn];
    
    [self refreshFrame];
}

//重新布局
-(void)refreshView{
    [self.floatLayoutView qmui_removeAllSubviews];
    if (_pictureDataArr.count>0) {
        _showPictureBtnArr = [NSMutableArray array];
        for (NSInteger i=0;i<_pictureDataArr.count;i++) {
            UIImage *img = _pictureDataArr[i];
            QMUIButton *imgbtn = [[QMUIButton alloc]init];
            [imgbtn setImage:img forState:0];
            imgbtn.tag = i;
            imgbtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.floatLayoutView addSubview:imgbtn];
            [imgbtn addTarget:self action:@selector(showPitrueWithbtn:) forControlEvents:UIControlEventTouchUpInside];
            //删除按钮
            QMUIButton *cancelbtn = [[QMUIButton alloc]init];
            [cancelbtn setImage:[UIImage imageNamed:@"关闭"] forState:0];
            cancelbtn.tag = i;
            cancelbtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imgbtn addSubview:cancelbtn];
            [cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(imgbtn);
                make.width.height.mas_equalTo(15);
            }];
            [cancelbtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            [_showPictureBtnArr addObject:imgbtn];
        }
        if (_pictureDataArr.count<_pictureNum) {
            [self.floatLayoutView addSubview:self.chooseBtn];
        }
    }else{
        [self.floatLayoutView addSubview:self.chooseBtn];
    }
    [self refreshFrame];
}

//刷新frame
-(void)refreshFrame{
    CGSize floatLayoutViewSize = [self.floatLayoutView sizeThatFits:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)];
    self.frame =CGRectMake(0, 0, SCREEN_WIDTH, floatLayoutViewSize.height+35);
    if (_changeBclok) {
        _changeBclok(floatLayoutViewSize.height+35);
    }
    
}



#pragma mark - 根据URL展示图片
-(void)setPictureURLArr:(NSArray *)pictureURLArr{
    _pictureURLArr = pictureURLArr;
    [self refreshURLView];
}

//根据URL重新布局
-(void)refreshURLView{
    [self.floatLayoutView qmui_removeAllSubviews];
    if (_pictureURLArr.count>0) {
        _showPictureBtnArr = [NSMutableArray array];
        for (NSInteger i=0;i<_pictureURLArr.count;i++) {
            NSString *url = _pictureURLArr[i];
            QMUIButton *imgbtn = [[QMUIButton alloc]init];
            [imgbtn sd_setImageWithURL:[NSURL URLWithString:url] forState:0 placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
            imgbtn.tag = i;
            imgbtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.floatLayoutView addSubview:imgbtn];
            [imgbtn addTarget:self action:@selector(showPitrueWithbtn:) forControlEvents:UIControlEventTouchUpInside];
            [_showPictureBtnArr addObject:imgbtn];
        }
    }
    [self refreshFrame];
}


#pragma mark - 删除
-(void)deletePicture:(QMUIButton *)btn{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        [_pictureDataArr removeObjectAtIndex:btn.tag];
        [self refreshView];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}



#pragma mark - 显示图片
-(void)showPitrueWithbtn:(QMUIButton *)btn{
    if (!self.imagePreviewViewController) {
        self.imagePreviewViewController = [[ZWHShowPViewController alloc] init];
        self.imagePreviewViewController.imagePreviewView.delegate = self;
        self.imagePreviewViewController.imagePreviewView.currentImageIndex = btn.tag;// 默认查看的图片的 index
        MJWeakSelf;
        //拖拽手势 点击手势回调
        self.imagePreviewViewController.customGestureExitBlock = ^(QMUIImagePreviewViewController *aImagePreviewViewController, QMUIZoomImageView *currentZoomImageView) {
            weakSelf.showBtn = weakSelf.showPictureBtnArr[aImagePreviewViewController.imagePreviewView.currentImageIndex];
            [aImagePreviewViewController exitPreviewToRectInScreenCoordinate:[weakSelf.showBtn convertRect:weakSelf.showBtn.imageView.frame toView:nil]];
        };
    }
    NSLog(@"%ld",btn.tag);
    _showBtn = btn;
    self.imagePreviewViewController.imagePreviewView.currentImageIndex = btn.tag;
    [self.imagePreviewViewController startPreviewFromRectInScreenCoordinate:[btn convertRect:btn.frame toView:nil] cornerRadius:btn.layer.cornerRadius];
    
}

#pragma mark - <QMUIImagePreviewViewDelegate>

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    if (_pictureURLArr.count>0) {
        return _pictureURLArr.count;
    }
    return _pictureDataArr.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    if (_pictureURLArr.count>0) {
        QMUIButton *btn = _showPictureBtnArr[index];
        zoomImageView.image = btn.imageView.image;
        return;
    }
    zoomImageView.image = self.pictureDataArr[index];
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
    if (_pictureURLArr.count > 0) {
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



#pragma mark - 选择图片
-(void)changeImage{
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"选择类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *pz = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImageWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *xc = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.albumViewController = [[ZWHAlbumViewController alloc] init];
        self.albumViewController.albumViewControllerDelegate = self;
        self.albumViewController.contentType = kAlbumContentType;
        QMUICMI.navBarTintColor = [UIColor whiteColor];
        _albumViewController.view.tag = NormalImagePickingTag;
        ZWHBaseNavigationViewController *navigationController = [[ZWHBaseNavigationViewController alloc] initWithRootViewController:self.albumViewController];
        // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
        [_albumViewController pickLastAlbumGroupDirectlyIfCan];
        [_rootVc presentViewController:navigationController animated:YES completion:NULL];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [aler addAction:pz];
    [aler addAction:xc];
    [aler addAction:cancel];
    [_rootVc presentViewController:aler animated:YES completion:nil];
}

#pragma mark -调用相机，选择图片
-(void)chooseImageWithType:(UIImagePickerControllerSourceType)type{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = type;
    [_rootVc presentViewController:imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    MJWeakSelf;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [weakSelf.pictureDataArr addObject:image];
    [weakSelf refreshView];
}

#pragma mark - <QMUIAlbumViewControllerDelegate>

- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.maximumSelectImageCount = _pictureNum-_pictureDataArr.count;
    imagePickerViewController.view.tag = albumViewController.view.tag;
    imagePickerViewController.minimumImageWidth = 65;
    [imagePickerViewController.sendButton setTitle:@"选择" forState:0];
    return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>

- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerViewController.assetsGroup ablumContentType:kAlbumContentType userIdentify:nil];
    
    [self sendImageWithImagesAssetArray:imagesAssetArray];
}

-(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController{
    QMUIImagePickerPreviewViewController *imagePickerPreviewViewController = [[QMUIImagePickerPreviewViewController alloc] init];
    imagePickerPreviewViewController.delegate = self;
    imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
    //imagePickerPreviewViewController.toolBarBackgroundColor = [UIColor redColor];
    return imagePickerPreviewViewController;
}

#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

// 更新选中的图片数量
- (void)updateImageCountLabelForPreviewView:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
}


#pragma mark - getter
/*-(ZWHAlbumViewController *)albumViewController{
    if (!_albumViewController) {
        // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
        _albumViewController = [[ZWHAlbumViewController alloc] init];
        _albumViewController.albumViewControllerDelegate = self;
        _albumViewController.contentType = kAlbumContentType;
        QMUICMI.navBarTintColor = [UIColor whiteColor];
        _albumViewController.view.tag = NormalImagePickingTag;
    }
    return _albumViewController;
}*/

-(QMUIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [[QMUIButton alloc]init];
        [_chooseBtn setImage:[UIImage imageNamed:@"加"] forState:0];
        _chooseBtn.tintColorAdjustsTitleAndImage = MAINCOLOR;
        _chooseBtn.imageView.contentMode = UIViewContentModeCenter;
        _chooseBtn.qmui_borderColor = MAINCOLOR;
        _chooseBtn.qmui_borderWidth = 1;
        _chooseBtn.qmui_borderPosition = QMUIViewBorderPositionTop|QMUIViewBorderPositionLeft|QMUIViewBorderPositionRight|QMUIViewBorderPositionBottom;
        [_chooseBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

#pragma mark - 业务方法


- (void)startLoading {
    [QMUITips showLoadingInView:self];
}

- (void)startLoadingWithText:(NSString *)text {
    [QMUITips showLoading:text inView:self];
}

- (void)stopLoading {
    [QMUITips hideAllToastInView:self animated:YES];
}

- (void)showTipLabelWithText:(NSString *)text {
    [self stopLoading];
    [QMUITips showWithText:text inView:self hideAfterDelay:1.0];
}

- (void)hideTipLabel {
    [QMUITips hideAllToastInView:self animated:YES];
}



- (void)sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    for (QMUIAsset *asset in imagesAssetArray) {
        [_pictureDataArr addObject:asset.originImage];
    }
    [self refreshView];
}



@end
