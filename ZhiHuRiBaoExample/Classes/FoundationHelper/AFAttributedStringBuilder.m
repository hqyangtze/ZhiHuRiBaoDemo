//
//  AFAttributedStringBuilder.m
//  AppFrame
//
//  Created by HQ on 2016/12/1.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "AFAttributedStringBuilder.h"

@implementation AFAttributedStringRange{
    NSMutableArray *_ranges;
    NSMutableAttributedString *_attrString;
    AFAttributedStringBuilder *_builder;
}

- (id)initWithAttributeString:(NSMutableAttributedString*)attrString builder:(AFAttributedStringBuilder*)builder{
    self = [self init];
    if (self != nil){
        _attrString = attrString;
        _builder = builder;
        _ranges = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)addRange:(NSRange)range{
    [_ranges addObject:[NSValue valueWithRange:range]];
}

- (void)enumRange:(void(^)(NSRange range))block{
    if (self == nil || _attrString == nil) return;

    for (int i = 0; i < _ranges.count; i++){
        NSRange range = ((NSValue*)[_ranges objectAtIndex:i]).rangeValue;
        if (range.location == NSNotFound || range.length == 0)
            continue;

        block(range);
    }
}

- (AFAttributedStringRange*)setFont:(UIFont*)font{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSFontAttributeName value:font range:range];

    }];
    return self;
}

