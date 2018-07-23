//
//  CropView.m
//  CutImage
//
//  Created by FlyOceanFish on 2018/7/23.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "CropView.h"
#import "MoveCropRect.h"

@interface CropView()

@property(nonatomic,strong)UIImageView *iv;
@property(nonatomic,strong)MoveCropRect *moveCropRect;
@property(nonatomic,strong)UIButton *doneBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@end

@implementation CropView
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        [self _initViews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self _initViews];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initViews];
}
-(void)_initViews{
    [self addSubview:self.iv];
    self.moveCropRect.cropRect = CGRectMake(40, MIN(100, CGRectGetHeight(self.bounds)), CGRectGetWidth(self.bounds)-80, 100);
    [self addSubview:self.moveCropRect];
    [self addSubview:self.doneBtn];
    [self addSubview:self.cancleBtn];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.iv.frame = self.bounds;
    self.moveCropRect.frame = self.bounds;
    self.doneBtn.frame = CGRectMake(CGRectGetWidth(self.bounds)-80, CGRectGetHeight(self.bounds)-60, 60, 40);
    self.cancleBtn.frame = CGRectMake(20, CGRectGetHeight(self.bounds)-60, 60, 40);
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.iv.image = image;
}

-(MoveCropRect *)moveCropRect{
    if (_moveCropRect==nil) {
        _moveCropRect = [[MoveCropRect alloc] initWithFrame:CGRectZero];
    }
    return _moveCropRect;
}
-(UIImageView *)iv{
    if (_iv == nil) {
        _iv = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iv.contentMode = UIViewContentModeScaleToFill;
        _iv.backgroundColor = [UIColor blackColor];
    }
    return _iv;
}
-(UIButton *)doneBtn{
    if (_doneBtn==nil) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(actionDone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}
-(UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (void)actionDone{
    CGRect rect = self.moveCropRect.cropRect;
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    CGFloat wScale = imageWidth/CGRectGetWidth(self.bounds);
    CGFloat hScale = imageHeight/CGRectGetHeight(self.bounds);
    CGFloat imageScale = self.image.scale;
    
    CGRect cropRect = CGRectMake(rect.origin.x*wScale*imageScale, rect.origin.y*hScale*imageScale, CGRectGetWidth(rect)*wScale*imageScale, CGRectGetHeight(rect)*hScale*imageScale);
    UIImage *image = [self imageFromImage:self.image inRect:cropRect];
    if (self.cropDone) {
        self.cropDone(image);
    }
}
- (void)actionCancel{
    if (self.cropCancel) {
        self.cropCancel();
    }
}
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    CGImageRef sourceImageRef = [image CGImage];
    
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
