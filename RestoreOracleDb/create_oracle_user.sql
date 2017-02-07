
REM
REM Create the Bring Oracle Upgrade user
REM

connect &3 as sysdba

drop user "&1" cascade;

create user "&1" identified by "&2" default tablespace DLX_DATA_TS;

grant alter session,
      create session,
      execute any procedure,
      select_catalog_role,
      select any dictionary,
      create table,
      exp_full_database,
      imp_full_database to "&1"
/

grant select on v_$version to "&1"
/

grant select on v_$parameter to "&1"
/

grant select on sys.obj$ to "&1"
/

grant select on v_$lock to "&1"
/

grant select on v_$session to "&1"
/

grant select on v_$process to "&1"
/

grant select on dbms_lock_allocated to "&1"
/

grant select on dba_free_space_coalesced to "&1"
/

grant select on dba_data_files to "&1"
/

REM Provide unlimited Quotas on the application tablespaces

alter user "&1"
quota unlimited on DLX_DATA_TS
quota unlimited on GEN_D_01
quota unlimited on GEN_D_02
quota unlimited on GEN_X_01
quota unlimited on GEN_X_02
quota unlimited on SL_DEF_IFD
quota unlimited on SL_DATA_OTHER
quota unlimited on SL_DEF_OTHER_IND
quota unlimited on SL_DEF_IFD_IND
quota unlimited on SL_DATA_EVT
quota unlimited on SL_DEF_EO_IND
quota unlimited on SL_DATA_EVT_IND
quota unlimited on SL_DATA_IFD_IND
quota unlimited on SL_DEF_OTHER
quota unlimited on SL_DATA_IFD
quota unlimited on SL_DATA_OTHER_IND
quota unlimited on SL_DATA_EO
quota unlimited on SL_DATA_EO_IND
quota unlimited on SL_DEF_EO
quota unlimited on SL_DEF_EVT
quota unlimited on SL_DEF_EVT_IND
quota unlimited on TRACS3_DATA
quota unlimited on TRACS3_HIST
quota unlimited on TRACS3_LOCATIONS
quota unlimited on TRACS3_ORDERS
quota unlimited on TRACS3_TEMP
quota unlimited on TRACS3_HIST_INDEX
quota unlimited on TRACS3_INDEX
quota unlimited on TRACS3_LOCATION_INDEX
quota unlimited on TRACS3_ORDER_INDEX
quota unlimited on PRCL_D_01
quota unlimited on PRCL_X_01
quota unlimited on DDS_D_01
quota unlimited on DDS_D_02
quota unlimited on DDS_X_01
quota unlimited on DDS_X_02
quota unlimited on FP_D_01
quota unlimited on FP_D_02
quota unlimited on FP_D_03
quota unlimited on FP_X_01
quota unlimited on FP_X_02
quota unlimited on FP_X_03
quota unlimited on EMS_D_01
quota unlimited on EMS_X_01
quota unlimited on RPUX_DATA_TBS
quota unlimited on RPUX_INDEX_TBS
quota unlimited on USERS
quota unlimited on DCS_D_01
quota unlimited on DCS_D_02
quota unlimited on DCS_D_03
quota unlimited on DCS_D_04
quota unlimited on DCS_X_01
quota unlimited on TM_DATA_TBS_01
quota unlimited on TM_DATA_TBS_02
quota unlimited on TM_INDEX_TBS_01
quota unlimited on TM_INDEX_TBS_02
quota unlimited on PCLDHL_D_01
quota unlimited on PCLDHL_X_01
quota unlimited on PCLTNT_D_01
quota unlimited on PCLTNT_X_01
quota unlimited on USPS_D_01
quota unlimited on USPS_X_01
quota unlimited on PCLUPS_D_01
quota unlimited on PCLUPS_X_01
quota unlimited on PCLFDX_D_01
quota unlimited on PCLFDX_X_01
quota unlimited on PCLPUR_D_01
quota unlimited on PCLPUR_X_01
quota unlimited on PRCL_D_02
quota unlimited on PRCL_X_02
quota unlimited on PRCL_D_03
quota unlimited on PRCL_X_03
quota unlimited on PRCL_D_04
quota unlimited on PRCL_X_04
/

REM Creating plan_table for the user

connect &1/&2

@&4/rdbms/admin/utlxplan.sql

connect &3 as sysdba

grant read, write on directory exportdir to "&1"
/

exit
