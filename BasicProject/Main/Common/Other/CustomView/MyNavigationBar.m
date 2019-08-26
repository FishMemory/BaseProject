//
//  MyNavigationBar.m
  
#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.height = kTopSafeHeight;
    self.width = SCREEN_WIDTH;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.height = kTopSafeHeight;
        self.width = SCREEN_WIDTH;
    }
    return self;
}

-(void)addRightView:(UIView *)view{
    
    [self.centerView addSubview:view];
}

-(void)hideTitle{
    self.navigationTitle.hidden = YES;
    
}


@end
