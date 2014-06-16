
#import "SKNode+SKTExtras.h"

@implementation SKNode (SKTExtras)

- (void)skt_performSelector:(SEL)selector onTarget:(id)target afterDelay:(NSTimeInterval)delay
{
	[self runAction:
		[SKAction sequence:@[
			[SKAction waitForDuration:delay],
			[SKAction performSelector:selector onTarget:target],
			]]];
}

- (void)skt_bringToFront
{
	SKNode *parent = self.parent;
	[self removeFromParent];
	[parent addChild:self];
}

- (void)skt_attachDebugRectWithSize:(CGSize)s
{
    CGPathRef bodyPath = CGPathCreateWithRect( CGRectMake(-s.width/2, -s.height/2, s.width, s.height),nil);
    [self skt_attachDebugFrameFromPath:bodyPath];
    CGPathRelease(bodyPath);
}

- (void)skt_attachDebugFrameFromPath:(CGPathRef)bodyPath
{
    SKShapeNode *shape = [SKShapeNode node];
    shape.path = bodyPath;
    shape.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                        alpha:0.5];
    shape.lineWidth = 1.0;
    
    [self addChild:shape];
}

@end
