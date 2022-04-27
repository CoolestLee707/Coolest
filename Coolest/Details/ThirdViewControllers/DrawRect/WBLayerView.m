//
//  WBLayerView.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/25.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "WBLayerView.h"

@implementation WBLayerView

- (void)layoutSubviews{
    ADLog(@"WBLayerView---layoutSubviews----%s",__func__);
}
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

// 系统绘制
/**
 1）两种自定义控件样式的方法各有优缺点，CAShapeLayer配合贝赛尔曲线使用时，绘图形状更灵活，而drawRect只是一个方法而已，在其中更适合绘制大量有规律的通用的图形；
 （2）CALayer的属性变化默认会有动画，drawRect绘图没有动画；
 （3）CALayer绘制图形是实时的，drawRect多次重绘需要手动调用setNeedsLayout；
 （4）性能方面，CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多，CAShapeLayer属于CoreAnimation框架，动画渲染直接提交给手机GPU，不消耗内，而Core Graphics会消耗大量的CPU资源。
 */
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    ADLog(@"WBLayerView---drawRect----%s",__func__);
    CGSize size = self.bounds.size;;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString * textC =@"drawRect判断 layer 是否有代理：没有代理的话，就调用 layer 的 drawInContext: 方法，有代理的话，调用 delegate 的drawLayer : inContext 方法，这个方法实现是系统完成。";
    UIFont * textFont = [UIFont boldSystemFontOfSize:18];
    UIColor * textColor = [UIColor redColor];
    UIImage * getImg = [self displayString:textC textColor:textColor textFont:textFont curSize:size curScale:scale];
    [getImg drawInRect:rect];
}

/**
 1、当我们操作UI时，例如改变frame、更新UIView/CALayer，或者自己去调用setNeedsLayout/setNeedsDisplay方法，
 2、UIView会调用-[CALayer setNeedsLayout]/-[CALayer setNeedsDisplay]方法，给layer上打上一个脏标记，意味着需要重绘。
 3、但是只有在下一次runloop即将结束的时候才会调用[CALayer display],
 4、而这个方法会判断是否实现了displayLayer这个方法，如果没有实现，那么走系统调用，如果实现了就为我们提供了异步绘制的入口
 这个就是异步入口。。。。。
 
 首先 UIView 调用 setNeedsDisplay 方法
 其实是调用其 layer 属性的同名方法（view.layer setNeedsDisplay）
 这时 layer 并不会立刻调用 display 方法,而是要等到当前 runloop 即将结束的时候调用 display，进入到绘制流程。
 在 UIView 中 layer.delegate 就是 UIView 本身，UIView 并没有实现 displayLayer: 方法，所以进入系统的绘制流程，我们可以通过实现 displayLayer: 方法来进行异步绘制。
 */
- (void)displayLayer:(CALayer *)layer{
    ADLog(@"WBLayerView---displayLayer----%s",__func__);
    /**
     除了在drawRect方法中, 其他地方获取context需要自己创建[https://www.jianshu.com/p/86f025f06d62]
    coreText用法简介:[https://www.cnblogs.com/purple-sweet-pottoes/p/5109413.html]
    */
    CGSize size = self.bounds.size;;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString * textC =@"1、首先在主线程调用setNeedsdispay方法；\n2、系统会在runloop将要结束的时候调用[CAlayer display]方法；\n3、如果我们的代理实现了dispayLayer这个方法，会调用dispayLayer这个方法。我们可以去子线程里面进行异步绘制。子线程主要做的工作：创建上下文，UI控件的绘制工作，生成对应的图片（bitmap），主线程可以做其他工作；\n4、异步绘制完事之后，回到主线程，把绘制的bitmap赋值view.layer.contents属性中";
    UIFont * textFont = [UIFont boldSystemFontOfSize:14];
    UIColor * textColor = [UIColor orangeColor];
    ///异步绘制:切换至子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * getImg = [self displayString:textC textColor:textColor textFont:textFont curSize:size curScale:scale];
        ///子线程完成工作, 切换到主线程展示
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (__bridge id)getImg.CGImage;
        });
    });
}


/*如果layer有delegate，调用delegate的 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx方法，
 如果layer没有delegate，调用-[CALayer drawInContext:]方法,
 */
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    ADLog(@"WBLayerView---drawLayer inContext----%s",__func__);
//    [super drawLayer:layer inContext:ctx];
//    CGSize size = self.bounds.size;;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    NSString * textC =@"一眉道人鱼、红鼻剪刀、红绿灯鱼、对勾鱼、道孚都是好肉";
//    UIFont * textFont = [UIFont boldSystemFontOfSize:18];
//    UIColor * textColor = [UIColor greenColor];
//    UIImage * getImg = [self displayString:textC textColor:textColor textFont:textFont curSize:size curScale:scale];
//    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 200), getImg.CGImage);
//    CGContextRestoreGState(ctx);
//}

// 绘制生成的bitmap
- (UIImage *)displayString:(NSString *)textC textColor:(UIColor *)textColor textFont:(UIFont *)textFont curSize:(CGSize)size curScale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    ///获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    ///将坐标系反转
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    ///文本沿着Y轴移动
    CGContextTranslateCTM(context, 0, size.height);
    ///文本反转成context坐标系
    CGContextScaleCTM(context, 1.0, -1.0);
    ///创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    ///创建需要绘制的文字
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:textC];
    [attStr addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, textC.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, textC.length)];
    ///根据attStr生成CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attStr.length), path, NULL);
    ///将frame的内容绘制到content中
    CTFrameDraw(frame, context);
    UIImage *getImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //6.释放资源
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
    
    return getImg;
}
@end

//总结
//delegate实现了displayLayer方法，有：异步绘制；
//没有：系统绘制，如果layer有delegate，调用delegate的 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx方法，和 - (void)drawRect:(CGRect)rect，在系统绘制基础上在做一些事
//如果layer没有delegate，调用-[CALayer drawInContext:]方法
