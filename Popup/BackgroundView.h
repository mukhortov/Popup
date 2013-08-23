#define ARROW_WIDTH 12
#define ARROW_HEIGHT 8
#include <WebKit/WebKit.h>

@interface BackgroundView : NSView {

	IBOutlet WebView *webView;
	
    NSInteger _arrowX;
}



@property (nonatomic, assign) NSInteger arrowX;

//@property (assign) IBOutlet NSWindow *window;
@property (retain, nonatomic) IBOutlet WebView *webView;


@end
