//
//  YPopView.h
//  YPopView
//
//  Created by shusy on 2018/1/9.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YPopView : UIView
- (instancetype)initWithTitle:(NSString*)title descTitle:(NSString*)descTitle;
/**
 设置样式
 @param titleFont    标题字体
 @param titleColor   标题颜色
 @param descFont   描述字体
 @param descColor  描述颜色
 @param lineSpacing  文字间距
 @param lineHeight  行高
 */
- (void)setTitleFont:(NSInteger)titleFont titleColor:(UIColor*)titleColor descFont:(NSInteger)descFont descColor:(UIColor*)descColor lineSpacing:(CGFloat)lineSpacing lineHeight:(CGFloat)lineHeight;
- (void)show;
@end
