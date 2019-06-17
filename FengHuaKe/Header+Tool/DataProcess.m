//
//  DataProcess.m
//  ZHONGHUILAOWU
//
//  Created by 工博计算机 on 17/9/26.
//  Copyright © 2017年 gongbo. All rights reserved.
//

#import "DataProcess.h"
#import "NSDate+Extension.h"
#import "NSString+Addition.h"
#import "NetDataTool.h"
#define key @"userNameStore"
#define picpath @"http://img.fhtx.onedft.cn/"
//密文
#define CIPHERTEXT @"R0IyMDE4QEZlbmdodWFDYWxs-sign-"
//
NSString* dosome(){
    return @"something";
}
@implementation DataProcess
+(DataProcess*) shareInstance
{
    static dispatch_once_t onceToken;
    static DataProcess *instance=nil;
    dispatch_once(&onceToken, ^{
        instance=[[DataProcess alloc]init];
        
    });
    return instance;
}
/**
 获取支付类型
 */
+(NSString *)getPayCommandWithType:(NSInteger)type
{
    switch (type) {
        case hotel:
            return @"hotel";
            break;
            
        case insure:
            return @"insure";
            break;
            
        case travel:
            return @"travel";
            break;
            
        case store:
            return @"store";
            break;
            
        case tickets:
            return @"tickets";
            break;
            
            
    }
    return @"";
}
+(void)showWarnProgress:(NSString *)progress
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showInfoWithStatus:progress];
}
+(void)showSuccessProgress:(NSString *)progress
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showSuccessWithStatus:progress];
}
/*
 */
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText Color:(UIColor*)color {
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0f] range:hightlightTextRange];
        //        self.currentTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        //        self.currentTitleLabel.attributedText = attributeStr;
        return attributeStr;
    }else {
        return [highlightText copy];
    }
}
/*
 电话
 */
