//
//  SPErrorCodes.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#ifndef ShopeliaSDK_ErrorCodes_h
#define ShopeliaSDK_ErrorCodes_h

typedef enum NSInteger
{
    SPErrorNone = 0,
    SPErrorNoAPIKeyInApplicationBundle,
    SPErrorProductNotAvailableForPurchase,
    SPErrorAlreadyInCheckout,
    SPErrorInvalidOrder,
    SPErrorInvalidProductURL,
    SPErrorNoResourcesBundle
} SPErrorCode;

#endif
