//
//  HZURLJumpManager.h
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const HZModuleNameKey;
extern NSString * const HZModuleSbNameKey;
extern NSString * const HZModuleSbIdfKey;
extern NSString * const HZModuleIsPushKey;

//extern NSString * const HZModuleNeedLoginKey;
//extern NSString * const HZModuleDefaultCallbackKey;

@interface HZURLJumpManager : NSObject
+ (instancetype)share;
//- (void)registerModuleWithDictionary:(NSDictionary *)moduleDictionary;
- (void)pushToURL:(NSURL *)url fromNavigationController:(UINavigationController *)navigationControlle;
- (void)pushToURLString:(NSString *)urlString fromNavigationController:(UINavigationController *)navigationController;
- (void)presentToURL:(NSURL *)url fromViewController:(UIViewController *)viewController;
- (void)presentToURLString:(NSString *)urlString fromViewController:(UIViewController *)viewController;
- (void)jumpToURL:(NSURL *)url fromController:(id)controller;
- (void)jumpToURLString:(NSString *)urlString fromController:(id)controller;
@end
