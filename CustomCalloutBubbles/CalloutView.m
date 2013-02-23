
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "CalloutView.h"
#import "CalloutAnnotation.h"


@implementation CalloutView
-(IBAction) handleTouch:(id)sender {
    //debug(@"touch %@", sender);
}
                                    

- (id)initWithAnnotation:(CalloutAnnotation*)annotation
{
    NSString *identifier = NSStringFromClass([self class]);
    self = [super initWithAnnotation:annotation reuseIdentifier:identifier];
    if (self!=nil){
        // prevent the tap and double tap from reaching views underneath
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        UITapGestureRecognizer *doubletapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        doubletapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubletapGestureRecognizer];
        [self configureView: annotation];
    }

    return self;
}

- (void) configureView: (CalloutAnnotation *)annotation
{
    UIFont *font = [UIFont boldSystemFontOfSize:18.0f];

    self.title.font = font;
    self.title.textColor = [UIColor whiteColor];
    self.title.backgroundColor = [UIColor clearColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.shadowColor = [UIColor darkTextColor];
    self.title.shadowOffset = CGSizeMake(0, 1);
    self.title.adjustsFontSizeToFitWidth = YES;
    self.title.text = [annotation.content.values objectForKey:@"title"];
    [self.btn addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[annotation.content.values objectForKey:@"icon"]];
    imageView.frame = CGRectMake(10 , 20, 63, 63);
    [self.scrollView addSubview:imageView];
}

- (void) buttonTapped
{
    UIAlertView *tapped = [[UIAlertView alloc] initWithTitle:@"CalloutView" message:@"User tapped button inside custom callout bubble!" delegate:self cancelButtonTitle:@"Hoorey!" otherButtonTitles:nil, nil];
    [tapped show];
}



// fixes bug in iOS 6 that displays custom annotations behind map annotations
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self.superview bringSubviewToFront:self];
}

@end
