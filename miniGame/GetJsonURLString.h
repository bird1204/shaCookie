//
//  GetJsonURLString.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/13.
//
//

#ifndef miniGame_GetJsonURLString_h
#define miniGame_GetJsonURLString_h

#define User_id @"3"


#define GetRecipesImage @"http://54.244.225.229/shacookie/image/%@"

#define GetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/getDeviceLocation.php?userId=%@"

#define GetJsonURLString_Recipe @"http://54.244.225.229/shacookie/useThis/getRecipeInfo.php?type=%@"
#define GetJsonURLString_RecipeType @"http://54.244.225.229/shacookie/useThis/getRecipeTypeForSide.php"
#define GetJsonURLString_RecipeStep @"http://54.244.225.229/shacookie/useThis/getRecipeProcedure.php?recipeId=%@"
#define GetJsonURLString_RecipeByNames @"http://54.244.225.229/shacookie/useThis/getMaterialforRecipestest.php?name=%@"

#define GetJsonURLString_MaterialforUserid @"http://54.244.225.229/shacookie/useThis/getUserMaterial.php?userId=%@"
#define GetJsonURLString_Content @"http://54.244.225.229/shacookie/useThis/getRecipeContent.php?Id=%@"

#define GetJsonURLString_Material @"http://54.244.225.229/shacookie/useThis/getMaterial.php?category=%@"
#define GetJsonURLString_MaterialType @"http://54.244.225.229/shacookie/useThis/getMaterialTypeForSide.php"
#define GetJsonURLString_MaterialName @"http://54.244.225.229/shacookie/useThis/getMaterialName.php"

#define GetImageUrl_material @"http://54.244.225.229/shacookie/image/material/%@"

#define SetJsonURLString_Share @"http://54.244.225.229/shacookie/useThis/inputShare.php?rank=%.f&content=%@&recipeId=%@&Userid=%@"
#define SetJsonURLString_Like @"http://54.244.225.229/shacookie/useThis/inputLike.php?recipeId=%@&userId=%@"
#define SetJsonURLString_Device @"http://54.244.225.229/shacookie/useThis/setCurrentLocation.php?userId=%@&type=%d&deviceId=%@&latitude=%f&longtitude=%f"
#define SetJsonURLString_UserInventory @"http://54.244.225.229/shacookie/useThis/setUserInventory.php?userId=%@&type=%@&category=%@&name=%@&quantity=%@"
#define SetJsonURLString_recipe @"http://54.244.225.229/shacookie/useThis/inputRecipe.php?User_id=%@&type=%@&RecipeName=%@&steps=%@&MaterialName=%@"
//#define SetJsonURLString_recipe @"http://54.244.225.229/shacookie/useThis/inputRecipe.php?RecipeName=%@&User_id=%@"

#endif
