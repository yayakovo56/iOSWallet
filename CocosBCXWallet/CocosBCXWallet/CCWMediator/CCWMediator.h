//
//  CCWMediator
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWMediator : NSObject

@property (nonatomic, strong, readonly) NSArray<Class> *allModules;

+ (instancetype)sharedInstance;

/**
 *  远程调用
 *  CCW://[moduleName]/[actionName]?[params(k=v)]
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(id result))completion;

/**
 *  注册模块

- (void)registerModuleClass:(Class)moduleClass forProtocol:(Protocol *)moduleProtocol;
 */

- (void)registerAllModules;
- (id)moduleProtocol:(NSString *)protocolStr;
/**
 *  获取模块
 */
- (id)moduleForProtocol:(Protocol *)moduleProtocol;

@end
