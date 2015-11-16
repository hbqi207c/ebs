SELECT T.FULL_NAME,
       T.EMPLOYEE_NUMBER,
       S.D_ORGANIZATION_ID,
       S.D_JOB_ID,
       S.SUPERVISOR_ID,
       S.D_SUPERVISOR_ID
  FROM PER_PEOPLE_V7 T, PER_ASSIGNMENTS_V7 S
 WHERE T.EMPLOYEE_NUMBER = S.assignment_number(+)
   AND S.D_SUPERVISOR_ID IS NOT NULL
   AND S.SUPERVISOR_ID NOT IN
       ( SELECT employee_id from fnd_user WHERE END_DATE IS NULL )

/*
字段说明：
人员表PER_PEOPLE_V7
     person_id（人员ID）
分配表PER_ASSIGNMENTS_V7
     person_id（人员ID）  SUPERVISOR_ID（主管ID）
用户表fnd_user
     employee_id（人员ID）
*/
