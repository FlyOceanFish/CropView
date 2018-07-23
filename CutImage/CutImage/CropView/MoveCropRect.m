//
//  MoveCropView.m
//  CutImage
//
//  Created by FlyOceanFish on 2018/7/20.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "MoveCropRect.h"

typedef NS_ENUM(NSUInteger, MoveLocation) {
    Up,
    Down,
    Left,
    Right,
    None,
};
@interface MoveCropRect()
{
    CGPoint _lastPoint;
    CGRect _lastRect;
    bool _move;
    MoveLocation _moveLocation;
}
@end

@implementation MoveCropRect

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _init];
}
- (void)_init{
    _tolerance = 20;
    _moveLocation = None;
    self.backgroundColor = [UIColor clearColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    _lastPoint = [touch locationInView:self];
    _lastRect = self.cropRect;
    //在剪裁框里外20的距离内
    if (CGRectContainsPoint(CGRectInset(self.cropRect, -_tolerance, -_tolerance), _lastPoint)) {
        CGRect newRect = CGRectInset(self.cropRect, _tolerance, _tolerance);
        if (!CGRectContainsPoint(newRect, _lastPoint)) {
            _move = true;
            CGFloat x = _lastRect.origin.x;
            CGFloat y = _lastRect.origin.y;
            CGFloat w = CGRectGetWidth(_lastRect);
            CGFloat h = CGRectGetHeight(_lastRect);
            if ((x+self.lineWidth)<_lastPoint.x&&_lastPoint.x<(x+w-self.lineWidth)) {
                if (fabs(y-_lastPoint.y)<_tolerance) {
                    _moveLocation = Up;
                }else if(fabs(_lastPoint.y-y-h)<_tolerance){
                    _moveLocation = Down;
                }
            }else if (y+self.lineWidth<_lastPoint.y&&_lastPoint.y<y+h-self.lineWidth){
                if (fabs(x-_lastPoint.x)<_tolerance) {
                    _moveLocation = Left;
                }else{
                    _moveLocation = Right;
                }
            }else{
                _moveLocation = None;
            }
        }
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    CGFloat x = _lastRect.origin.x;
    CGFloat y = _lastRect.origin.y;
    CGFloat w = CGRectGetWidth(_lastRect);
    CGFloat h = CGRectGetHeight(_lastRect);
    if (_move) {
        switch (_moveLocation) {
            case Down:{
                if (point.y<y+self.lineWidth) {
                    return;
                }
                self.cropRect = CGRectMake(x, y, w,point.y-y);
            }
                break;
            case Up:{
                if (point.y>(y+h-self.lineWidth)) {
                    return;
                }
                self.cropRect = CGRectMake(x, point.y, w,y-point.y+h);
            }
                break;
            case Left:{
                if (point.x>(x+w-self.lineWidth)) {
                    return;
                }
                self.cropRect = CGRectMake(point.x, y,x-point.x+w,h);
            }
                break;
            case Right:{
                if (point.x<(x+self.lineWidth)) {
                    return;
                }
                self.cropRect = CGRectMake(x, y,point.x-x,h);
            }
            break;
            default:
                break;
        }
        [self setNeedsDisplay];
        _lastRect = self.cropRect;

    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _lastPoint = CGPointZero;
    _move = false;
    _moveLocation = None;
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _lastPoint = CGPointZero;
    _move = false;
    _moveLocation = None;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
