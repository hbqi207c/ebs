create or replace package cux_inv_security_excel_rep is
  --杂项事务处理安全性
  --2015-08-18
  procedure main(
                 errbuf       out varchar2
                 ,retcode     out number
                 ,l_org_id    number
                 ,l_dept_name varchar2 --部门名称
                 ,l_user_name varchar2 --人员编号
                 );
end cux_inv_security_excel_rep;

create or replace package body cux_inv_security_excel_rep  is
 --杂项事务处理安全性
 --2015-08-18

     procedure output (p_text  in varchar2)
      is
      begin
        fnd_file.put_line(fnd_file.output, p_text);
      end;

    procedure main
    (
    errbuf                             out varchar2
    ,retcode                            out number
    ,l_org_id                           number
    ,l_dept_name                        varchar2 --部门名称
    ,l_user_name                        varchar2 --人员编号
    ) is

    --头游标
    p_user_id                 number:=fnd_global.USER_ID;

    CURSOR   c_header IS
         select
         ho.name                       ho_name,--库存组织,
         fu.user_name                   fu_user_name,--用户名,
         fu.description                 fu_descroption,--用户描述,
         hp.party_name                  hp_party_name,--员工名称,
         pav.D_ORGANIZATION_ID          pav_d_organization_id,--部门,
         h.transaction_type_name        h_transaction_type_name,--事务处理类型,
         h.description                  h_description,--事务处理类型说明,
         h.transaction_source_type_name h_transaction_source_type_name,--来源类型,
         l.segment1,
         l.description
      from apps.cux_inv_txn_type_users_all a,
         apps.fnd_user                   fu,
         apps.hz_parties                 hp,
         apps.cux_inv_txn_type_headers_v h,
         apps.cux_inv_txn_type_lines_v   l,
         apps.PER_PEOPLE_V7              ppv,
         apps.PER_ASSIGNMENTS_V7         pav,
         apps.HR_ORGANIZATION_UNITS_V    ho
     where a.user_id = fu.user_id
       and fu.person_party_id = hp.party_id
       and h.type_user_id = a.type_user_id
       and h.header_id = l.header_id
       and pav.person_id = ppv.person_id
       and fu.employee_id = ppv.person_id
       and a.organization_id = ho.organization_id
       and fu.end_date is null
       and a.VALID_FLAG = 'Y'
       and (h.invalid_date is null or
         to_char(h.invalid_date, 'yyyymmdd') > to_char(sysdate , 'yyyymmdd'))
       and (l.invalid_date is null or
         to_char(l.invalid_date, 'yyyymmdd') > to_char(sysdate , 'yyyymmdd'))
       --and a.organization_id in (145,146,661)
       and a.organization_id = cux_lt_common_utl.get_organization_id(l_org_id)
       and (l_dept_name is null or pav.D_ORGANIZATION_ID=l_dept_name)
       and (l_user_name is null or fu.user_name=l_user_name)
       order by ho.name,fu.user_name;
       
     l_org_name                          varchar2(100);
     /*
     l_sysdate                           varchar2(100);
     l_item_no                           varchar2(100);
     l_item_desc                         varchar2(200);
     l_sum_qty                           number;
     l_make_person                       varchar2(100);
     L_QTY_Failure_ret                       number;
     L_QTY_success_ret                       number;
     l_del_pass_rate                         number;
     l_sum_amount                            number;
     l_req_name                         varchar2(100);
     l_req_dept                         varchar2(100);
     l_name                              varchar2(100);
     l_dept                              varchar2(100);
     */
    begin

          --公司OU
          
           BEGIN
              select t.attribute20 into l_org_name
              from hr_organization_units t
              where t.organization_id = l_org_id;
              exception when others then
                l_org_name:='';
                fnd_file.PUT_LINE(fnd_file.LOG,SQLERRM||'获取公司名称异常~');
           END;
                
           output('<html><title>杂项事务处理安全性</title>
                  <style type="text/css">
                  <!-- $header: porstyl2.css 115.9 2002/10/24 04:30:42 dkfchan ship ${  }
                  <!--
                  .xl27 {font-family: Arial, Helvetica, Geneva, sans-serif;
                        font-size: 9pt;
                        font-weight: bold;
                        background: #cccc99;
                        color: #336699;
                        text-align: left;}
                  .xl28  {font-family: Arial, Helvetica, Geneva, sans-serif;
                         font-size: 9pt;}
                  -->
                  </style>
                  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
                  <table width="1000">
                    <tr>
                      <td align="center" colspan="10"><font size="3" color = "#336699"><strong>杂项事务处理安全性</strong></font></td>
                    </tr>
                    <tr>
                      <td align="left" colspan="10"> <font size="2" color = "#336699">业务实体: ' || l_org_name || '</font></td>
                    </tr>
                    <tr>
                      <td align="left" colspan="10"> <font size="2" color = "#336699">列印时间：'|| to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') ||'</font></td>
                    </tr>
                  </table>
                  <table width="2000" border="1">
                  <tr>
                    <td class=xl27 width=100  align="left">库存组织</td>
                    <td class=xl27 width=100  align="left">用户名</td>
                    <td class=xl27 width=100  align="left">用户描述</td>
                    <td class=xl27 width=60 align="left">员工名称</td>
                    <td class=xl27 width=60 align="left">部门名称</td>
                    <td class=xl27 width=100  align="left">事务处理类型</td>
                    <td class=xl27 width=60  align="left">事务处理类型说明</td>
                    <td class=xl27 width=300 align="left">账户别名</td>
                    <td class=xl27 width=40 align="left">账户别名说明</td>

                  </tr>');

  FOR c1 IN c_header

            LOOP
               /*
               BEGIN
                 
                 select a.last_name||a.first_name ,
                        d.name
                INTO  l_name,
                      l_dept
                from per_people_v7 a
                ,fnd_user b
                ,per_all_assignments_f c
                ,hr_all_organization_units d
                where a.person_id = b.employee_id
                and a.person_id = c.person_id
                and c.organization_id = d.organization_id
                and b.user_id = c1.created_by;
                EXCEPTION WHEN OTHERS then
                  dbms_output.put_line(SQLERRM||c1.created_by);
                 END;
                 
                IF c1.receipt_num = '16014' THEN
                  dbms_output.put_line(c1.created_by);
                  END IF;
                  */
                  output('<tr>
                          <td class=xl28 width=60 align="left">'|| c1.ho_name ||'</td>
                           <td class=xl28 width=60 align="left">'|| c1.fu_user_name ||'</td>
                          <td class=xl28 width=100  align="left">'|| c1.fu_descroption ||'</td>
                          <td class=xl28 width=60 align="left">'|| c1.hp_party_name ||'</td>
                          <td class=xl28 width=60 align="left">'|| c1.pav_d_organization_id ||'</td>
                          <td class=xl28 width=100  align="left">'|| c1.h_transaction_type_name ||'</td>
                          <td class=xl28 width=60  align="left">'|| c1.h_description ||'</td>
                          <td class=xl28 width=300 align="left">'|| c1.segment1 ||'</td>
                          <td class=xl28 width=40 align="left">'|| c1.description ||'</td>

                        </tr>');

                       -- l_name:='';
                       -- l_dept:='';
    end loop;
    output('</table>
<td align="left"> <font size=2pt color = "#336699">***End of Report***</font> </td>
</html>');
     end;
end cux_inv_security_excel_rep;
