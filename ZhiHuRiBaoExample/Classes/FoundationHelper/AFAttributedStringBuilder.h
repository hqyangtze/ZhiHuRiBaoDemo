//
//  AFAttributedStringBuilder.h
//  AppFrame
//
//  Created by HQ on 2016/12/1.
//  Copyright © 2016年 HQ. All rights reserved.
//

/// 参考代码地址：
/// https://github.com/youngsoft/MyAttributedString
///

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFAttributedStringBuilder;

/** 属性字符串区域 */
@interface AFAttributedStringRange : NSObject

/** 字体 */
- (AFAttributedStringRange*)setFont:(UIFont*)font;

/** 文字颜色 */
- (AFAttributedStringRange*)setTextColor:(UIColor*)color;

/** 背景色 */
- (AFAttributedStringRange*)setBackgroundColor:(UIColor*)color;

/** 段落样式 */
- (AFAttributedStringRange*)setParagraphStyle:(NSParagraphStyle*)paragraphStyle;

/** 连体字符，好像没有什么作用 */
- (AFAttributedStringRange*)setLigature:(BOOL)ligature;

/** 字间距 */
- (AFAttributedStringRange*)setKern:(CGFloat)kern;

/** 行间距 */
- (AFAttributedStringRange*)setLineSpacing:(CGFloat)lineSpacing;

/** 删除线 */
- (AFAttributedStringRange*)setStrikethroughStyle:(int)strikethroughStyle;
/** 删除线颜色 */
- (AFAttributedStringRange*)setStrikethroughColor:(UIColor*)StrikethroughColor NS_AVAILABLE_IOS(7_0);

/** 下划线 */
- (AFAttributedStringRange*)setUnderlineStyle:(NSUnderlineStyle)underlineStyle;
/** 下划线颜色 */
- (AFAttributedStringRange*)setUnderlineColor:(UIColor*)underlineColor NS_AVAILABLE_IOS(7_0);

/** 阴影 */
- (AFAttributedStringRange*)setShadow:(NSShadow*)shadow;

/** NSTextEffectLetterpressStyle */
- (AFAttributedStringRange*)setTextEffect:(NSString*)textEffect NS_AVAILABLE_IOS(7_0);

/** 将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排。 */
- (AFAttributedStringRange*)setAttachment:(NSTextAttachment*)attachment NS_AVAILABLE_IOS(7_0);

/** 设置区域内的文字点击后打开的链接 */
- (AFAttributedStringRange*)setLink:(NSURL*)url NS_AVAILABLE_IOS(7_0);

/** 设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示 */
- (AFAttributedStringRange*)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);

/** 设置倾斜度 */
- (AFAttributedStringRange*)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);

/** 压缩文字，正值为伸，负值为缩 */
- (AFAttributedStringRange*)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);

/** 中空文字的颜色 */
- (AFAttributedStringRange*)setStrokeColor:(UIColor*)strokeColor;

/** 中空的线宽度 */
- (AFAttributedStringRange*)setStrokeWidth:(CGFloat)strokeWidth;

/** 可以设置多个属性 */
- (AFAttributedStringRange*)setAttributes:(NSDictionary*)dict;

/** 得到构建器 */
- (AFAttributedStringBuilder*)builder;

@end


/*属性字符串构建器*/
@interface AFAttributedStringBuilder : NSObject

/** 类方法，获取builder对象 */
+ (AFAttributedStringBuilder*)builderWith:(NSString*)string;
/** 初始化builder对象 */
- (id)initWithString:(NSString*)string;

/** 指定区域,如果没有属性串或者字符串为nil则返回nil,下面方法一样。 */
- (AFAttributedStringRange*)range:(NSRange)range;

/** 全部字符 */
- (AFAttributedStringRange*)allRange;

/** 最后一个字符 */
- (AFAttributedStringRange*)lastRange;
/** 最后N个字符 */
- (AFAttributedStringRange*)lastNRange:(NSInteger)length;

/** 第一个字符 */
- (AFAttributedStringRange*)firstRange;
/** 前面N个字符 */
- (AFAttributedStringRange*)firstNRange:(NSInteger)length;

/** 用于选择特殊的字符 */
- (AFAttributedStringRange*)characterSet:(NSCharacterSet*)characterSet;

/** 用于选择特殊的字符串 */
- (AFAttributedStringRange*)includeString:(NSString*)includeString all:(BOOL)all;

/** 正则表达式 */
- (AFAttributedStringRange*)regularExpression:(NSString*)regularExpression all:(BOOL)all;

/** 段落处理,以\n结尾为一段，如果没有段落则返回nil */
- (AFAttributedStringRange*)firstParagraph;
/** 段落处理,以\n结尾为一段，如果没有段落则返回nil */
- (AFAttributedStringRange*)nextParagraph;

/** 插入，如果为0则是头部，如果为- 1则是尾部 */
- (void)insert:(NSInteger)pos attrstring:(NSAttributedString*)attrstring;
/** 插入，如果为0则是头部，如果为- 1则是尾部 */
- (void)insert:(NSInteger)pos attrBuilder:(AFAttributedStringBuilder*)attrBuilder;


/** 获取属性字符串 */
- (NSAttributedString*)commit;

@end
