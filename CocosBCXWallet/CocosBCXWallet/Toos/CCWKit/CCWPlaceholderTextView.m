//
//  CCWPlaceholderTextView.m
//  
//
//  Created by 邵银岭 on 15/8/21.
//  Copyright (c) 2015年 邵银岭. All rights reserved.
//

#import "CCWPlaceholderTextView.h"

@interface CCWPlaceholderTextView()

/** 显示占位文字的label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end
@implementation CCWPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.x = 4;
        placeholderLabel.y = 8;
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.tintColor = [UIColor grayColor];
    self.alwaysBounceVertical = YES;
    self.font = [UIFont systemFontOfSize:14];
    self.placeholderColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置宽度
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    
    // 自动计算placeholderLabel高度
    [self.placeholderLabel sizeToFit];
    
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    // 重新布局子控件
    [self setNeedsLayout];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    // 重新布局子控件
    [self setNeedsLayout];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];

    
}

@end
