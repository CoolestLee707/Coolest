//
//  asyncTestCell.m
//  Coolest
//
//  Created by daoj on 2019/2/19.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "asyncTestCell.h"
@interface asyncTestCell ()

//一个 ASTextNode，用于显示标题文本。ASTextNode 相当于 UILabel，不同的是能够在 ASCellNode 上使用。通常情况下，在 ASCellNode 中你不能使用 UIKit 中的UI 组件，而只能使用它们的 ASDK 的封装类。
@property (strong, nonatomic) ASTextNode *nameLabel;
@property (strong, nonatomic) ASTextNode *titleLabel;
@property (strong, nonatomic) ASTextNode *contentLabel;
@property (strong, nonatomic) ASTextNode *descContentLabel;
@property (strong, nonatomic) ASTextNode *detailCountLabel;

@property (strong, nonatomic) ASImageNode *iconImageView;
@property (strong, nonatomic) ASDisplayNode *lineNode;
@property (nonatomic,strong) UIView * lineView;

@property (strong, nonatomic) ASDisplayNode *topLineNode;

@property (strong, nonatomic) ASButtonNode *firstButton;
@property (strong, nonatomic) ASButtonNode *secondButton;
@property (strong, nonatomic) ASButtonNode *thirdButton;


@property (nonatomic,strong) AsyncDisplayModel *asyncModel;

@end

@implementation asyncTestCell

- (instancetype)init {

    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self addNode];
    }
    return self;
}

//不需要设置框架（frame）。这是因为它们的构建和布局是分开进行的（这就是框架名字中 Async 异步的由来了），在初始化方法中，你只管构建好了，布局在另一个方法中进行
- (void)addNode {
    
    _topLineNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        UIView *topLineView = [[UIView alloc]init];
        topLineView.backgroundColor =[UIColor grayColor];
        return topLineView;
    }];
    _topLineNode.style.preferredSize = CGSizeMake(Main_Screen_Width-32, 0.5);

    [self addSubnode:_topLineNode];
    
    _lineNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor blackColor];
        return self.lineView;
    }];
    _lineNode.style.preferredSize = CGSizeMake(Main_Screen_Width-32, 0.5);
    [self addSubnode:_lineNode];
    
    _iconImageView = [[ASImageNode alloc]init];
    _iconImageView.style.height = ASDimensionMake(20);
    _iconImageView.style.width = ASDimensionMake(20);
    [self addSubnode:_iconImageView];
    
    _nameLabel = [[ASTextNode alloc]init];
    [self addSubnode:_nameLabel];
    
    _titleLabel = [[ASTextNode alloc]init];
    [self addSubnode:_titleLabel];
    
    _contentLabel = [[ASTextNode alloc]init];
    [self addSubnode:_contentLabel];
    
    _descContentLabel = [[ASTextNode alloc]init];
    _descContentLabel.backgroundColor = [UIColor orangeColor];
    _descContentLabel.style.height = ASDimensionMake(20);
    [self addSubnode:_descContentLabel];
    
    _detailCountLabel = [[ASTextNode alloc]init];
    _detailCountLabel.backgroundColor = [UIColor yellowColor];
    _detailCountLabel.cornerRadius = 3;
    _detailCountLabel.clipsToBounds = YES;
    [self addSubnode:_detailCountLabel];
    
    
    _firstButton = [[ASButtonNode alloc]init];
    [_firstButton setTitle:@"first" withFont:[UIFont systemFontOfSize:17] withColor:[UIColor blackColor] forState:UIControlStateNormal];
//    设置绝对size
//    _firstButton.style.height = ASDimensionMake(40);
    _firstButton.style.preferredSize = CGSizeMake(100, 50);
    _firstButton.cornerRadius = 5;
    _firstButton.clipsToBounds = YES;
    [_firstButton setBackgroundColor:[UIColor greenColor]];
    [self addSubnode:_firstButton];
    [_firstButton addTarget:self action:@selector(firstButtonClick:) forControlEvents:ASControlNodeEventTouchUpInside];

    
    _secondButton = [[ASButtonNode alloc]init];
    [_secondButton setTitle:@"second" withFont:[UIFont systemFontOfSize:17] withColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor redColor]];
    _secondButton.style.preferredSize = CGSizeMake(100, 50);
    _secondButton.cornerRadius = 5;
    _secondButton.clipsToBounds = YES;
    [self addSubnode:_secondButton];
    [_secondButton addTarget:self action:@selector(secondButtonClick:) forControlEvents:ASControlNodeEventTouchUpInside];

    
    _thirdButton = [[ASButtonNode alloc]init];
    [_thirdButton setTitle:@"大的按钮" withFont:[UIFont systemFontOfSize:20] withColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_thirdButton setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
    
    _thirdButton.imageAlignment = ASButtonNodeImageAlignmentBeginning;
    _thirdButton.contentVerticalAlignment = ASVerticalAlignmentCenter;
    _thirdButton.contentHorizontalAlignment = ASHorizontalAlignmentMiddle;
    [_thirdButton setBackgroundColor:[UIColor lightGrayColor]];

    [self addSubnode:_thirdButton];
    _thirdButton.style.preferredSize = CGSizeMake(200, 50);
    [_thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:ASControlNodeEventTouchUpInside];
}

