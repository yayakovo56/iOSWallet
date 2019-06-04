//
//  UIView+YSAdd.m
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "UIView+YSAdd.h"

@implementation UIView (YSAdd)

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (UIViewController *)ys_findFirstViewController {
    id responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return responder;
        }
    }
    return nil;
}

- (UIView *)ys_findFirstResponder {
    return [self ys_findSubviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused id bindings) {
        return [evaluatedObject isFirstResponder];
    }]];
}

- (UIView *)ys_findSubviewMatchingPredicate:(NSPredicate *)predicate {
    if ([predicate evaluateWithObject:self]) {
        return self;
    }
    for (UIView *view in self.subviews) {
        UIView *match = [view ys_findSubviewMatchingPredicate:predicate];
        if (match) return match;
    }
    return nil;
}

- (NSArray *)ys_findSubviewsMatchingPredicate:(NSPredicate *)predicate {
    NSMutableArray *matches = [NSMutableArray array];
    if ([predicate evaluateWithObject:self]) {
        [matches addObject:self];
    }
    for (UIView *view in self.subviews) {
        //check for subviews
        //avoid creating unnecessary array
        if ([view.subviews count]) {
            [matches addObjectsFromArray:[view ys_findSubviewsMatchingPredicate:predicate]];
        }
        else if ([predicate evaluateWithObject:view]) {
            [matches addObject:view];
        }
    }
    return matches;
}

- (UIView *)ys_findSubviewOfClass:(Class)viewClass {
    return [self ys_findSubviewMatchingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:viewClass];
    }]];
}

- (id)ys_findSuperviewOfClass:(Class)viewClass {
    UIView *superView = self.superview;
    while (YES) {
        if (!superView) {
            return nil;
        } else if ([superView isKindOfClass:viewClass]) {
            return superView;
        }
        superView = superView.superview;
    }
}

- (CGFloat)ys_x {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)ys_y {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)ys_width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)ys_height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)ys_centerX {
    return self.center.x;
}

- (CGFloat)ys_centerY {
    return self.center.y;
}

- (CGFloat)ys_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setYs_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ys_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setYs_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setYs_x:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setYs_y:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setYs_width:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setYs_height:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)ys_setX:(CGFloat)x y:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)ys_setWidth:(CGFloat)width height:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.width = width;
    rect.size.height = height;
    self.frame = rect;
}

- (CGSize)ys_size {
    return self.frame.size;
}

- (void)setYs_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)ys_origin {
    return self.frame.origin;
}

- (void)setYs_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setYs_centerX:(CGFloat)ys_centerX {
    CGPoint center = self.center;
    center.x = ys_centerX;
    self.center = center;
}

- (void)setYs_centerY:(CGFloat)ys_centerY {
    CGPoint center = self.center;
    center.y = ys_centerY;
    self.center = center;
}

- (void)ys_transformX:(CGFloat)tx y:(CGFloat)ty {
    self.transform = CGAffineTransformMakeTranslation(tx, ty);
}

- (void)ys_transformX:(CGFloat)tx {
    [self ys_transformX:tx y:0];
}

- (void)ys_transformY:(CGFloat)ty {
    [self ys_transformX:0 y:ty];
}

- (void)ys_transformIdentity {
    self.transform = CGAffineTransformIdentity;
}

- (UIImage *)ys_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)ys_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self ys_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
