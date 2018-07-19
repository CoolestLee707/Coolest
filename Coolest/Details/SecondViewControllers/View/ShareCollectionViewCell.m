//
//  ShareCollectionViewCell.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "ShareCollectionViewCell.h"

@interface ShareCollectionViewCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *baview;
@end

@implementation ShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置控件
        self.baview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.baview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baview];
        
        [self.baview addBottomShadow];
        
        [self createSubViews];
        
    }
    
    return self;
}

- (void)createSubViews
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.backgroundColor = RGBCOLOR(100+arc4random()%155, 100+arc4random()%155, 100+arc4random()%155);
    self.titleLabel.textColor = BaseBlueColor;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 0;
    [self.baview addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(10);
        make.bottom.right.mas_equalTo(-10);
        
    }];
}

- (void)configData:(NSString *)dataString
{
    self.titleLabel.text = dataString;
}

@end
