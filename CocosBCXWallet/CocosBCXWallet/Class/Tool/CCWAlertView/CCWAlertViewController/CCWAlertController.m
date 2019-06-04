//
//  CCWAlertController.m
//  CocosWallet
//
//  Created by SYL on 2018/11/8.
//  Copyright © 2018 CCW. All rights reserved.
//

#import "CCWAlertController.h"
#import "CCWPresentationController.h"
#import "CCWAnimator.h"
//#import "UIView+Corners.h"

#define margin 1
#define btnHeight 35

@interface CCWAlertAction ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CCWAlertActionStyle style;
/**
 *  handler
 */
@property(nonatomic,copy) void (^handler)(CCWAlertAction *action);

@end

@implementation CCWAlertAction

+ (instancetype)CCW_actionWithTitle:(NSString *)title style:(CCWAlertActionStyle)style handler:(void (^)(CCWAlertAction *action))handler {
    CCWAlertAction *action = [[self alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

@end

/*********************************************************************************************/
@interface CCWAlertController () <UIViewControllerTransitioningDelegate>
// 标题
@property (nonatomic, copy) NSString *head;
// 消息
@property (nonatomic, copy) NSString *message;

/**
 *  modal 动画代理
 */
@property(nonatomic,strong) CCWAnimator *anima;

// modal 样式
@property (nonatomic,assign) CCWAlertControllerStyle preferredStyle;

/**
 *  操作按钮
 */
@property(nonatomic,strong) NSMutableArray <CCWAlertAction *> *actions;

/**
 *  弹出框视图
 */
@property(nonatomic,weak) UIView *alretView;


@end

@implementation CCWAlertController

+ (instancetype)CCW_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CCWAlertControllerStyle)preferredStyle {
    CCWAlertController *alertVc = [[self alloc] init];
    alertVc.head = title;
    alertVc.message = message;
    alertVc.preferredStyle = preferredStyle;
    
    return alertVc;
}

- (instancetype)init {

    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"alretview == %@",self);
    [self setUpSubViews];
}

- (void) setUpSubViews {

    if (self.preferredStyle == CCWAlertControllerStyleAlert) {
        [self setUpAlretSubViews];
    } else {
        [self setUpSheetSubViews];
    }
    
}

#pragma mark - alret样式布局
- (void)setUpAlretSubViews {
 
    CGFloat messgeMargin = 20;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *messageView = [[UIView alloc] init];
//    UIColor *bgColor =  [UIColor getColor:@"ffffff"]
    messageView.backgroundColor = [UIColor getColor:@"ffffff" alpha:0.94]; // #ffffff 94%不透明度
    _alretView = messageView;
    
    [self.view addSubview:messageView];
    
    CGFloat messageW = CCWScreenW - 2 * 60;
    if (iPhone4S || iPhone5) {
        messageW = CCWScreenW - 2 * 35;
    }
    
   
    messageView.layer.cornerRadius = 5;
    messageView.layer.masksToBounds = YES;
    
    UIView *headView = nil;
    if (self.head) {
        UILabel *headLable = [[UILabel alloc] init];
        headLable.textAlignment = NSTextAlignmentCenter;
        headLable.numberOfLines = 0;
        headLable.text = self.head;
        headLable.font = [UIFont boldSystemFontOfSize:15];
        headLable.textColor = [UIColor getColor:@"333333"]; // #333333 加粗
        CGFloat headH = [self.head heightWithFont:[UIFont boldSystemFontOfSize:15] MaxWidth:messageW];
//        [self textHeightWithWidth:messageW font:[UIFont boldSystemFontOfSize:15] ofString:self.head];
        headLable.frame = CGRectMake(0, messgeMargin, messageW, headH);
        
        
        if ([self.delegate respondsToSelector:@selector(titleView:)]) {
            headView = [self.delegate titleView:headLable];
        }else {
            headView = headLable;
        }
        
        [messageView addSubview:headView];
    }
    
    
    
    UIView *messageLableView = nil;
    UIView *middle = nil;
    CGFloat messageLableY = (CGRectGetMaxY(headView.frame) ? : 0) + messgeMargin;
    if (self.message) {
        
        UILabel *messageLable = [[UILabel alloc] init];
        messageLable.textAlignment = NSTextAlignmentCenter;
        messageLable.numberOfLines = 0;
        messageLable.text = self.message;
        messageLable.font = [UIFont systemFontOfSize:13]; // #666666 行间距36px
        messageLable.textColor = [UIColor getColor:@"333333"];
        CGFloat detalLableW = messageW - 2 * messgeMargin;
        
        CGFloat messageLableH = [self.message heightWithFont:[UIFont boldSystemFontOfSize:13] MaxWidth:detalLableW];
        
        messageLable.frame = CGRectMake(messgeMargin, 0, detalLableW, messageLableH);

        if ([self.delegate respondsToSelector:@selector(messageView:)]) {
            messageLableView = [self.delegate messageView:messageLable];
            messageLableView.x = messgeMargin;
        } else {
            messageLableView = messageLable;
        }
        
        
        middle = [[UIView alloc] initWithFrame:CGRectMake(0, messageLableY, messageW, CGRectGetMaxY(messageLableView.frame) + messgeMargin)];
        
        
        if (_actions.count) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, messageLableH + messgeMargin - 1, messageW, 1)];
            lineView.backgroundColor = [UIColor getColor:@"eeeeee"]; // #eeeeeee
            [middle addSubview:lineView];
        }
        
        [middle addSubview:messageLableView];
        
        [messageView addSubview:middle];
        
    }
    
    
    CGFloat btnY = (CGRectGetMaxY(middle.frame) ? : messageLableY  + messgeMargin);
    CGFloat btnW = messageW / self.actions.count;
    CGFloat btnH = 45;
    CGFloat btnMargin = 0;
    
    CCWAlertAction *action = nil;
    for (NSInteger i = 0; i < _actions.count; i++) {
        action = self.actions[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:action.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        UIColor *titleColor = nil;
        
        if (action.style == CCWAlertActionStyleDestructive) {
            titleColor = [UIColor getColor:@"2E6EF9"];

        }else if (action.style == CCWAlertActionStyleCancel) {
            titleColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        }else {
            titleColor = [UIColor getColor:@"2E6EF9"]; // #016afe 加粗
        }
        
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.frame = CGRectMake(btnMargin +(btnW + btnMargin)* i, btnY, btnW, btnH);
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        
        [messageView addSubview:btn];
        
        if (i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, btnH)];
            lineView.backgroundColor = [UIColor getColor:@"eeeeee"]; // #eeeeeee
            [btn addSubview:lineView];
        }
    }
    
    CGFloat messageH = _actions.count ? (btnY + btnH) : (btnY + 10);
    CGFloat messageX = (CCWScreenW - messageW) * 0.5;
    CGFloat messageY = (CCWScreenH - messageH) * 0.5;
    messageView.frame = CGRectMake(messageX, messageY, messageW, messageH);
    
    [self setUpOther];
}