+(void)callWithPhone:(NSString*)phone
{
    NSString *urlStr=[NSString stringWithFormat:@"tel://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
/*
 短息
 */
+(void)writToPhone:(NSString*)phone
{
    NSString *urlStr=[NSString stringWithFormat:@"sms:%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

//
/**
 使用钥匙串 －－添加
 */

+(void)addToKeychainWithValue:(NSString*)value
{
    
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *dict = @{
                           (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                           (__bridge id)kSecAttrService:service,
                           (__bridge id)kSecAttrAccount:key,
                           (__bridge id)kSecValueData:valueData
                           };
    CFTypeRef typeResult = NULL;
    OSStatus state =  SecItemAdd((__bridge CFDictionaryRef)dict, &typeResult);
    if (state == errSecSuccess) {
        NSLog(@"store secceed");
    }else
    {
        NSLog(@"store faild");
    }
    
}

/**
 使用钥匙串 －－更新
 */
+(void)updateDataWithNewValue:(NSString*)newValue
{
    
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queue = @{
                            (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:server,
                            (__bridge id)kSecAttrAccount:key
                            };
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queue, NULL);
    //存在修改
    if (state == errSecSuccess) {
        
        NSData *newData = [newValue dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *paramDict = @{
                                    (__bridge id)kSecValueData:newData
                                    };
        OSStatus updateState = SecItemUpdate((__bridge CFDictionaryRef)queue, (__bridge CFDictionaryRef)paramDict);
        if (updateState == errSecSuccess) {
            NSLog(@"更新成功");
        }
    }
}
/**
 使用钥匙串 －－查询
 */
+(NSString*)findData
{
    
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queueDict = @{
                                (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecAttrService:server,
                                (__bridge id)kSecAttrAccount:key,
                                (__bridge id)kSecReturnData:(__bridge id)kCFBooleanTrue
                                /*(__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitAll
                                 当为kSecMatchLimit时，SecItemCopyMatching第二个参数为CFArrayRef，元素为CFDataRef*/
                                };
    CFDataRef dataRef = NULL;
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queueDict, (CFTypeRef*)&dataRef);
    if (state == errSecSuccess) {
        NSString *value = [[NSString alloc] initWithData:(__bridge_transfer NSData*)dataRef encoding:NSUTF8StringEncoding];
        return value;
    }else
    {
        return nil;
    }
}


/**
 使用钥匙串 －－删除
 */
+(void)deletFromKeychain
{
    NSString *server = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *queue = @{
                            (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService:server,
                            (__bridge id)kSecAttrAccount:key
                            };
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)queue, NULL);
    //存在
    if (state == errSecSuccess) {
        OSStatus deleteState = SecItemDelete((__bridge CFDictionaryRef)queue);
        if (deleteState == errSecSuccess) {
            NSLog(@"删除成功!!!");
        }
        
        
    }
}

/**
 md5加密
 */
+(NSString*)getMD5TextWithStr:(NSString*)text
{
    
    
    //4.md5加密
    const char *cStr =[text UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5Str=[NSString stringWithFormat:
                      @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    NSLog(@"%@",md5Str);
    
    return [md5Str uppercaseString];
}
+(NSString*)getCurrrntDate
{
    NSDate *dateNow = [NSDate date];
    //2.转化成字符串的类型
    NSString *dateStr=[dateNow stringWithFormat:@"yyyyMMddHHmmssSSS"];
    return dateStr;
}
- (NSString *)md5_32bitWithStr:(NSString*)text {
    const char *cStr = [text UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)text.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

- (NSString *)MD5_32BITWithStr:(NSString*)text {
    const char *cStr = [text UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)text.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02X", digest[i]];
    return result;
}

+(NSString*)getJsonStrWithObj:(id)obj
{
    NSData *data1=[NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
    return jsonStr;
}
+(NSString*)getSignWithEndindex:(NSString*)endindex querytype:(NSString*)querytype Startindex:(NSString*)startindex Timestamp:(NSString*)timestamp
{
    endindex=endindex==nil?@"-1":endindex;
    querytype=querytype==nil?@"0":querytype;
    startindex=startindex==nil?@"-1":startindex;
    NSString *chi=CIPHERTEXT;
    NSString *str=[NSString stringWithFormat:@"%@endindex=%@&querytype=%@&startindex=%@&timestamp=%@",chi,endindex,querytype,startindex,timestamp];
    NSLog(@"%@",str);
    //
    //4.md5加密
    const char *cStr =[str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5Str=[NSString stringWithFormat:
                      @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    
    
    return md5Str;
    
}
+(NSString*)getParseWithStr:(NSString*)parse
{
    
    NSString *left=@"\"{";
    NSString *right=@"}\"";
    NSString *substr=[parse stringByReplacingOccurrencesOfString:left withString:@"{"];
    NSString *substr1=[substr stringByReplacingOccurrencesOfString:right withString:@"}"];
    NSString *left1=@"\"[";
    NSString *right1=@"]\"";
    NSString *substr2=[substr1 stringByReplacingOccurrencesOfString:left1 withString:@"["];
    NSString *substr3=[substr2 stringByReplacingOccurrencesOfString:right1 withString:@"]"];
//    NSMutableString *str=[NSMutableString stringWithString:substr3];
//    NSLog(@"str===>%@",str);
//    NSString *character = nil;
//    for (int i = 0; i < str.length; i ++) {
//        character = [str substringWithRange:NSMakeRange(i, 1)];
//        if ([character isEqualToString:@"\\"])
//            [str deleteCharactersInRange:NSMakeRange(i, 1)];
//    }
//    NSMutableString *str=[NSMutableString stringWithString:parse];
//    [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSString * result = [substr3 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return result;
    
    
}
/**
 获取json值
 */
+(NSDictionary*)getJsonWith:(NSData*)responseObject
{
    NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    return dic1;
}


+(NSString*)PicAdress:(NSString*)str
{
    
    NSString *addStr=[NSString stringWithFormat:@"%@%@",picpath,str];
    
    return addStr ;
}

/**
 相机/相册操作
 */
-(void)choosePhotoWithBlock:(PhotopBlock)phtoBlock;
{
    UIViewController *vc=[self topViewController];
    self.photoBlock=phtoBlock;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用照相机
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.delegate=self;
        picker.allowsEditing=YES;
        [vc presentViewController:picker animated:YES completion:nil];
        
    }];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用相册
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        picker.allowsEditing=YES;
        [vc presentViewController:picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [vc presentViewController:alert animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.photoBlock(image);
    
}

#pragma mark private
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
+(UIImage*)barImage
{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColorFromRGB(0x4BA4FF) CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*)clearImage
{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
}


+(NSString*)getRequestStrDataList:(NSArray*)datalist Sysmodel:(NSDictionary*)sysmode Strat:(NSNumber*)start End:(NSNumber*)end Type:(NSString*)type{
    NSString *time=[DataProcess getCurrrntDate];
    NSString *signStr;
    if (start==nil || end==nil) {
        signStr=[DataProcess getSignWithEndindex:nil querytype:nil Startindex:nil Timestamp:time];
    }else{
        signStr=[DataProcess getSignWithEndindex:[end stringValue] querytype:type Startindex:[start stringValue] Timestamp:time];
    }
    NSArray *a = datalist==nil?@[]:datalist;
    NSDictionary *d = sysmode==nil?@{}:sysmode;
    NSString *jsonpara=[DataProcess getJsonStrWithObj:d];
    NSString *lsitpara = [DataProcess getJsonStrWithObj:a];
    NSString *s = start==nil?@"-1":[start stringValue];
    NSString *e = end==nil?@"-1":[end stringValue];
    NSString *t = type==nil?@"0":type;
    
    NSDictionary *dic=@{@"DataList":lsitpara,@"sysmodel":jsonpara,@"endindex": e,@"startindex":s,@"querytype":t,@"timestamp":time,@"sign":signStr};
    NSString *dicjson=[DataProcess getJsonStrWithObj:dic];
    NSString *requestStr=[DataProcess getParseWithStr:dicjson];
    return requestStr;
    
}

//通用请求
+(void)requestDataWithURL:(NSString*)url RequestStr:(NSString*)requestStr Result:(void(^)(id  obj,id erro))result{
    
    [[NetDataTool shareInstance]getNetData:PAPATH url:url With:requestStr and:^(id responseObject) {
        NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"strresult==>%@",dic1);
        if ([dic1[@"sysmodel"][@"blresult"] integerValue] == 1) {
             result(dic1,nil);
        }else
        {
            result(nil,dic1);
//            [SVProgressHUD setMinimumDismissTimeInterval:1];
//            [SVProgressHUD showErrorWithStatus:dic1[@"sysmodel"][@"strresult"]];

        }
       
    } Faile:^(NSError *error) {
        
        result(nil,error);
    }];
    
}

+(void)sd_imageCacheDefine:(UIView*)view ImageURL:(NSString*)imageurl{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_IMG,imageurl];
//    NSLog(@"url==>%@",url);
    if ([view.class isEqual:[UIImageView class]]) {
        UIImageView *imageview = (UIImageView*)view;
        [imageview  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        
    }else if ([view.class isEqual:[UIButton class]]){
        
        UIButton *btn = (UIButton*)view;
        [btn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    }else
    {
            NSAssert(nil, @"class不匹配");
    }
    
}
@end
