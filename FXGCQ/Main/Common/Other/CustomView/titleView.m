

#import "titleView.h"

@implementation titleView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)titlestring titleColor:(UIColor *)titleColor position:(NSTextAlignment)textPosition{
    if(self = [super initWithFrame:frame]){
        self.text  = titlestring;
        self.textColor = titleColor;
        self.textAlignment  = textPosition;
        self.font = [UIFont systemFontOfSize:18];
        
    }
    return self;

}
-(void)setLabelText:( NSString * _Nullable )labelText{
    
    self.text = labelText;
}
-(void)setColor:(UIColor *)color{
   self.textColor  = color; 
}
-(void)setLabelColor:(UIColor *)color{
    self.textColor  = color;
}
@end
