--抓所有有效用户职责
SELECT DISTINCT USERS.USER_ID,
                USERS.USER_NAME,
               
                USERS.DESCRIPTION,
                USERS.START_DATE            USER_START_DATE,
                USERS.END_DATE              USER_END_DATE,
                USERS.EMAIL_ADDRESS,
                RESP.RESPONSIBILITY_NAME,
                USER_RESP.START_DATE,
                USER_RESP.END_DATE,
                USER_RESP.LAST_UPDATE_DATE,
                APPL.APPLICATION_SHORT_NAME,
                APPL.APPLICATION_NAME
  FROM APPS.FND_USER                    USERS,
       APPS.FND_USER_RESP_GROUPS_DIRECT USER_RESP,
       APPS.FND_RESPONSIBILITY_VL       RESP,
       APPS.FND_APPLICATION_VL          APPL
 WHERE USERS.USER_ID = USER_RESP.USER_ID
   AND USER_RESP.RESPONSIBILITY_APPLICATION_ID = RESP.APPLICATION_ID
   AND USER_RESP.RESPONSIBILITY_ID = RESP.RESPONSIBILITY_ID
   AND RESP.APPLICATION_ID = APPL.APPLICATION_ID
   and USERS.END_DATE is null
   and user_name in (select emp_no
                       from v_emp_mast@dbl_gemerp
                      where dept_no in ('FD', 'FD1', 'FD2' ))
