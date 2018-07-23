//
//  CropView.m
//  CutImage
//
//  Created by FlyOceanFish on 2018/7/20.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "CropRect.h"

@implementation CropRect

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self _initPara];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initPara];
}
-(void)_initPara{
    self.backgroundColor = [UIColor clearColor];
    self.lineWidth = 10;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat thinLineWidth = 2;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    绘制背景色
    CGContextSetRGBFillColor(ctx, 0.15, 0.15, 0.15, 0.8);
    CGContextFillRect(ctx, rect);
    
//  绘制中间透明部分
    CGContextClearRect(ctx, self.cropRect);
    
//    绘制框框
    CGContextSetLineWidth(ctx,thinLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(ctx, self.cropRect);
    
    [self addFourCorners:ctx thinLineWidth:thinLineWidth];

}
- (void)addFourCorners:(CGContextRef)ctx thinLineWidth:(CGFloat)thinLineWidth{
    CGFloat fatLineWidth = 4;
    //    绘制4个角
    CGFloat x = self.cropRect.origin.x;
    CGFloat y = self.cropRect.origin.y;
    CGFloat width = CGRectGetWidth(self.cropRect);
    CGFloat height = CGRectGetHeight(self.cropRect);
    
    //    左上角
    CGContextMoveToPoint(ctx, x+thinLineWidth/2, y-thinLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+self.lineWidth, y-thinLineWidth/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, x-thinLineWidth/2, y-fatLineWidth/2-thinLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x-thinLineWidth/2, y+self.lineWidth);
    CGContextStrokePath(ctx);
    //    左下角
    CGContextMoveToPoint(ctx, x+thinLineWidth/2-fatLineWidth/2, y+height-self.lineWidth-thinLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+thinLineWidth/2-fatLineWidth/2, y+height-thinLineWidth/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, x+thinLineWidth/2-fatLineWidth, y+height-thinLineWidth/2+fatLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+fatLineWidth+self.lineWidth, y+height-thinLineWidth/2+fatLineWidth/2);
    CGContextStrokePath(ctx);
    
    //    右上角
    CGContextMoveToPoint(ctx, x+width-self.lineWidth-thinLineWidth/2, y+thinLineWidth/2-fatLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+width-thinLineWidth/2, y+thinLineWidth/2-fatLineWidth/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx,x+width-thinLineWidth/2+fatLineWidth/2, y+thinLineWidth/2-fatLineWidth);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+width-thinLineWidth/2+fatLineWidth/2, y+thinLineWidth/2-fatLineWidth+fatLineWidth+self.lineWidth);
    CGContextStrokePath(ctx);
    
    //    右下角
    CGContextMoveToPoint(ctx, x+width-self.lineWidth-thinLineWidth/2-fatLineWidth, y+height-thinLineWidth/2+fatLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+width-thinLineWidth/2+fatLineWidth,y+height-thinLineWidth/2+fatLineWidth/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, x+width-thinLineWidth/2+fatLineWidth/2, y+height-thinLineWidth/2);
    CGContextSetLineWidth(ctx, fatLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddLineToPoint(ctx, x+width-thinLineWidth/2+fatLineWidth/2, y+height-thinLineWidth/2-self.lineWidth);
    CGContextStrokePath(ctx);
}

@end
