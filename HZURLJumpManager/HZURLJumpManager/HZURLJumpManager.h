//
//  HZURLJumpManager.h
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  For Module Register Key
 */
extern NSString * const HZModuleNameKey;            // url=HZModuleNameKey
extern NSString * const HZModuleSbNameKey;
extern NSString * const HZModuleSbIdfKey;
extern NSString * const HZModuleControllerNameKey;
//extern NSString * const HZModuleNeedLoginKey;
//extern NSString * const HZModuleDefaultCallbackKey;

/**
 *  For Module Object Analyze
 */
extern NSString * const HZModuleIsPushKey;


@interface HZURLJumpManager : NSObject
/**
 *  This is a Singleton Class
 *
 *  @return HZURLJumpManager Object
 */
+ (instancetype)share;
/**
 *  Register Module Without plist
 *
 *  @param moduleDictionary moduleConfig
 */
- (void)registerModuleWithDictionary:(NSDictionary *)moduleDictionary;
/**
 *  Push A ViewController Using URL
 *
 *  @param url                  Push URL
 *  @param navigationController Current NavigationController
 */
- (void)pushToURL:(NSURL *)url fromNavigationController:(UINavigationController *)navigationControlle;
/**
 *  Push A ViewController Using URL String
 *
 *  @param urlString            Push URL String
 *  @param navigationController Current NavigationController
 */
- (void)pushToURLString:(NSString *)urlString fromNavigationController:(UINavigationController *)navigationController;
/**
 *  Present A ViewController Using URL
 *
 *  @param url            Present URL
 *  @param viewController Current ViewController
 */
- (void)presentToURL:(NSURL *)url fromViewController:(UIViewController *)viewController;
/**
 *  Present A ViewController Using URL String
 *
 *  @param urlString      Present URL String
 *  @param viewController Current ViewController
 */
- (void)presentToURLString:(NSString *)urlString fromViewController:(UIViewController *)viewController;
/**
 *  Jump To ViewController Using URL
 *  In URL Query Params,If You Want Push Using push=yes Or Using push=no
 *  If Use push=yes,You Should Give A NavigationController
 *  Else Give A ViewController
 *
 *  @param url        Jump URL
 *  @param controller Current Controller
 */
- (void)jumpToURL:(NSURL *)url fromController:(id)controller;
/**
 *  Jump To ViewController Using URL String
 *  In URL Query Params,If You Want Push Using push=yes Or Using push=no
 *  If Use push=yes,You Should Give A NavigationController
 *  Else Give A ViewController
 *
 *  @param url        Jump URL String
 *  @param controller Current Controller
 */
- (void)jumpToURLString:(NSString *)urlString fromController:(id)controller;
@end
