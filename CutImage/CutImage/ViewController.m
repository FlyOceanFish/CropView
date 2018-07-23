//
//  ViewController.m
//  CutImage
//
//  Created by FlyOceanFish on 2018/7/20.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "ViewController.h"
#import "CropView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet CropView *cropView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cropView.image = [UIImage imageNamed:@"test.jpg"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
