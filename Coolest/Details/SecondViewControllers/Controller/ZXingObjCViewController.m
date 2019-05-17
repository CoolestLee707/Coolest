//
//  ZXingObjCViewController.m
//  Coolest
//
//  Created by daoj on 2019/4/15.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "ZXingObjCViewController.h"
#import "ZXingObjC.h"

@interface ZXingObjCViewController ()<ZXCaptureDelegate>

@property (nonatomic,strong) UIImageView *codeImageView;

@property (nonatomic,strong) UIButton *scanButton;

@property (nonatomic,strong) ZXCapture *capture;

@end

@implementation ZXingObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码";
    
    self.codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-100, kNavigationBarHeight + 10, 200, 200)];
    self.codeImageView.userInteractionEnabled = YES;
    self.codeImageView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:self.codeImageView];
    
    kWeakSelf(WeakSelf);
    
    [self.codeImageView setTapActionWithBlock:^{
        
        [WeakSelf createQRCode];
    }];
    
    
    self.scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scanButton.frame = CGRectMake(Main_Screen_Width/2-50, kNavigationBarHeight + 310, 100, 100);
    [self.scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    [self.scanButton setBackgroundColor: [UIColor redColor]];
    [self.scanButton addTargetSelected:^(UIButton * _Nonnull button) {
        [WeakSelf scanCode];
    }];
    [self.view addSubview:self.scanButton];
}

- (void)scanCode {
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    //自动聚焦
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    self.capture.layer.frame = CGRectMake(0, 0,Main_Screen_Width, Main_Screen_Height);
    
    self.capture.scanRect = CGRectMake(Main_Screen_Width/2 -150, Main_Screen_Height/2 -150, 300, 300);
    [self.view.layer addSublayer:self.capture.layer];
    
    self.capture.delegate = self;

}

-(void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if (!result) return;
    
    [self.capture stop];

    ADLog(@"扫描结果为 - %@\n",result.text);

    //如果扫到的是二维码:
    if (result.barcodeFormat == kBarcodeFormatQRCode) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.capture start];
        });
    }
    
}
- (void)createQRCode
{
    NSString *data = @"https://www.baidu.com";
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc]init];
    
    ZXEncodeHints *hints = [ZXEncodeHints hints];
    hints.margin = @0;//无间距
    ZXBitMatrix *result = [writer encode:data
                                  format:kBarcodeFormatQRCode
                                   width:self.codeImageView.width
                                  height:self.codeImageView.height
                                   hints:hints
                                   error:nil];
    
    //默认有间距
//    ZXBitMatrix *result = [writer encode:data format:kBarcodeFormatQRCode width:self.codeImageView.width height:self.codeImageView.height error:nil];
    
    if (result) {
         ZXImage *zxImage = [ZXImage imageWithMatrix:result];
//        self.codeImageView.image = [UIImage imageWithCGImage:zxImage.cgimage];

        UIImage *image = [UIImage imageWithCGImage:zxImage.cgimage];
        UIImage *logoRQCode = [self addLogoOnQROrigin:image logo:[UIImage imageNamed:@"cart_circle_select"]];
        self.codeImageView.image = logoRQCode;
    }

}


-(UIImage *)addLogoOnQROrigin:(UIImage *)qrOrigin logo:(UIImage *)logoImg
{
    //get image width and height
    int w = qrOrigin.size.width;
    int h = qrOrigin.size.height;
    int subWidth = w*0.2;
    int subHeight = h*0.2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), qrOrigin.CGImage);
    CGContextDrawImage(context, CGRectMake( (w-subWidth)/2, (h - subHeight)/2, subWidth, subHeight), [logoImg CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}
@end
