//
//  MoshDefine.h
//  modelTest
//
//  Created by mosh on 13-10-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>

//基点
#define POINT_X     0
#define POINT_Y     0

//宏定义NSLog

//#define _DEBUG

#ifdef	_DEBUG
#define	MOSHLog(...);	NSLog(__VA_ARGS__);
#define	MOSHDUGLog(object) 	[NSLogView moshLogInLogView:[object description]]
#define MOSHLogMethod	NSLog( @"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd) );
#else
#define MOSHLog(...);
#define	MOSHDUGLog(object)
#define MOSHLogMethod
#endif

//宏定义屏幕的宽和高

#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height
#define NAVHEIGHT       ([GlobalConfig versionIsIOS7]? 64 : 44)
#define NAVIMAGE       ([GlobalConfig versionIsIOS7]? @"navBg_ios7" : @"navBg")
#define STATEHEIGHT     ([GlobalConfig versionIsIOS7]? 0 : 20)
#define TABBARHEIGHT    49


//解决arc中performselector警告问题
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//宏定义颜色
#define NORMAL_COLOR				[UIColor colorWithRed:151/255.0f green:151/255.0f blue:151/255.0f alpha:1]

#define CLEARCOLOR              [UIColor clearColor]
#define WHITECOLOR              [UIColor whiteColor]
#define BLACKCOLOR              [UIColor blackColor]

#define NAVBAR_TINT_COLOR			[UIColor colorWithRed:44/255.0f green:44/255.0f blue:44/255.0f alpha:1]

#define TEXTGRAYCOLOR               [UIColor colorWithRed:183/255.0f green:183/255.0f blue:183/255.0f alpha:1]
#define BLUECOLOR               [UIColor colorWithRed:0/255.0f green:126/255.0f blue:201/255.0f alpha:1]
#define BACKGROUND              [UIColor whiteColor]
#define  rowGrayColor [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1]

//图片
#define PLACEHOLDERIMAGE_VERTICAL        [UIImage imageNamed:@"vertical_pic@2x.png"]
#define PLACEHOLDERIMAGE_HORIZONTAL  [UIImage imageNamed:@"horizontal_pic@2x.png"]
#define PLACEHOLDERIMAGE_SQUARE      [UIImage imageNamed:@"square_pic@2x.png"]
//

#define iPodTouchString				@"iPod touch"
#define iPadString                  @"iPad"
#define DeviceType                  @"设备类型"
#define System                      @"系统版本"

#define CURRENTAPPID                @""//用于评分

#define NAV_FONT                    [UIFont systemFontOfSize:20];
#define BUTTON_FONT                 [UIFont boldSystemFontOfSize:13];

#define NSArrayClass                [NSArray class]
#define NSDictionaryClass           [NSDictionary class]
#define NSStringClass               [NSString class]

//动画时间
#define DURATION                    0.7
#define ANIMATIONTYPE_PUSH          3
#define ANIMATIONSUBTYPE_PUSH       2
#define ANIMATIONTYPE_POP           3
#define ANIMATIONSUBTYPE_POP        1

//时间格式
#define DATEFORMAT_01              @"yyyy.MM.dd HH:mm:ss"
#define DATEFORMAT_02              @"yyyy.MM.dd HH:mm"
#define DATEFORMAT_03              @"yyyy.MM.dd"
#define DATEFORMAT_04              @"yyyy.MM"
#define DATEFORMAT_05              @"M月dd日 hh:mm"

#define LOADING						@"正在加载..."
#define LOADINGMORE                 @"正在加载更多内容"
#define ERROR						@"网络连接失败，请重试。"
#define ERROR_READCACHE             @"加载失败，读取缓存..."
#define ERROR_LOADINGFAIL           @"加载失败，请检查网络连接"
#define ERROR_EMPTYDATA             @"内容暂未更新，不要着急哦~~"
#define ERROR_USERNAME              @"用户名不能为空"
#define ERROR_PASSWORD              @"密码不能为空"
#define ERROR_CHECKNUMBER           @"验证码不能为空"
#define ERROR_USERNAME2             @"用户名只能为邮箱或手机号"
#define ERROR_CHECKNUMBER2           @"验证码不正确，请重新输入"
#define ERROR_PASSWORD2              @"两次输入的密码不一致，请重新输入"
#define ERROR_LOGINFAIL             @"登录失败，请检查用户名和密码"
#define ERROR_LOGINFAIL2            @"用户名不存在"
#define ERROR_LOGINFAIL3            @"请求失败，请检查用户名"
#define ERROR_LOGINFAIL4             @"登录失败，请检查密码格式"

#define ALERT_taskLimit           @"亲，再加就压力山大了，还是赶紧消灭现在的任务吧！"

#define BUTTON_OK					@"确定"
#define BUTTON_CANCEL				@"取消"
#define BUTTON_BACK				@"返回"
#define BUTTON_ALLSELECT				@"全选"
#define BUTTON_ALLDEL               @"全删"

#define UPDATE_TITIE				@"升级提示"
#define NO_NEW_VERSION				@"未发现新版本，当前安装的已是最新版本。"
#define HAS_NEW_VERSION				@"发现新版本，现在是否升级？"

#define kCallNotSupportOnIPod		@"该设备不支持打电话功能！"
#define kSmsNotSupportOnIPod		@"该设备不支持发短信功能！"
#define kOptionNotSupport			@"您的设备不支持该项功能！"
#define ERROR_COLLECT               @"收藏功能需要登录后才能使用！"

#define COLLECT_ADDSUCCESS          @"收藏成功"
#define COLLECT_ADDFAILED           @"收藏失败"
#define COLLECT_DELSUCCESS          @"移除收藏成功"
#define COLLECT_DELFAILED           @"移除收藏失败"
#define DOWN_DELFAILED           @"获取票数据失败"
#define VALIDATE_DELFAILED           @"验票失败"
#define UPLOAD_DELFAILED           @"上传失败"
#define SYNC_ADDSUCCESS           @"同步成功"
#define SYNC_DELFAILED           @"同步失败"
//标题
#define NAVTITLE_LOGIN              @""
#define ALERT_IMAGEPICKER       @"木有同意获取不到照片，请按同意键"
//占位符
#define PLACE_SEARCH                @"请输入查询内容"


//功能测试

#define TEST_WEB_SUCC               @"网络测试成功"
#define TEST_BARCODE_SUCC           @"二维码扫描有效"
#define NAVTITLE_TASK        @"任务"
#define NAVTITLE_TOP10              @"来源TOP10"
#define NAVTITLE_TICKETSTA          @"票种统计"

#define TEST                        @"测试"
#define TEST_LOCAL_SUCC             @"手动检票测试成功"
#define TEST_LOCAL_FAIL             @"手动检票测试失败"

@interface MoshDefine : NSObject

@end
