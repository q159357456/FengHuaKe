//
//  ZWHScanViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/31.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHScanViewController.h"

@interface ZWHScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

//中心视图
@property (nonatomic, strong) UIView *centerView;

@end

@implementation ZWHScanViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫扫更健康";
    [self creatUI];
    
    [self setTypeUI];
}

-(UIImage *)navigationBarShadowImage{
    return [UIImage new];
}
-(UIImage *)navigationBarBackgroundImage{
    return [UIImage new];
}

#pragma marl - 样式自定义
-(void)setTypeUI{
    UIColor *backColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    
    _centerView = [[UIView alloc]init];
    _centerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _centerView.layer.borderWidth = 1;
    _centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(WIDTH_PRO(200));
    }];
    
    //左边视图 可以自定义
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = backColor;
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.right.equalTo(_centerView.mas_left);
        make.bottom.equalTo(_centerView.mas_bottom);
    }];
    
    //右边边视图
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = backColor;
    [self.view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.left.equalTo(_centerView.mas_right);
        make.bottom.equalTo(_centerView.mas_bottom);
    }];
    
    //顶部视图
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = backColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(rightView.mas_left);
        make.bottom.equalTo(_centerView.mas_top);
        make.left.equalTo(leftView.mas_right);
    }];
    
    //底部视图
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = backColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark - 创建影像图层
-(void)creatUI{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        //直接跳转到 【设置-隐私-照片】
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                        message:errorStr
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                             NSURL *url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                             [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
                                                         }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        // 1、获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // 2、创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        // 3、创建输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        
        // 4、设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        NSLog(@"-----------6");
        
        // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
        // 注：微信二维码的扫描范围是整个屏幕， 这里并没有做处理（可不用设置）
        output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
        
        // 5、 初始化链接对象（会话对象）
        self.session = [[AVCaptureSession alloc] init];
        // 高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        NSLog(@"-----------7");
        
        // 5.1 添加会话输入
        [_session addInput:input];
        NSLog(@"-----------7。1");
        
        // 5.2 添加会话输出
        [_session addOutput:output];
        NSLog(@"-----------7.2");
        
        // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
        // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        NSLog(@"-----------7.3");
        
        // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = self.view.layer.bounds;
        
        // 8、将图层插入当前视图
        [self.view.layer insertSublayer:_previewLayer atIndex:0];
        NSLog(@"-----------8");
        
        // 9、启动会话
        [_session startRunning];
        
    }
}


@end
