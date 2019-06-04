//
//  UILabel+YSAdd.m
//  tigerwallet
//
//  Created by andy on 2018/5/23.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "UILabel+YSAdd.h"

@implementation UILabel (YSAdd)

- (void)ys_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing {
    if ([text length] > 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributedString setAttributes:@{
                                          NSParagraphStyleAttributeName: paragraphStyle,
                                          NSFontAttributeName: self.font
                                          }
                                  range:NSMakeRange(0, [text length])];
        [self setAttributedText:attributedString];
    } else {
        self.text = text;
    }
}

- (void)ys_setUnderlineStyleText:(NSString *)text {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text
                                                                           attributes: @{
                                                                                         NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                         NSStrikethroughColorAttributeName: self.textColor
                                                                                         }];
    [self setAttributedText:attributedString];
}
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
@end
