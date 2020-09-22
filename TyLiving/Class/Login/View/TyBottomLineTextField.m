//
//  WYABottomLineTextField.m
//  WYA_OC_OA
//
//  Created by 1 on 2018/11/19.
//  Copyright © 2018年 weiyian. All rights reserved.
//

#import "TyBottomLineTextField.h"

@implementation TyBottomLineTextField
#pragma mark - LifeCircle
- (instancetype)init {

    self = [super init];
    if (self) {
        _phoneNumberText = @"";
        [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0.0, rect.size.height - 1);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.8); //线的颜色
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1);
    CGContextStrokePath(context);
}

#pragma mark - Public Method
- (void)setPlaceholderColor:(UIColor *)color {

//    [self setValue:color forKeyPath:@"placeholderLabel.textColor"];
}

#pragma mark - Private Method
- (void)textFieldDidEditing:(UITextField *)textField {

    //    if (self.style == LightContentStyle) {
    ////        UIButton * clearButton = [self valueForKey:@"_clearButton"]; //key值是固定的
    ////        [clearButton setImage:[UIImage imageNamed:@"icon_delete_normal"] forState:UIControlStateNormal];
    //    }

    if (_isPhoneNumber) {
        _phoneNumberText = [self trimmingWhitespaceWithStr:textField.text];
    }

    if (self.editingBlock) {
        self.editingBlock();
    }
}

// 去除空格
- (NSString *)trimmingWhitespaceWithStr:(NSString *)str {
    NSString * endStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return endStr;
}


// 判断是否为数字
- (BOOL)isPureInt:(NSString *)string {
    NSScanner * scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (_isPhoneNumber) {

        // 如果输入不是数字或者删除，则无效输入
        if (![self isPureInt:string] && ![string isEqualToString:@""]) {
            return NO;
        }

        // 如果输入最大长度，且当前不是删除操作
        NSString * curNumText = [self trimmingWhitespaceWithStr:textField.text];
        if ((curNumText.length + string.length > 13) && ![string isEqualToString:@""]) {
            return NO;
        }
    }

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {

    if (_isPhoneNumber) {
        _phoneNumberText = @"";
    }
    self.editingBlock();

    return YES;
}

#pragma mark - Super Setter
- (void)setText:(NSString *)text {

    [super setText:text];

    _phoneNumberText = [self trimmingWhitespaceWithStr:text];
}

#pragma mark - Setter
//- (void)setStyle:(TextUIContentStyle)style {
//
////    _style               = style;
//    self.clearButtonMode = UITextFieldViewModeWhileEditing;
//}

- (void)setIsPhoneNumber:(BOOL)isPhoneNumber {

    _isPhoneNumber = isPhoneNumber;

    if (isPhoneNumber) {
        self.delegate     = self;
        self.keyboardType = UIKeyboardTypePhonePad;
    }
}

@end
