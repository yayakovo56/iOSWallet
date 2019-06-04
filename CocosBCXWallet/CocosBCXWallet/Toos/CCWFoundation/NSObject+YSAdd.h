//
//  NSObject+YSAdd.h
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSAdd)

- (id)ys_associatedObjectForKey:(NSString*)key;
- (void)ys_setAssociatedObject:(id)object forKey:(NSString*)key;
- (void)ys_removeAssociatedForKey:(NSString*)key;

@end
