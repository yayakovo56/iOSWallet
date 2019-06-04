//
//  NSObject+YSAdd.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "NSObject+YSAdd.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (YSAdd)

static char associatedObjectsKey;

- (id)ys_associatedObjectForKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    return [dict objectForKey:key];
}

- (void)ys_setAssociatedObject:(id)object forKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    [dict setObject:object forKey:key];
}

- (void)ys_removeAssociatedForKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (dict) {
        [dict removeObjectForKey:key];
    }
}

- (NSString *)description {
    if (![NSStringFromClass(self.class) hasPrefix:@"YS"] ||
        [self isKindOfClass:UIViewController.class]) return @"";
    
    NSMutableString *propertiesString = [NSMutableString string];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char * property_name = property_getName(property);
        
        //获取属性的属性的特性（weak,readonly等等）
        //property_getAttributes(property);
       NSString *property_key = [NSString stringWithUTF8String:property_name];
       id property_value = [self valueForKey:property_key];
       if (property_value && ![property_key isEqualToString:@"hash"]) {
           [propertiesString appendFormat:@"\t%@=",property_key];
           [propertiesString appendFormat:@"%@\n",property_value];
       }
    }
    free(properties);
    return [NSString stringWithFormat:@"%@ {\n%@}", NSStringFromClass(self.class), propertiesString];
}

@end
