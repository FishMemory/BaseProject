//
//  MyNavigationBar.h
// 

#import <UIKit/UIKit.h>

@interface MyNavigationBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *navigationTitle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *line;


-(void)addRightView:(UIView*)view;
-(void)hideTitle;
@end