#pragma mark --- 所有的 ASNode 都必须在这个方法中进行布局
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    //1、一个数组，我们放入了两个对象：一个头像，一个名字
    NSArray *h1 = @[_iconImageView,_nameLabel];
    
    //2、头像和名字--设置主轴为水平方向布局，左对齐,间距10，垂直方向上对齐
    ASStackLayoutSpec *HSpec1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:h1];
    
    //3、头像和名字 + 标题 -- 设置主轴为水平方向布局，左边左对齐，右边右对齐，间距10，垂直方向上对齐
    ASStackLayoutSpec *HSpec2 =
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
     spacing:10.0
     justifyContent:ASStackLayoutJustifyContentSpaceBetween
     alignItems:ASStackLayoutAlignItemsStart
     children:@[HSpec1,_titleLabel]];

    //4、设置内容居中显示
    ASStackLayoutSpec *VSpace0 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsStart children:@[_contentLabel]];

    
    //设置descContent -- ASRelativeLayoutSpecSizingOptionMinimumHeight不会折行，需要先高度固定会...
    ASRelativeLayoutSpec *descCountSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOption:ASRelativeLayoutSpecSizingOptionMinimumHeight child:_descContentLabel];
    
    descCountSpec.style.flexShrink = 1.0;

    
    //5.1、设置详情的文字补白，这样会在这个标签的文字四周补上一些边距，不至于让文字紧紧地被边框包裹在一起，因为默认的 Inset 值是 0。
    _detailCountLabel.textContainerInset = UIEdgeInsetsMake(3, 5, 3, 5);

    //5.2、一个相对布局，这个和 Android 中的相对布局是一样的。这个相对布局我们指定它的水平对齐方式为左对齐，垂直对齐方式为中对齐，在宽度上进行紧凑布局（相当于 Android 的 layout_width=”wrap_content”)，然后将曲目数标签放入布局。这样会导致这个标签居于这个布局中的左边垂直居中，同时标签宽度不会占满整行，而是内容有多长就多宽。
    ASRelativeLayoutSpec *detailCountSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOption:ASRelativeLayoutSpecSizingOptionMinimumSize child:_detailCountLabel];
    
    //    当该控件比父控件大时，则可以在当前主轴方向上缩小或者拉伸自己，直至在当前方向上填满父空间
    detailCountSpec.style.flexShrink = 1.0;
    
    
    //按钮1\2
    ASStackLayoutSpec *ButtonSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:2.0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_firstButton,_secondButton]];
//    补白
    ASInsetLayoutSpec *ButtonInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 30, 5, 30) child:ButtonSpec];
    
    //按钮3
    ASStackLayoutSpec *ButtonSpec3 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:2.0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsStart children:@[_thirdButton]];
    
    //6、加上分割线
       ASStackLayoutSpec *lineSpec0 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:2.0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsStretch children:@[_topLineNode]];
    
    ASStackLayoutSpec *lineSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:2.0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsStretch children:@[_lineNode]];
    
    //7、要将 3个标签放到一块，上下顺序布局，需要将 3 者（即前面的数组，我们已经将 3 者放到一个数组了）添加到一个 stack 布局中。stack 布局类似自动布局中的 UIStackView，专门作为其他节点的容器，并且可以方便地指定这些节点的排列方式。这里我们在构建 stack 布局时指定三者为垂直排列，行间距 8，主轴方向(y轴)顶对齐，交叉轴方向(x轴)占据行宽。ASStackLayoutAlignItemsStretch--填充满
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[HSpec2,lineSpec0,VSpace0,descCountSpec,detailCountSpec,ButtonInsetSpec,ButtonSpec3,lineSpec]];
    
    //8、最后在 stack 布局的基础上补白。并返回补白后的 Inset 布局
    ASInsetLayoutSpec *InsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 16, 8, 16) child:contentSpec];
    return InsetSpec;
}

-(void)drawCellWithData:(AsyncDisplayModel *)model
{
    self.asyncModel = model;
    
    self.iconImageView.image = [UIImage imageNamed:@"tabbar_icon4_selected"];
    
    self.nameLabel.attributedText = [[NSAttributedString alloc]initWithString:model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.titleLabel.attributedText = [[NSAttributedString alloc]initWithString:model.title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];

    self.contentLabel.attributedText = [[NSAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor grayColor]}];

    self.descContentLabel.attributedText = [[NSAttributedString alloc]initWithString:model.descContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.detailCountLabel.attributedText = [[NSAttributedString alloc]initWithString:model.detailContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];

}

-(void)firstButtonClick:(id)sender
{
    ADLog(@"first");
}
-(void)secondButtonClick:(id)sender
{
    ADLog(@"second");
}

- (void)thirdButtonClick
{
    ADLog(@"san");
}
@end
