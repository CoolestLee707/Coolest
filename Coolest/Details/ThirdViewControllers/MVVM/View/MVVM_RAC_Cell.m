//
//  MVVM_RAC_Cell.m
//  Coolest
//
//  Created by daoj on 2019/3/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVVM_RAC_Cell.h"

@implementation MVVM_RAC_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = TabbarColor;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    
    return self;
}

- (void)setUI
{
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.bottom.mas_equalTo(-20);
    }];
    
    _nameLabel.userInteractionEnabled = YES;
    kWeakSelf(weakSelf);
    [_nameLabel setTapActionWithBlock:^{
        
        if (weakSelf.tapBlock) {
            weakSelf.tapBlock(weakSelf.nameLabel.text);
        }
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
