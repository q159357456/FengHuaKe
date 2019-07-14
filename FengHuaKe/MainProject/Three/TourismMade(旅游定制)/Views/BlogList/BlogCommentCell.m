//
//  BlogCommentCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/13.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "BlogCommentCell.h"
@interface BlogCommentCell()
@property(nonatomic,strong)UIImageView * logo;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UIButton * btn;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,copy)NSString * code;

@end
@implementation BlogCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.logo = [[UIImageView alloc]init];
        UIView * bgView = [[UIView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.label2 = [[UILabel alloc]init];
        
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.label1.font = ZWHFont(14*MULPITLE);
        self.label2.font = ZWHFont(14*MULPITLE);
        self.label2.numberOfLines = 0;
        [self.btn setTitle:@"回复" forState:UIControlStateNormal];
        self.btn.layer.cornerRadius = 4*MULPITLE;
        self.btn.layer.masksToBounds = YES;
        self.btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.btn.titleLabel.font = ZWHFont(12*MULPITLE);
        self.btn.layer.borderWidth = 1;
        self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.logo.layer.cornerRadius = 30*MULPITLE/2;
        self.logo.layer.masksToBounds = YES;
        [self.btn addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
        
        self.logo.frame = CGRectMake(10, 10, 30*MULPITLE, 30*MULPITLE);
        bgView.frame = CGRectMake(CGRectGetMaxX(self.logo.frame)+2, self.logo.y, SCREEN_WIDTH-CGRectGetMaxX(self.logo.frame)-10, self.logo.height);
        self.label1.frame = CGRectMake(bgView.x+3, 0, 100*MULPITLE, bgView.height);
        self.btn.frame = CGRectMake(bgView.width-50*MULPITLE-10, 5*MULPITLE, 40*MULPITLE, 20*MULPITLE);
        self.label2.frame = CGRectMake(bgView.x,CGRectGetMaxY(bgView.frame)+10, bgView.width, 40);
        
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:bgView];
        [self.contentView addSubview:self.label2];
        [bgView addSubview:self.label1];
        [bgView addSubview:self.btn];
    }
    return self;
}

-(void)loadData:(CommentListModel *)model
{

    self.code = model.code;
    ImageCacheDefine(self.logo, model.logo);
    self.label1.text = model.nickname;
    self.label2.text = model.details;
    [self.label2 sizeToFit];
    NSLog(@"load data");
    UILabel * lastLabel = self.label2;
    for (NSInteger i = 0; i<model.CommentList.count; i++) {
        ReplyModel * rmodel = model.CommentList[i];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(lastLabel.x, i==0?CGRectGetMaxY(lastLabel.frame)+10:CGRectGetMaxY(lastLabel.frame), lastLabel.width, 0)];
        NSString * content = [NSString stringWithFormat:@"%@: %@",rmodel.nickname,rmodel.details];
        NSMutableAttributedString * attrbute = [[NSMutableAttributedString alloc]initWithString:content];
        NSRange range = [content rangeOfString:[NSString stringWithFormat:@"%@:",rmodel.nickname]];
        [attrbute addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range];
        label.attributedText = attrbute;
        label.font = ZWHFont(12*MULPITLE);
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [label sizeToFit];
        [self.contentView addSubview:label];
        lastLabel = label;
    }
}


+(CGFloat)cellHeight:(CommentListModel*)model{
    CGFloat height = 10 + 30*MULPITLE;
    CGSize size = [model.details boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20-30*MULPITLE-3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ZWHFont(14*MULPITLE)} context:nil].size;
    height = height + size.height;
   
    for (NSInteger i = 0; i<model.CommentList.count; i++) {
        ReplyModel * rmodel = model.CommentList[i];
         NSString * content = [NSString stringWithFormat:@"%@: %@",rmodel.nickname,rmodel.details];
          CGSize size1 = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20-30*MULPITLE-3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ZWHFont(12*MULPITLE)} context:nil].size;
        height = height + size1.height;
    }
  
    
    
    return height + 35;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat temp = 0;
//    NSLog(@"frame0 ===> %@",NSStringFromCGRect(self.frame));
//    self.frame = CGRectMake(self.x, self.y, SCREEN_WIDTH, self.height);
//    [self layoutIfNeeded];
//    NSLog(@"frame1 ===> %@",NSStringFromCGRect(self.frame));
//    for (UIView * view in self.contentView.subviews) {
////        NSLog(@"view===>%@@",view);
//        if (CGRectGetMaxY(view.frame) > temp) {
//            temp = CGRectGetMaxY(view.frame);
//        }
//    }
//    temp = temp + 10;
//    self.frame = CGRectMake(self.x, self.y, SCREEN_WIDTH, temp);
//    NSLog(@"frame2 ===>%@",NSStringFromCGRect(self.frame));
//    NSLog(@"<===>%f",temp);
//    [self layoutIfNeeded];
//    NSLog(@"frame3 ===>%@",NSStringFromCGRect(self.frame));
    
}
-(void)reply:(UIButton*)btn{
   
    if (self.rePlyCallBack) {
        self.rePlyCallBack(self.code);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
