//
//  JBICheckMark.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 8/1/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBICheckMark.h"

@implementation JBICheckMark

//@synthesize checked;

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if ( self.checked )
        [self drawRectChecked:rect];
    else
    {
        if ( self.checkMarkStyle == JBICheckMarkStyleOpenCircle )
            [self drawRectOpenCircle:rect];
        else if ( self.checkMarkStyle == JBICheckMarkStyleGrayedOut )
            [self drawRectGrayedOut:rect];
    }
}

- (void) setChecked:(bool)checked
{
    _checked = checked;
    [self setNeedsDisplay];
}

- (void) setCheckMarkStyle:(JBICheckMarkStyle)checkMarkStyle
{
    _checkMarkStyle = checkMarkStyle;
    [self setNeedsDisplay];
}

- (void) drawRectChecked: (CGRect) rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* checkmarkBlue2 = [UIColor colorWithRed: 0.078 green: 0.435 blue: 0.875 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow2 = [UIColor blackColor];
    CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
    CGFloat shadow2BlurRadius = 2.5;
    
    //// Frames
    CGRect frame = self.bounds;
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6);
    
    
    //// Group
    {
        //// CheckedOval Drawing
        UIBezierPath* checkedOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5))];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
        [checkmarkBlue2 setFill];
        [checkedOvalPath fill];
        CGContextRestoreGState(context);
        
        [[UIColor whiteColor] setStroke];
        checkedOvalPath.lineWidth = 1;
        [checkedOvalPath stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.27083 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.54167 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.41667 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.68750 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.75000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35417 * CGRectGetHeight(group))];
        bezierPath.lineCapStyle = kCGLineCapSquare;
        
        [[UIColor whiteColor] setStroke];
        bezierPath.lineWidth = 1.3;
        [bezierPath stroke];
    }
}

- (void) drawRectGrayedOut: (CGRect) rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* grayTranslucent = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.6];
    
    //// Shadow Declarations
    UIColor* shadow2 = [UIColor blackColor];
    CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
    CGFloat shadow2BlurRadius = 2.5;
    
    //// Frames
    CGRect frame = self.bounds;
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6);
    
    
    //// Group
    {
        //// UncheckedOval Drawing
        UIBezierPath* uncheckedOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5))];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
        [grayTranslucent setFill];
        [uncheckedOvalPath fill];
        CGContextRestoreGState(context);
        
        [[UIColor whiteColor] setStroke];
        uncheckedOvalPath.lineWidth = 1;
        [uncheckedOvalPath stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.27083 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.54167 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.41667 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.68750 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.75000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35417 * CGRectGetHeight(group))];
        bezierPath.lineCapStyle = kCGLineCapSquare;
        
        [[UIColor whiteColor] setStroke];
        bezierPath.lineWidth = 1.3;
        [bezierPath stroke];
    }
}

- (void) drawRectOpenCircle: (CGRect) rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, -0.1);
    CGFloat shadowBlurRadius = 0.5;
    UIColor* shadow2 = [UIColor blackColor];
    CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
    CGFloat shadow2BlurRadius = 2.5;
    
    //// Frames
    CGRect frame = self.bounds;
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6);
    
    
    //// Group
    {
        //// EmptyOval Drawing
        UIBezierPath* emptyOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5))];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
        CGContextRestoreGState(context);
        
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        [[UIColor whiteColor] setStroke];
        emptyOvalPath.lineWidth = 1;
        [emptyOvalPath stroke];
        CGContextRestoreGState(context);
    }
}

@end
