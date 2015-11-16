select MENU_NAME,
       USER_MENU_NAME,
       v.PROMPT,
       v.SUB_MENU_id,
       ( select user_menu_name from FND_MENUS_VL where menu_id=v.SUB_MENU_ID),
       v.FUNCTION_id,
       X.USER_FUNCTION_NAME,
       X.DESCRIPTION
  from FND_MENUS_VL T,
       FND_MENU_ENTRIES_VL V,
       FND_FORM_FUNCTIONS_VL X
 where t.MENU_ID = v.MENU_ID(+)
   and v.FUNCTION_ID = x.FUNCTION_ID(+)
   and USER_MENU_NAME = 'GJ.生管岗基本菜单' --menu_id
