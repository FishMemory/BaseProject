//
//  CaseTableViewCell.m
//   
//
//  Created by Michael on 17/1/11.
//  Copyright © 2017年  . All rights reserved.
//

#import "CaseTableViewCell.h"
@interface CaseTableViewCell()
//{
//    UIView *backView;/**< 背景 >*/
//    UIImageView *caseImage;
//    DLLabel *caseLabel;
//    DLLabel *dateLabel;
//    UIButton *selectBtn;
//}
@end
@implementation CaseTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        [self initCell];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initCell
{
    // 白色背景
    _backView  = [[UIView alloc]initWithFrame:FRAME(0, 0, SCREEN_WIDTH, PX(139))];
    [self.contentView addSubview:_backView];
    
    // 单选图标
    _selectBtn = [DLButton buttonType:UIButtonTypeCustom frame:FRAME(PX(30), PX(40), 0, 0) titleColor:nil title:@"" cornerRadius:0];
    _selectBtn.enabled = NO;
    [_selectBtn setBackgroundImage:ImageNamed(@"sl_check") forState:UIControlStateSelected];
    [_selectBtn setBackgroundImage:ImageNamed(@"sl_blank") forState:UIControlStateNormal];
    [_backView addSubview:_selectBtn];
    // 消息图标
    _caseImage = [[UIImageView alloc]initWithFrame:FRAME(_selectBtn.right+ PX(30), (_backView.height-PX(85))/2.0, PX(66), PX(85))];
    _caseImage.image = [UIImage imageNamed:@"wodebinglitubiao@3x"];
    [_backView addSubview:_caseImage];
    
    // 病例标题
    _caseLabel = [[DLLabel alloc]initWithText:@"" font:FONT(PX(26)) textColor:COL_BLACK_FONT];
    _caseLabel.frame = FRAME(_caseImage.right+PX(24), _caseImage.top+PX(18), SCREEN_WIDTH - _caseImage.width - PX(84), PX(40));
    [_backView addSubview:_caseLabel];
    
    
    // 日期
    _dateLabel = [[DLLabel alloc]initWithText:@"" font:FONT(PX(26)) textColor:COL_BLACK_FONT];
    _dateLabel.frame = FRAME(_caseImage.right+PX(24), _caseLabel.bottom+PX(20), SCREEN_WIDTH - _caseImage.width - PX(84), PX(40));
    [_backView addSubview:_dateLabel];
}

-(void)setCellData:(UIImage*)image caseName:(NSString*) caseName dateString:(NSString*)dateStr
{
    _caseImage.frame =  FRAME(_selectBtn.right+ PX(30), (_backView.height-PX(85))/2.0, PX(66), PX(85));
    _caseImage.image = image;
    
    _caseLabel.frame = FRAME(_caseImage.right+PX(24), _caseImage.top+PX(18), SCREEN_WIDTH - _caseImage.width - PX(84), PX(40));
    _caseLabel.text = caseName;
    
    _dateLabel.frame = FRAME(_caseImage.right+PX(24), _caseLabel.bottom+PX(20), SCREEN_WIDTH - _caseImage.width - PX(84), PX(40));
    _dateLabel.text= dateStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
