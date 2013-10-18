//
//  GetJsonURLString.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/13.
//
//

#ifndef miniGame_GetJsonURLString_h
#define miniGame_GetJsonURLString_h


#define GetRecipesImage @"http://54.244.225.229/shacookie/image/%@"

#define GetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/getDeviceLocation.php?deviceId=%@"

#define GetJsonURLString_Recipe @"http://54.244.225.229/shacookie/useThis/getRecipeInfo.php?type=%@"
#define GetJsonURLString_RecipeType @"http://54.244.225.229/shacookie/useThis/getRecipeTypeForSide.php"
#define GetJsonURLString_RecipeStep @"http://54.244.225.229/shacookie/useThis/getRecipeProcedure.php?recipeId=%@"
#define GetJsonURLString_RecipeByNames @"http://54.244.225.229/shacookie/useThis/getMaterialforRecipes.php?eng_name=%@"


#define GetJsonURLString_Content @"http://54.244.225.229/shacookie/useThis/getRecipeContent.php?Id=3"

#define GetJsonURLString_Material @"http://54.244.225.229/shacookie/useThis/getMaterial.php?category=%@"
#define GetJsonURLString_MaterialType @"http://54.244.225.229/shacookie/useThis/getMaterialTypeForSide.php"


#define SetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/setCurrentLocation.php?userId=%d&type=%d&deviceId=%@&latitude=%f&longtitude=%f"
#endif
