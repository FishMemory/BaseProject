//
//  CaseTableViewCell.h
//   
//
//  Created by Michael on 17/1/11.
//  Copyright © 2017年  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLabel.h"

@interface CaseTableViewCell : UITableViewCell
@property (strong, nonatomic) UIView *backView;/**< 背景 >*/
@property (strong, nonatomic) UIImageView *caseImage;
@property (strong, nonatomic) DLLabel *caseLabel;
@property (strong, nonatomic) DLLabel *dateLabel;
@property (strong, nonatomic) UIButton *selectBtn;
-(void)setCellData:(UIImage*)image caseName:(NSString*) caseName dateString:(NSString*)dateStr;
@end
