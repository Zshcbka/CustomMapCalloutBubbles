
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "BaseCalloutView.h"

@class CalloutAnnotation;

@interface CalloutView : BaseCalloutView <UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *description;
@property (retain, nonatomic) IBOutlet UIButton *btn;


-(IBAction) handleTouch:(id)sender;
- (id)initWithAnnotation:(CalloutAnnotation*)annotation;

@end
