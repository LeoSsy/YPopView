//
//  YPopView.m
//  YPopView
//
//  Created by shusy on 2018/1/9.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import "YPopView.h"

#define ALERT_WSPACE 40          //距离左右间距
#define ALERT_HSPACE 110        //距离上下间距
#define ALBTNWH 35                    //按钮的宽高
#define ALSPRINGVALUE 20              //弹性幅度值 上下抖动的值 默认10
#define ALDURATION 0.25              //动画时间
#define YPopViewAllMargin 8         //描述文本距离上下左右的间距

@interface YPopView()
/**总的内容视图*/
@property(nonatomic,strong)UIView *contentView;
/**scrollView视图*/
@property(nonatomic,strong)UIScrollView *scrollView;
/**内部标题视图*/
@property(nonatomic,strong)UILabel *titleL;
/**内容描述视图*/
@property(nonatomic,strong)UITextView *descTitleL;
/**关闭按钮视图*/
@property(nonatomic,strong)UIButton *closeBtn;
/**内容视图的宽度*/
@property(nonatomic,assign)CGFloat contentW;
/**描述文本*/
@property(nonatomic,strong)NSString *descText;
/**保存文字的高度*/
@property(nonatomic,assign)CGFloat descH;
/**保存文字的行高*/
@property(nonatomic,assign)CGFloat lineHeight;
/**保存文字的间距*/
@property(nonatomic,assign)CGFloat lineSpacing;
@end

@implementation YPopView

- (instancetype)initWithTitle:(NSString*)title descTitle:(NSString*)descTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.descText = descTitle;
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(ALERT_WSPACE,-self.frame.size.height, self.frame.size.width - 2*ALERT_WSPACE, self.frame.size.height-2*ALERT_HSPACE)];
        _contentView.layer.cornerRadius = 5;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, ALBTNWH)];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.text = (title != nil ? title : @"温馨提示") ;
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textColor = [UIColor blackColor];
        [_contentView addSubview:_titleL];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleL.frame)-0.5, _contentView.frame.size.width, 0.5)];
        lineView.alpha = 0.5;
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [_contentView addSubview:lineView];
        
        _scrollView = [[UIScrollView alloc] init];
        [_contentView addSubview:_scrollView];
        
        //设置默认文字的间距和行高
        self.lineSpacing = 2;
        self.lineHeight = 2;
        _descTitleL = [[UITextView alloc] init];
        _descTitleL.font = [UIFont systemFontOfSize:15];
        _descTitleL.attributedText = (descTitle != nil ? [self createAttributedStringFromText:self.descText] : nil) ;
        _descTitleL.textColor = [UIColor blackColor];
        _descTitleL.scrollEnabled = NO;
        _descTitleL.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_scrollView addSubview:_descTitleL];
        
        //计算描述文字的高度
        CGFloat descH = [self calculateTextHeight:_contentView.frame.size.width-2*YPopViewAllMargin];
        descH+=ALBTNWH;
        self.descH = descH;
        if (descH > _contentView.frame.size.height) {
            _scrollView.frame = CGRectMake(0, ALBTNWH, _contentView.frame.size.width, _contentView.frame.size.height-ALBTNWH);
            _scrollView.contentSize = CGSizeMake(0, descH);
        }else{
            //重新计算y值
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
            _contentView.frame = CGRectMake(ALERT_WSPACE, (screenH-(descH+ALBTNWH))*0.5, screenW - 2*ALERT_WSPACE, descH+ALBTNWH);
            _scrollView.frame = CGRectMake(0, ALBTNWH, _contentView.frame.size.width, descH-YPopViewAllMargin);
        }
        _descTitleL.frame = CGRectMake(YPopViewAllMargin, 0, _contentView.frame.size.width-2*YPopViewAllMargin, descH);
        CGFloat btnwh = 30;
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contentView.frame)-btnwh*0.5, CGRectGetMinY(_contentView.frame)-btnwh*0.9, btnwh, btnwh)];
        [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn setAdjustsImageWhenHighlighted:NO];
        closeBtn.backgroundColor = [UIColor whiteColor];
        closeBtn.layer.cornerRadius = btnwh*0.5;
        closeBtn.layer.masksToBounds = YES;
        closeBtn.alpha = 0.0;
        self.closeBtn = closeBtn;
        [self addSubview:closeBtn];
        
    }
    return self;
}

