//
//  HZURLJumpManager.m
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZURLJumpManager.h"
#import "HZAppDelegate.h"
#import "HZExtensionKit.h"
#import "HZBaseViewController.h"

NSString * const HZModuleNameKey            = @"hz.module.name";
NSString * const HZModuleControllerNameKey  = @"hz.module.controller.name";
NSString * const HZModuleSbNameKey          = @"hz.module.sb.name";
NSString * const HZModuleSbIdfKey           = @"hz.module.sb.idf";

//NSString * const HZModuleNeedLoginKey       = @"hz.module.need.login";
//NSString * const HZModuleDefaultCallbackKey = @"hz.module.default.callback";

NSString * const HZModuleIsPushKey          = @"hz.module.is.push";

NSString * const HZJumpURLNextURLKey        = @"url";
NSString * const HZJumpURLIsPushKey         = @"push";

NSString * const HZProtocolKey              = @"hzjump://";
NSString * const HZGoHostKey                = @"go";

@interface HZURLJumpManager ()
{
    BOOL _canRegisterModule;
}
@property (nonatomic, strong) NSMutableDictionary *moduleConfig;
@end

@implementation HZURLJumpManager
/**
 *  Read Module Config From plist File
 *  Other Way is Use - (void)registerModuleWithDictionary:(NSDictionary *)moduleDictionary;But In Next Version.
 */
- (void)initModuleConfig
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HZURLJumpConfig" ofType:@"plist"];
    if (path.length) {
        _moduleConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initModuleConfig];
        _canRegisterModule = YES;
    }
    return self;
}
+ (instancetype)share
{
    static HZURLJumpManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[HZURLJumpManager alloc] init];
        }
    });
    return instance;
}
/**
 *  Register Module Without plist
 *
 *  @param moduleDictionary moduleConfig
 */
- (void)registerModuleWithDictionary:(NSDictionary *)moduleDictionary
{
    if (_canRegisterModule) {
        [_moduleConfig setObject:moduleDictionary forKey:moduleDictionary[HZModuleNameKey]];
    }
    else {
        NSAssert(false, @"你未开启手动注册开关,请自行在HZURLJumpManager中修改_canRegisterModule=YES");
    }
}
/**
 *  Push A ViewController Using URL
 *
 *  @param url                  Push URL
 *  @param navigationController Current NavigationController
 */
- (void)pushToURL:(NSURL *)url fromNavigationController:(UINavigationController *)navigationController
{
    if (!navigationController || ![navigationController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    NSDictionary *moduleInfo = [self analyzeURL:url];
    if (!moduleInfo) {
#ifdef DEBUG
        [UIAlertView showTitle:@"没有注册的URL" message:url.absoluteString];
#endif
    }
    else {
        Class aClass = NSClassFromString(moduleInfo[HZModuleControllerNameKey]);
        if ([aClass isSubclassOfClass:[HZBaseViewController class]]) {
            NSString *sbName = moduleInfo[HZModuleSbNameKey];
            NSString *vcIdf = moduleInfo[HZModuleSbIdfKey];
            HZBaseViewController *baseVc = HZInitVc(sbName, vcIdf);
            NSMutableDictionary *moduleObject = [NSMutableDictionary dictionaryWithDictionary:moduleInfo];
            if (moduleObject) {
                [moduleObject setValue:@(YES) forKey:HZModuleIsPushKey];
            }
            else {
                moduleObject = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@(YES), HZModuleIsPushKey, nil];
            }
            baseVc.moduleObject = moduleObject;
            [navigationController pushViewController:baseVc animated:YES];
        }
    }
}

- (void)pushToURLString:(NSString *)urlString fromNavigationController:(UINavigationController *)navigationController
{
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self pushToURL:url fromNavigationController:navigationController];
    }
    else {
        [UIAlertView showMessage:@"无效的URL"];
    }
}
/**
 *  Present A ViewController Using URL
 *
 *  @param url            Present URL
 *  @param viewController Current ViewController
 */
- (void)presentToURL:(NSURL *)url fromViewController:(UIViewController *)viewController
{
    if (!viewController || [viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    NSDictionary *moduleInfo = [self analyzeURL:url];
    if (!moduleInfo) {
#ifdef DEBUG
        [UIAlertView showTitle:@"没有注册的URL" message:url.absoluteString];
#endif
    }
    else {
        Class aClass = NSClassFromString(moduleInfo[HZModuleControllerNameKey]);
        if ([aClass isSubclassOfClass:[HZBaseViewController class]]) {
            NSString *sbName = moduleInfo[HZModuleSbNameKey];
            NSString *vcIdf = moduleInfo[HZModuleSbIdfKey];
            HZBaseViewController *baseVc = HZInitVc(sbName, vcIdf);
            NSMutableDictionary *moduleObject = [NSMutableDictionary dictionaryWithDictionary:moduleInfo];
            if (moduleObject) {
                [moduleObject setValue:@(NO) forKey:HZModuleIsPushKey];
            }
            else {
                moduleObject = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@(NO), HZModuleIsPushKey, nil];
            }

            baseVc.moduleObject = moduleObject;
            UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:baseVc];
            [viewController presentViewController:navigationVc animated:YES completion:nil];
        }
    }
}

- (void)presentToURLString:(NSString *)urlString fromViewController:(UIViewController *)viewController
{
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self presentToURL:url fromViewController:viewController];
    }
    else {
        [UIAlertView showMessage:@"无效的URL"];
    }
}

- (NSDictionary *)analyzeURL:(NSURL *)url
{
    if (!url) {
        return nil;
    }
    if (![url.absoluteString hasPrefix:HZProtocolKey]) {
        return nil;
    }
    if (![url.host isEqualToString:HZGoHostKey]) {
        return nil;
    }
    NSDictionary *queryDictionary = [url queryDictionary];
    NSString *moduleName = queryDictionary[HZJumpURLNextURLKey];
    NSMutableDictionary *moduleInfo = [_moduleConfig[moduleName] mutableCopy];
    
    NSMutableDictionary *queryCopy = [queryDictionary mutableCopy];
    [queryCopy removeObjectForKey:HZJumpURLNextURLKey];
    [queryCopy removeObjectForKey:HZJumpURLIsPushKey];
    if (!moduleInfo) {
        return nil;
    }
    else {
        [moduleInfo setValuesForKeysWithDictionary:queryCopy];
    }
    return moduleInfo;
}

/**
 *  Jump To ViewController Using URL
 *  In URL Query Params,If You Want Push Using push=yes Or Using push=no
 *  If Use push=yes,You Should Give A NavigationController
 *  Else Give A ViewController
 *
 *  @param url        Jump URL
 *  @param controller Current Controller
 */
- (void)jumpToURL:(NSURL *)url fromController:(id)controller
{
    NSDictionary *queryDictionary = [url queryDictionary];
    NSString *pushVaule = queryDictionary[HZJumpURLIsPushKey];
    BOOL isPush = [[pushVaule uppercaseString] isEqualToString:@"YES"];
    if (isPush && [controller isKindOfClass:[UINavigationController class]]) {
        [self pushToURL:url fromNavigationController:controller];
    }
    else {
        [self presentToURL:url fromViewController:controller];
    }
}

- (void)jumpToURLString:(NSString *)urlString fromController:(id)controller
{
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self jumpToURL:url fromController:controller];
    }
    else {
        [UIAlertView showMessage:@"无效的URL"];
    }
}

@end
