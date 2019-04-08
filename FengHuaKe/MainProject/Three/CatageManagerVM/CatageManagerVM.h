//
//  CatageManagerVM.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseData);
typedef void (^Fail)(id erro);
@interface CatageManagerVM : NSObject
//Sysmodel:(NSString*)sysmodel  DataList:(NSString*)dataList
/**
 获取新闻列表，分页
 */
+(void)NewNewsStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

/**
 获取游记列表，分页
 */
+(void)NewNotesStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

/**
 获取攻略列表，分页
 */
+(void)NewGuidesStartindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;
/**
 获取单笔新闻
 sysmodel.para1:新闻代码,sysmodel.para2:会员ID
 */
+(void)NewSingleSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;

/**
 获取某一会员的游记
 sysmodel.para1:会员ID
 */
+(void)NewMyNotesSysmodel:(NSString*)sysmodel Startindex:(NSString*)startindex Endindex:(NSString*)endindex Success:(Success)Success Fail:(Fail)fail;

/**
 游记发表
 DataList.title：标题；DataList.tips：标签；DataList.content：内容；DataList.createuser：会员ID；DataList.fromdate：公布时间
 */
+(void)NewAddNotesDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail;

/**
 游记编辑
 DataList.code：代码；DataList.title：标题；DataList.tips：标签；DataList.content：内容；DataList.createuser：会员ID；DataList.fromdate：公布时间
 */
+(void)NewEditorNotesDataList:(NSString*)dataList Success:(Success)Success Fail:(Fail)fail;


/**
 游记删除
 sysmodel.para1：游记代码
 */
+(void)NewDelNotesSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;



/**
 新闻点赞
 sysmodel.para1：新闻代码, sysmodel.para2：点赞人ID, sysmodel.blresult：取消点赞否
 */
+(void)NewLikeSysmodel:(NSString*)sysmodel Success:(Success)Success Fail:(Fail)fail;

/**
 游记中图片上传
 upload传图片接口
 */
+(void)NewImageDataArray:(NSArray*)dataArray Success:(Success)Success Fail:(Fail)fail
;
@end