- (void)setUpOther {
    if ([self.delegate respondsToSelector:@selector(alertOtherViewForAlert:)]) {
        [self.delegate alertOtherViewForAlert:self.view];
    }
    if ([self.delegate respondsToSelector:@selector(alertOtherViewForAlert:alertView:)]) {
        [self.delegate alertOtherViewForAlert:self.view alertView:self.alretView];
    }
    
}

#pragma mark - sheet样式控件布局
- (void)setUpSheetSubViews {
    
    CGFloat height = self.actions.count * (btnHeight + margin) + margin;
    
    self.alretView.frame = CGRectMake(0, CCWScreenH - height - 1, CCWScreenW, height);
    self.alretView.backgroundColor = [UIColor clearColor];

    [self setActionBtns];
}

- (void)setAlertBackgroundColor:(UIColor *)color {
    self.anima.contantColor = color;
    _alertBackgroundColor = color;
}
- (void)setActionBtns{
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnWith = CCWScreenW - 2 * btnX;
    CCWAlertAction *action = nil;
    for (NSInteger i = 0; i < self.actions.count; i++) {
        action = self.actions[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:action.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        btnY = i * (btnHeight + margin) + margin;
        btn.frame = CGRectMake(btnX, btnY, btnWith, btnHeight);
        btn.tag = i + 10;
        
        [self.alretView addSubview:btn];
        
        [btn addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (i == 0) {// 第一个item 顶部设置圆角
            [btn setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:6];
            
        } else if(i == self.actions.count - 1) { // 最后一个 item 底部设置圆角
            [btn setRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:6];
        }
    }
    
}

#pragma mark -

- (void)clickActionButton:(UIButton *)sender {
    CCWAlertAction *action = self.actions[sender.tag - 10];
    
    if (action.handler) {
        action.handler(action);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 添加action
- (void)CCW_addAction:(CCWAlertAction *)action {
    [self.actions addObject:action];
}

- (void)CCW_addActions:(NSArray <CCWAlertAction *> *)actions {
    [self.actions addObjectsFromArray:actions];
}

#pragma mark -  <UIViewControllerTransitioningDelegate>
// 负责展示的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.anima.presented = YES;
    
    self.anima.isAlrent = (self.preferredStyle == CCWAlertControllerStyleAlert);
    
    return self.anima;
}

// 负责消失的动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.anima.presented = NO;
    return self.anima;
}


- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    return [[CCWPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}
#pragma mark - 点击事件拦截
// 未实现该方法 点击事件会传递到上一个控制器上
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"点击了alertView");
    if ([self.delegate respondsToSelector:@selector(shoudDismissAlertWhenDidClickAlertView)] &&
        [self.delegate shoudDismissAlertWhenDidClickAlertView]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - lazy load
- (CCWAnimator *)anima {

    if (!_anima) {
        _anima = [[CCWAnimator alloc] init];
    }
    return _anima;
}

- (NSMutableArray<CCWAlertAction *> *)actions {
    
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (UIView *)alretView {
    if (!_alretView) {
        
        UIView *alretView = [[UIView alloc] init];
        [self.view addSubview:alretView];
        _alretView = alretView;
    }
    
    return _alretView;
}
#pragma mark - 

- (UIColor *)alertColor {
    if (!_alertColor) {
        _alertColor = [UIColor whiteColor];
    }
    return _alertColor;
}
- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor getColor:@"333333"];
    }
    return _titleColor;
}

- (UIColor *)messageColor {
    if (!_messageColor) {
        _messageColor = [UIColor getColor:@"333333"];
    }
    return _messageColor;
}


- (UIColor *)actionNormalColor {
    if (!_actionNormalColor) {
        _actionNormalColor = [UIColor getColor:@"2E6EF9"]; // #016afe 加粗
    }
    return _actionNormalColor;
}
- (UIColor *)actionCancelColor {
    if (!_actionCancelColor) {
        _actionCancelColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    }
    return _actionCancelColor;
}

- (UIColor *)actionDestructColor {
    if (!_actionDestructColor) {
        _actionDestructColor = [UIColor getColor:@"2E6EF9"];
    }
    return _actionDestructColor;
}
- (CGFloat)sheetActionHight {
    if (!_sheetActionHight) {
        _sheetActionHight = 44.0f;
    }
    return _sheetActionHight;
}

@end
