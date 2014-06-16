
#import <SpriteKit/SpriteKit.h>

@interface SKNode (SKTExtras)

- (void)skt_performSelector:(SEL)selector onTarget:(id)target afterDelay:(NSTimeInterval)delay;

- (void)skt_bringToFront;

- (void)skt_attachDebugRectWithSize:(CGSize)s;
- (void)skt_attachDebugFrameFromPath:(CGPathRef)bodyPath;

@end
