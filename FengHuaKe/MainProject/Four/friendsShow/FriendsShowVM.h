//
//  FriendsShowVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/2.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface FriendsShowVM : NSObject
/**
 获取朋友圈资料
 */
+(void)DynamicGetFriendCirclePara1:(NSString*)para1 Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

/**
 发表朋友圈 纯文字
 */
+(void)DynamicPublishDynamicSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;

/**
 发表朋友圈 文字+图片/只有图片
 */
+(void)DynamicPublishDynamicImagesSysmodel:(NSString*)sysmodel DataArray:(NSArray*)dataArray Success:(Success)Success Fail:(Fail)fail;


/**
获取单个的朋友圈动态
 */
+(void)DynamicSingleDynamicPara1:(NSString*)para1 Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;


/**
 点赞 
 */
+(void)DynamicLikeSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;


/**
 评论
 */
+(void)DynamicCommentAddDataList:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail;

/**
获取相册列表 分页
 Parameter content type:
 para1:谁获取的；para2：获取谁的
 */
+(void)DynamicPhotosSysmodel:(NSString*)sysmodel  Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

/**
 获取照片列表 分页
 para1:获取哪个相册的；para2：获取谁的
 */
+(void)DynamicPictureSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;


/**
  往相册中上传照片
 */
+(void)DynamicPictureAddSysmodel:(NSString*)sysmode DataArray:(NSArray*)dataArray Success:(Success)Success Fail:(Fail)fail;


/**
 相册添加、返回当前相册
 DataList.memberid：相册所属人，DataList.name：相册名称
 */
+(void)DynamicPhotosAddDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail;


/**
 删除照片[批量提交]
code：照片ID，memberid：操作人ID，parenttype：照片类型【P：相册；D：朋友圈；G：到此一游】，parentid：上级ID
*/
+(void)DynamicPictureDelDataList:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail;
/**
 删除相册[批量提交]
 code：相册ID，memberid：操作人ID
 */

+(void)DynamicPhotosDelDataList:(NSString*)dataList  Success:(Success)Success Fail:(Fail)fail;

/**
 评论删除
 sysmodel.para1：评论ID，sysmodel.para2：上级动态ID，sysmodel.para3：评论类型（W:我行我素；P:照片；C:评论；S:商品），sysmodel.para4：操作人ID
 */
+(void)DynamicCommentDelSysmodel:(NSString*)sysmode Success:(Success)Success Fail:(Fail)fail;


/**
 
删除动态
sysmodel.para1：动态ID，sysmodel.para2：操作人ID
 */
+(void)DynamicDynamicDelSysmodel:(NSString*)sysmode Success:(Success)Success Fail:(Fail)fail;
@end
