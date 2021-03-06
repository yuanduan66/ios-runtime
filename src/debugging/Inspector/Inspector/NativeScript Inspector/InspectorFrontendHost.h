#import <Foundation/Foundation.h>
#import "InspectorFrontendHostProtocol.h"
#import "Communication.h"
@import AppKit;

@interface InspectorFrontendHost : NSObject <InspectorFrontendHostProtocol> {
    TNSCommunicationChannel* communication_channel;
}

- (NSString*)platform;
- (NSString*)localizedStringsURL;
- (NSString*)debuggableType;
- (NSString*)backendCommandsURL;
- (NSString*)zoomFactor;
- (unsigned)inspectionLevel;
- (void)connect:(NSString*)socketPath readHandler:(InspectorReadHandler)read_handler errorHandler:(InspectorErrorHandler)errorHandler;
- (void)disconnect;
- (void)loaded;
- (void)bringToFront;
- (void)sendMessageToBackend:(NSString*)message;
- (void)inspectedURLChanged;
- (void)startWindowDrag;
- (void)setZoomFactor:(NSString*)factor;
- (void)showContextMenu;
@end
