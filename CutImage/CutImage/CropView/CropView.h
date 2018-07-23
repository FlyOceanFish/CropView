//
//  CropView.h
//  CutImage
//
//  Created by FlyOceanFish on 2018/7/23.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CropDone)(UIImage *);
typedef void(^CropCancel)();

@interface CropView : UIView

@property (nonatomic,strong)UIImage *image;
@property (nonatomic,copy) CropDone cropDone;
@property (nonatomic,copy) CropCancel cropCancel;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
@end