- (AFAttributedStringRange*)setTextColor:(UIColor*)color{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setBackgroundColor:(UIColor*)color{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSBackgroundColorAttributeName value:color range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setParagraphStyle:(NSParagraphStyle*)paragraphStyle{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setLigature:(BOOL)ligature{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInteger:ligature] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setKern:(CGFloat)kern{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:kern] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setLineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *ps  = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = lineSpacing;
    return [self setParagraphStyle:ps];
}

- (AFAttributedStringRange*)setStrikethroughStyle:(int)strikethroughStyle{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:strikethroughStyle] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setStrikethroughColor:(UIColor*)strikethroughColor{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSStrikethroughColorAttributeName value:strikethroughColor range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setUnderlineStyle:(NSUnderlineStyle)underlineStyle{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underlineStyle] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setShadow:(NSShadow*)shadow{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSShadowAttributeName value:shadow range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setTextEffect:(NSString*)textEffect{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSTextEffectAttributeName value:textEffect range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setAttachment:(NSTextAttachment*)attachment{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSAttachmentAttributeName value:attachment range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setLink:(NSURL*)url{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSLinkAttributeName value:url range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setBaselineOffset:(CGFloat)baselineOffset{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:baselineOffset] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setUnderlineColor:(UIColor*)underlineColor{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSUnderlineColorAttributeName value:underlineColor range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setObliqueness:(CGFloat)obliqueness{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:obliqueness] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setExpansion:(CGFloat)expansion{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSExpansionAttributeName value:[NSNumber numberWithFloat:expansion] range:range];
    }];
    return self;
}


- (AFAttributedStringRange*)setStrokeColor:(UIColor*)strokeColor{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setStrokeWidth:(CGFloat)strokeWidth{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:strokeWidth] range:range];
    }];
    return self;
}

- (AFAttributedStringRange*)setAttributes:(NSDictionary*)dict{
    [self enumRange:^(NSRange range){
        [_attrString addAttributes:dict range:range];
    }];
    return self;
}

- (AFAttributedStringBuilder*)builder{
    return _builder;
}

@end


@implementation AFAttributedStringBuilder{
    NSMutableAttributedString *attrString;
    NSInteger paragraphIndex;
}

+ (AFAttributedStringBuilder*)builderWith:(NSString*)string{
    return [[AFAttributedStringBuilder alloc] initWithString:string];
}


- (id)initWithString:(NSString*)string{
    self = [self init];
    if (self != nil){
        if (string != nil)
            attrString = [[NSMutableAttributedString alloc] initWithString:string];
        else
            attrString = nil;
        paragraphIndex = 0;
    }

    return self;
}

- (AFAttributedStringRange*)range:(NSRange)range{
    if (attrString == nil) return nil;

    if (attrString.length < range.location + range.length) return nil;

    AFAttributedStringRange *attrstrrang = [[AFAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    [attrstrrang addRange:range];
    return attrstrrang;
}

- (AFAttributedStringRange*)allRange{
    if (attrString == nil) return nil;

    NSRange range = NSMakeRange(0, attrString.length);
    return [self range:range];
}

- (AFAttributedStringRange*)lastRange{
    if (attrString == nil) return nil;

    NSRange range = NSMakeRange(attrString.length -  1, 1);
    return [self range:range];
}

- (AFAttributedStringRange*)lastNRange:(NSInteger)length{
    if (attrString == nil) return nil;

    return [self range:NSMakeRange(attrString.length -  length, length)];
}

- (AFAttributedStringRange*)firstRange{
    if (attrString == nil) return nil;

    NSRange range = NSMakeRange(0, attrString.length > 0 ? 1 : 0);
    return [self range:range];
}

- (AFAttributedStringRange*)firstNRange:(NSInteger)length{
    if (attrString == nil) return nil;

    return [self range:NSMakeRange(0, length)];
}

- (AFAttributedStringRange*)characterSet:(NSCharacterSet*)characterSet{
    if (attrString == nil) return nil;

    //遍历所有字符，然后计算数值
    AFAttributedStringRange *attrstrrang = [[AFAttributedStringRange alloc] initWithAttributeString:attrString builder:self];

    NSString *str = attrString.string;
    NSRange range = NSMakeRange(0, 0);
    BOOL isStart = YES;
    for (int i = 0; i < str.length; i++){
        unichar uc  = [str characterAtIndex:i];
        if ([characterSet characterIsMember:uc]){
            if (isStart){
                range.location = i;
                range.length = 0;
                isStart = NO;
            }
            range.length++;
        }else{
            if (!isStart){
                isStart = YES;
                [attrstrrang addRange:range];
            }
        }
    }

    if (!isStart) [attrstrrang addRange:range];
    return attrstrrang;
}


- (AFAttributedStringRange*)searchString:(NSString*)searchString options:(NSStringCompareOptions)options all:(BOOL)all{
    if (attrString == nil) return nil;

    AFAttributedStringRange *attRange = [[AFAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    NSString *str = attrString.string;
    if (!all){
        return [self range:[str rangeOfString:searchString options:options]];
    }else{
        NSRange searchRange = NSMakeRange(0, str.length);
        NSRange range = NSMakeRange(0, 0);

        while(range.location != NSNotFound && searchRange.location < str.length){
            range = [str rangeOfString:searchString options:options range:searchRange];
            [attRange addRange:range];
            if (range.location != NSNotFound){
                searchRange.location = range.location + range.length;
                searchRange.length = str.length -  searchRange.location;
            }
        }
    }

    return attRange;
}

- (AFAttributedStringRange*)includeString:(NSString*)includeString all:(BOOL)all{
    return [self searchString:includeString options:0 all:all];
}

- (AFAttributedStringRange*)regularExpression:(NSString*)regularExpression all:(BOOL)all{
    return [self searchString:regularExpression options:NSRegularExpressionSearch all:all];
}

- (AFAttributedStringRange*)firstParagraph{
    if (attrString == nil) return nil;

    paragraphIndex = 0;
    NSString *str = attrString.string;
    NSRange range = NSMakeRange(0, 0);
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++){
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n'){
            range.location =  0;
            range.length = i + 1;
            paragraphIndex = i + 1;
            break;
        }
    }

    if (i >= str.length){
        range.location = 0;
        range.length = i;
        paragraphIndex = i;
    }

    return [self range:range];
}

- (AFAttributedStringRange*)nextParagraph{
    if (attrString == nil) return nil;

    NSString *str = attrString.string;
    if (paragraphIndex >= str.length) return nil;

    NSRange range = NSMakeRange(0, 0);
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++){
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n'){
            range.location =  paragraphIndex;
            range.length = i -  paragraphIndex + 1;
            paragraphIndex = i + 1;
            break;
        }
    }

    if (i >= str.length){
        range.location = paragraphIndex;
        range.length = i -  paragraphIndex;
        paragraphIndex = i + 1;
    }

    return [self range:range];
}

- (void)insert:(NSInteger)pos attrstring:(NSAttributedString*)attrstring{
    if (attrString == nil || attrstring == nil) return;

    if (pos == - 1)
        [attrString appendAttributedString:attrstring];
    else
        [attrString insertAttributedString:attrstring atIndex:pos];
}

- (void)insert:(NSInteger)pos attrBuilder:(AFAttributedStringBuilder*)attrBuilder{
    [self insert:pos attrstring:attrBuilder.commit];
}

- (NSAttributedString*)commit{
    return attrString;
}

@end
