#import "BackgroundView.h"
#import <QuartzCore/QuartzCore.h>

#define FILL_OPACITY 0.9f
#define STROKE_OPACITY 1.0f

#define LINE_THICKNESS 1.0f
#define CORNER_RADIUS 6.0f

#define SEARCH_INSET 10.0f

#pragma mark -

@implementation BackgroundView

@synthesize arrowX = _arrowX;
@synthesize webView = webView;

#pragma mark -

// Webview
//- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
/*
    NSString *urlAddress = @"http://www.ya.ru";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [[webView mainFrame] loadRequest:requestObj];
*/
/*
	NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
	NSString *htmlPath = [resourcesPath stringByAppendingString:@"/htdocs/index.html"];
	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
*/
//	NSURL*url=[NSURL URLWithString:@"http://www.google.com"];
//	NSURLRequest*request=[NSURLRequest requestWithURL:url];
//	[[webView mainFrame] loadRequest:request];
//}


// End Webview

- (void)awakeFromNib {
	NSLog(@"Hello!");
//	webView.
	webView.wantsLayer = YES;
	CALayer *layer = webView.layer;
    layer.cornerRadius = 10.0;
    layer.masksToBounds = YES;
//    layer.borderColor = [NSColor blueColor].CGColor;
//    layer.borderWidth = 1.0;


	//Webview with Local URL
//	NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"" subdirectory:@"htdocs"]; //[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
//	[[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];


	//Webview with external URL
	webView.customUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gmail.com/"]];
	[[webView mainFrame] loadRequest:request];
	

	//Webview with loading contents using HTML String
	//NSString *HTMLData = @"<h1/>Hello World</h1>";
    //[[webView mainFrame] loadHTMLString:HTMLData baseURL:nil];


	//Webview with external URL
	//[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.gmail.com"]]];
	



}


- (void)drawRect:(NSRect)dirtyRect
{
    NSRect contentRect = NSInsetRect([self bounds], LINE_THICKNESS, LINE_THICKNESS);
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    [path moveToPoint:NSMakePoint(_arrowX, NSMaxY(contentRect))];
    [path lineToPoint:NSMakePoint(_arrowX + ARROW_WIDTH / 2, NSMaxY(contentRect) - ARROW_HEIGHT)];
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect) - CORNER_RADIUS, NSMaxY(contentRect) - ARROW_HEIGHT)];
    
    NSPoint topRightCorner = NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT);
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT - CORNER_RADIUS)
         controlPoint1:topRightCorner controlPoint2:topRightCorner];
    
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect) + CORNER_RADIUS)];
    
    NSPoint bottomRightCorner = NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect));
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect) - CORNER_RADIUS, NSMinY(contentRect))
         controlPoint1:bottomRightCorner controlPoint2:bottomRightCorner];
    
    [path lineToPoint:NSMakePoint(NSMinX(contentRect) + CORNER_RADIUS, NSMinY(contentRect))];
    
    [path curveToPoint:NSMakePoint(NSMinX(contentRect), NSMinY(contentRect) + CORNER_RADIUS)
         controlPoint1:contentRect.origin controlPoint2:contentRect.origin];
    
    [path lineToPoint:NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT - CORNER_RADIUS)];
    
    NSPoint topLeftCorner = NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect) - ARROW_HEIGHT);
    [path curveToPoint:NSMakePoint(NSMinX(contentRect) + CORNER_RADIUS, NSMaxY(contentRect) - ARROW_HEIGHT)
         controlPoint1:topLeftCorner controlPoint2:topLeftCorner];
    
    [path lineToPoint:NSMakePoint(_arrowX - ARROW_WIDTH / 2, NSMaxY(contentRect) - ARROW_HEIGHT)];
    [path closePath];
    
    [[NSColor colorWithDeviceWhite:1 alpha:FILL_OPACITY] setFill];
    [path fill];
    
    [NSGraphicsContext saveGraphicsState];

    NSBezierPath *clip = [NSBezierPath bezierPathWithRect:[self bounds]];
    [clip appendBezierPath:path];
    [clip addClip];
    
    [path setLineWidth:LINE_THICKNESS * 2];
    [[NSColor whiteColor] setStroke];
    [path stroke];
    
    [NSGraphicsContext restoreGraphicsState];

}

#pragma mark -
#pragma mark Public accessors

- (void)setArrowX:(NSInteger)value
{
    _arrowX = value;
    [self setNeedsDisplay:YES];
}

@end