/**
 设置样式
 @param titleFont    标题字体
 @param titleColor   标题颜色
 @param descFont   描述字体
 @param descColor  描述颜色
 @param lineSpacing  文字间距
 @param lineHeight  行高
 */
- (void)setTitleFont:(NSInteger)titleFont titleColor:(UIColor*)titleColor descFont:(NSInteger)descFont descColor:(UIColor*)descColor lineSpacing:(CGFloat)lineSpacing lineHeight:(CGFloat)lineHeight {
    self.titleL.font = [UIFont systemFontOfSize:titleFont];
    self.titleL.textColor = titleColor;
    self.descTitleL.font = [UIFont systemFontOfSize:descFont];
    self.descTitleL.textColor = descColor;
    self.lineHeight = lineHeight;
    self.lineSpacing = lineSpacing;
}

/**
 创建描述文本对应的属性文本
 */
- (NSMutableAttributedString*)createAttributedStringFromText:(NSString*)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSpacing;
    paragraphStyle.minimumLineHeight = self.lineHeight;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:self.descTitleL.font,NSParagraphStyleAttributeName:paragraphStyle}];
    return attributedString;
}

/**
 计算文字的高度
 @param maxWidth 内容视图的宽度
 */
- (CGFloat)calculateTextHeight:(CGFloat)maxWidth {
    return  [[self createAttributedStringFromText:self.descText] boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}

- (void)show {
    self.alpha = 1.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (self.descH > _contentView.frame.size.height) {
        _scrollView.frame = CGRectMake(0, ALBTNWH, _contentView.frame.size.width, _contentView.frame.size.height-ALBTNWH);
        _scrollView.contentSize = CGSizeMake(0, self.descH);
        CGRect frame = self.contentView.frame;
        frame.origin.y = ALERT_HSPACE+ALSPRINGVALUE;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.contentView.frame = frame;
        } completion:^(BOOL finished) {
            CGRect frame = self.contentView.frame;
            frame.origin.y = ALERT_HSPACE;
            CGFloat btnwh = 30;
            self.closeBtn.frame =  CGRectMake(CGRectGetMaxX(_contentView.frame)-btnwh*0.5, CGRectGetMinY(_contentView.frame)-btnwh-10, btnwh, btnwh);
            [UIView animateWithDuration:ALDURATION animations:^{
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.closeBtn.alpha = 1.0;
                }];
            }];
            
        }];
    }else{
        //重新计算y值
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        _contentView.frame = CGRectMake(ALERT_WSPACE, (screenH-(self.descH+ALBTNWH))*0.5, screenW - 2*ALERT_WSPACE, self.descH+ALBTNWH);
        _scrollView.frame = CGRectMake(0, ALBTNWH, _contentView.frame.size.width, self.descH);
        CGRect frame = self.contentView.frame;
        frame.origin.y+=ALSPRINGVALUE;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.contentView.frame = frame;
        } completion:^(BOOL finished) {
            CGRect frame = self.contentView.frame;
            frame.origin.y-=ALSPRINGVALUE;
            [UIView animateWithDuration:ALDURATION animations:^{
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.closeBtn.alpha = 1.0;
                }];
            }];
        }];
    }

}

- (void)dismiss {
    if (self.descH > self.contentView.frame.size.height) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = ALERT_HSPACE+ALSPRINGVALUE;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.contentView.frame = frame;
            self.closeBtn.alpha = 0.0;
        } completion:^(BOOL finished) {
            CGRect frame = self.contentView.frame;
            frame.origin.y = -self.frame.size.height;
            [UIView animateWithDuration:ALDURATION animations:^{
                self.alpha = 0.0f;
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }else{
        CGRect frame = self.contentView.frame;
        frame.origin.y+=ALSPRINGVALUE;
        [UIView animateWithDuration:ALDURATION animations:^{
            self.contentView.frame = frame;
            self.closeBtn.alpha = 0.0;
        } completion:^(BOOL finished) {
            CGRect frame = self.contentView.frame;
            frame.origin.y = -self.frame.size.height;
            [UIView animateWithDuration:ALDURATION animations:^{
                self.alpha = 0.0f;
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
}

#pragma mark event
- (void)closeBtnClick{
    [self dismiss];
}

@end
