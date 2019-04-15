//
//  HomeCell.m
//  Coolest
//
//  Created by daoj on 2019/4/12.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (IBAction)buttonClick:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(self.nameLabel.text);
    }
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
