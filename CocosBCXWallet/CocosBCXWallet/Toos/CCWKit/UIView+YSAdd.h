//
//  UIView+YSAdd.h
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YSAdd)

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

- (UIViewController *)ys_findFirstViewController;

- (UIView *)ys_findFirstResponder;

- (UIView *)ys_findSubviewMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)ys_findSubviewsMatchingPredicate:(NSPredicate *)predicate;

- (UIView *)ys_findSubviewOfClass:(Class)viewClass;
- (id)ys_findSuperviewOfClass:(Class)viewClass;

@property (nonatomic) CGFloat ys_width;
@property (nonatomic) CGFloat ys_height;
@property (nonatomic) CGFloat ys_x;
@property (nonatomic) CGFloat ys_y;
@property (nonatomic, assign) CGFloat ys_centerX;
@property (nonatomic, assign) CGFloat ys_centerY;

@property (nonatomic) CGSize  ys_size;
@property (nonatomic) CGPoint ys_origin;

@property(assign, nonatomic) CGFloat ys_right;
@property(assign, nonatomic) CGFloat ys_bottom;

@property (nullable, nonatomic, readonly) UIViewController *viewController;

- (void)ys_setX:(CGFloat)x y:(CGFloat)y;
- (void)ys_setWidth:(CGFloat)width height:(CGFloat)height;

- (void)ys_transformX:(CGFloat)tx y:(CGFloat)ty;
- (void)ys_transformX:(CGFloat)tx;
- (void)ys_transformY:(CGFloat)ty;
- (void)ys_transformIdentity;

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)ys_snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)ys_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

@end

NS_ASSUME_NONNULL_END
