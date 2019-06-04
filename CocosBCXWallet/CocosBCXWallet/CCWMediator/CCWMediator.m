//
//  CCWMediator
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWMediator.h"
#import "CCWModuleProtocol.h"

@interface CCWMediator ()

@property (nonatomic, strong) NSMutableArray *modules;
@property (nonatomic, strong) NSMutableArray *protocols;


/**
 Class - key ; Protocol - value
 */
@property (nonatomic, strong) NSDictionary   *dictionary;

@end

@implementation CCWMediator
#pragma mark - getters setters
- (NSArray<Class> *)allModules {
    return [self.modules copy];
}

- (NSMutableArray *)modules {
    if (_modules == nil) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (NSMutableArray *)protocols {
    if (_protocols == nil) {
        _protocols = [NSMutableArray array];
    }
    return _protocols;
}

+ (instancetype)sharedInstance {
    static CCWMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[self alloc] init];
    });
    return mediator;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = @{
                        @"CCWInitWalletModule" : @"CCWInitModuleProtocol",
                        @"CCWWalletModule" : @"CCWWalletModuleProtocol",
                        @"CCWFindModule" : @"CCWFindModuleProtocol",
                        @"CCWMyModule" : @"CCWMyModuleProtocol",
                        };
    }
    return self;
}

// 注册模块
- (void)registerAllModules {
    NSArray *keys = [_dictionary allKeys];
    for (NSString *key in keys) {
        Class     cls = NSClassFromString(key);
        Protocol *prl = NSProtocolFromString(_dictionary[key]);
        if (cls && prl) {
            [self _registerModuleClass:cls forProtocol:prl];
        }
    }
}

- (void)_registerModuleClass:(Class)moduleClass forProtocol:(Protocol *)moduleProtocol {
    // 是用来检查对象（包括其父类）是否实现了指定协议类的方法。
    if (![moduleClass conformsToProtocol:moduleProtocol]) {
        NSException *exception = [NSException exceptionWithName:@"CCWMediator register error" reason:[NSString stringWithFormat:@"the moduleClass must conforms to protocol: %@", NSStringFromProtocol(moduleProtocol)] userInfo:nil];
        @throw exception;
    }
    
    if (![moduleClass conformsToProtocol:@protocol(CCWModuleProtocol)]) {
        NSException *exception = [NSException exceptionWithName:@"CCWMediator register error" reason:@"the moduleClass must conforms to protocol: <CCWModuleProtocol>" userInfo:nil];
        @throw exception;
    }
    
    if (![self.modules containsObject:moduleClass] && ![self.protocols containsObject:moduleProtocol]) {
        [self.modules   addObject:moduleClass];
        [self.protocols addObject:moduleProtocol];
    }
}

- (id)moduleForProtocol:(Protocol *)moduleProtocol {
    if (moduleProtocol != nil) {
        NSInteger index = [self.protocols indexOfObject:moduleProtocol];
        if (index != NSNotFound && index >= 0 && index < [self.modules count]) {
            Class moduleClass = [self.modules objectAtIndex:index];
            if (moduleClass != nil) {
                return [[moduleClass alloc] init];
            }
        }
    }
    return nil;
}

- (id)moduleProtocol:(NSString *)protocolStr {
    Protocol *prl = NSProtocolFromString(protocolStr);
    if (!prl) {
        prl = NSProtocolFromString([NSString stringWithFormat:@"CCW%@Module", protocolStr]);
    }
    if (prl) {
        NSInteger index = [self.protocols indexOfObject:prl];
        if (index != NSNotFound) {
            Class cls = self.modules[index];
            if (cls) {
                return [cls new];
            }
        }
    }
    return nil;
}



// 远程调用 CCW://[moduleName]/[actionName]?[params(k=v)]
- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(id result))completion {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *moduleName = [url.host lowercaseString];
    moduleName = [NSString stringWithFormat:@"%@%@", [[moduleName substringToIndex:1] uppercaseString], [moduleName substringFromIndex:1]];
    
    id result = [self performModule:moduleName action:actionName params:params isFromRemote:YES];
    if (completion) {
        completion(nil);
    }
    return result;
}

/**
 *  本地调用
 *  module命名规则：CCW[ModuleName]Module
 */
- (id)performModule:(NSString *)moduleName action:(NSString *)actionName params:(NSDictionary *)params isFromRemote:(BOOL)isFromRemote {
    
    NSString *moduleClassString = [NSString stringWithFormat:@"CCW%@Module", moduleName];
    id<CCWModuleProtocol> module;
    Class moduleClass = NSClassFromString(moduleClassString);
    if (moduleClass == nil ||
        ![self.modules containsObject:moduleClass] ||
        (module = [[moduleClass alloc] init]) == nil ||
        ![module respondsToSelector:@selector(remoteWithActionName:params:)]) {
        //无响应请求
        return nil;
    }
    
    return [module remoteWithActionName:actionName params:params];
}
@end
