//
//  GetJsonURLString.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/13.
//
//

#ifndef miniGame_GetJsonURLString_h
#define miniGame_GetJsonURLString_h

/*
#define GetJsonURLString_Device @"http://54.244.225.229/shacookie/jsondevicelocation.php"
#define GetJsonURLString_Recipe @"http://54.244.225.229/shacookie/jsonrecipe.php"
#define GetJsonURLString_Vegetables @"http://54.244.225.229/shacookie/jsonVegetables.php"


#define SetJsonURLString_Device @"http://54.244.225.229/shacookie/updateLocation.php?deviceId=%@&latitude=%f&longtitude=%f"
*/

#define GetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/getDeviceLocation.php?deviceId=%@"

#define GetJsonURLString_Recipe @"http://54.244.225.229/shacookie/useThis/getRecipeInfo.php?type=%@"
#define GetJsonURLString_RecipeType @"http://54.244.225.229/shacookie/useThis/getRecipeTypeForSide.php"

#define GetJsonURLString_Vegetables @"http://54.244.225.229/shacookie/jsonVegetables.php"

#define SetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/setCurrentLocation.php?userId=%d&type=%d&deviceId=%@&latitude=%f&longtitude=%f"
#endif
