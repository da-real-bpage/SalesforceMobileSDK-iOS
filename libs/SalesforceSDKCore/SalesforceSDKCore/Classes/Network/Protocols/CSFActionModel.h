/*
 Copyright (c) 2015-present, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>
#import "SalesforceSDKConstants.h"

/**
 This protocol represents objects that can be used as the model class for a CSFAction.

 When a network request is performed, if the [CSFAction modelClass] property is set to
 a class that conforms to this protocol, the action will attempt to construct a model
 with the result of the network request.
 */
SFSDK_DEPRECATED(5.2, 6.0, "Use our SFRestAPI library instead to make REST API requests.")
@protocol CSFActionModel <NSObject>

@optional

/** Designated initializer to construct a model object from its JSON representation.
 
 @param json    Dictionary of structured data from the network.
 @param context Dictionary of relevant information about the request and the action that performed it.
 @return Initialized model object.
 */
- (id)initWithJSON:(id)json context:(NSDictionary*)context;

@end
