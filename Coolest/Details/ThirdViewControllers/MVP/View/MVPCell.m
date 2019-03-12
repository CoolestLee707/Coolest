//
//  MVPCell.m
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVPCell.h"

@implementation MVPCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = TabbarColor;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUpSubView];
    }
    
    return self;
}
- (void)setUpSubView
{
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.backgroundColor = [UIColor yellowColor];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
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
