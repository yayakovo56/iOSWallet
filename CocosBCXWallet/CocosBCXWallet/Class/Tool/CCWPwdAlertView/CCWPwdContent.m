//
//  CCWPwdContent.m
//  CCWPwdAlertViewDemo
//

#import "CCWPwdContent.h"
#import "CCWPwdAlertView.h"

@interface CCWPwdContent ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectNoPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

/** 取消 */
@property (nonatomic, copy) void(^cancel)(void);

/** 确认 */
@property (nonatomic, copy) void(^confirm)(NSString *pwd, BOOL isIgnoreConfirm);
@end

@implementation CCWPwdContent

+ (instancetype)contentViewCancelClick:(void (^)(void))cancel confirmClick:(void (^)(NSString *pwd, BOOL isIgnoreConfirm))confirm
{
    CCWPwdContent *contentView = [[NSBundle mainBundle] loadNibNamed:@"CCWPwdContent" owner:nil options:nil].lastObject;
    contentView.frame = CGRectMake(0, 0, 270, 150);
    contentView.layer.cornerRadius = 4;
    contentView.clipsToBounds = YES;
    contentView.cancel = cancel;
    contentView.confirm = confirm;
    return contentView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.cancelButton.layer.borderColor = [UIColor getColor:@"e4e5e6"].CGColor;
    self.cancelButton.layer.borderWidth = 0.5;
    self.confirmButton.layer.borderColor = [UIColor getColor:@"e4e5e6"].CGColor;
    self.confirmButton.layer.borderWidth = 0.5;
    self.pwdTextField.layer.borderColor = [UIColor getColor:@"e4e5e6"].CGColor;
    self.pwdTextField.layer.borderWidth = 0.5;
    self.pwdTextField.layer.cornerRadius = 2;
}

- (IBAction)selectIgnoreClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)cancelClick:(id)sender {
    !self.cancel?:self.cancel();
    CCWPwdAlertView *alert = (CCWPwdAlertView *)self.superview;
    [alert hide];
}

- (IBAction)confirmClick:(id)sender {
    !self.confirm?:self.confirm(self.pwdTextField.text, self.selectNoPwdButton.isSelected);
    CCWPwdAlertView *alert = (CCWPwdAlertView *)self.superview;
    [alert hide];
}


@end
