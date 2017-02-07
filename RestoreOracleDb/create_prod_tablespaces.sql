REM Create tablespaces for shared application library tables and indexes

connect sys/RedPrairie1 as sysdba

alter system set processes = 500 scope=spfile;
alter system set open_cursors = 1200;
alter profile default limit password_life_time unlimited;

create tablespace gen_d_01
   datafile
      '&1\orcl_gend01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/


create tablespace gen_d_02
   datafile
      '&1\orcl_gend02_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace gen_x_01
   datafile
      '&1\orcl_genx01_01.dbf' size 10m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace gen_x_02
   datafile
      '&1\orcl_genx02_01.dbf' size 10m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_DATA
   datafile
      '&1\orcl_TRACS3_DATA_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_HIST
   datafile
      '&1\orcl_TRACS3_HIST_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_LOCATIONS
   datafile
      '&1\orcl_TRACS3_LOCATIONS2_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_ORDERS
   datafile
      '&1\orcl_TRACS3_ORDERS_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_TEMP
   datafile
      '&1\orcl_TRACS3_TEMP_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_HIST_INDEX
   datafile
      '&1\orcl_TRACS3_HIST_INDEX_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_INDEX
   datafile
      '&1\orcl_TRACS3_INDEX_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_LOCATION_INDEX
   datafile
      '&1\orcl_TRACS3_LOCATION_INDEX_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace TRACS3_ORDER_INDEX
   datafile
      '&1\orcl_TRACS3_ORDER_INDEX_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_D_01
   datafile
      '&1\orcl_PRCL_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_X_01
   datafile
      '&1\orcl_PRCL_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace DDS_D_01
   datafile
      '&1\orcl_DDS_D_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace DDS_D_02
   datafile
      '&1\orcl_DDS_D_02.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace DDS_X_01
   datafile
      '&1\orcl_DDS_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace DDS_X_02
   datafile
      '&1\orcl_DDS_X_02.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_D_01
   datafile
      '&1\orcl_FP_D_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_D_02
   datafile
      '&1\orcl_FP_D_02.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_D_03
   datafile
      '&1\orcl_FP_D_03.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_X_01
   datafile
      '&1\orcl_FP_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_X_02
   datafile
      '&1\orcl_FP_X_02.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace FP_X_03
   datafile
      '&1\orcl_FP_X_03.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

REM Seamles

CREATE TABLESPACE SL_DATA_OTHER DATAFILE
'&1\orcl_sl_data_other_01.dbf' size 15m
   autoextend on next 15M maxsize UNLIMITED
      extent management local uniform size  1M 
      segment space management auto
/

CREATE TABLESPACE SL_DATA_OTHER_IND DATAFILE
'&1\orcl_sl_data_other_ind_01.dbf' size 5m
   autoextend on next 5M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DATA_EO DATAFILE
'&1\orcl_sl_data_eo_01.dbf' size 150m
   autoextend on next 150M maxsize UNLIMITED
      extent management local uniform size  20M 
      segment space management auto
/

  
CREATE TABLESPACE SL_DATA_EO_IND DATAFILE
'&1\orcl_sl_data_eo_ind_01.dbf' size 70m
   autoextend on next 70M maxsize UNLIMITED
      extent management local uniform size  10M 
      segment space management auto
/

CREATE TABLESPACE SL_DATA_EVT DATAFILE
'&1\orcl_sl_data_evt_01.dbf' size 200m
   autoextend on next 200M maxsize UNLIMITED
      extent management local uniform size  20M 
      segment space management auto
/

  
CREATE TABLESPACE SL_DATA_EVT_IND DATAFILE
'&1\orcl_sl_data_evt_ind_01.dbf' size 150m
   autoextend on next 150M maxsize UNLIMITED
      extent management local uniform size  10M 
      segment space management auto
/

  
CREATE TABLESPACE SL_DATA_IFD DATAFILE
'&1\orcl_sl_data_ifd_01.dbf' size 300m
   autoextend on next 100M maxsize UNLIMITED
      extent management local uniform size  60M
      segment space management auto
/

  
CREATE TABLESPACE SL_DATA_IFD_IND DATAFILE
'&1\orcl_sl_data_ifd_ind_01.dbf' size 100m
   autoextend on next 100M maxsize UNLIMITED
      extent management local uniform size  10M 
      segment space management auto
/


CREATE TABLESPACE SL_DEF_EO DATAFILE
'&1\orcl_sl_def_eo_01.dbf' size 5m
   autoextend on next 5M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_EO_IND DATAFILE
'&1\orcl_sl_def_eo_ind_01.dbf' size 5m
   autoextend on next 5M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_EVT DATAFILE
'&1\orcl_sl_def_evt_01.dbf' size 5m
   autoextend on next 5M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_EVT_IND DATAFILE
'&1\orcl_sl_def_evt_ind_01.dbf' size 5m
   autoextend on next 5M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_IFD DATAFILE
'&1\orcl_sl_def_ifd_01.dbf' size 10m
   autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_IFD_IND DATAFILE
'&1\orcl_sl_def_ifd_ind_01.dbf' size 10m
   autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

  
CREATE TABLESPACE SL_DEF_OTHER_IND DATAFILE
'&1\orcl_sl_def_other_ind_01.dbf' size 20m
   autoextend on next 20M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

CREATE TABLESPACE SL_DEF_OTHER DATAFILE
'&1\orcl_sl_def_other_01.dbf' size 20m
   autoextend on next 20M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace EMS_D_01
   datafile
      '&1\orcl_emsd01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace EMS_X_01
   datafile
      '&1\orcl_emsx01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DLX_DATA_TS
   datafile
      '&1\orcl_dlx_data_ts_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace RPUX_DATA_TBS
   datafile
      '&1\orcl_rpux_data_tbs_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace RPUX_INDEX_TBS
   datafile
      '&1\orcl_rpux_index_tbs_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

REM Used by BRING

create tablespace DCS_D_01
   datafile
      '&1\orcl_dcs_d_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_D_02
   datafile
      '&1\orcl_dcs_d_02.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_D_03
   datafile
      '&1\orcl_dcs_d_03.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_D_04
   datafile
      '&1\orcl_dcs_d_04.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_X_01
   datafile
      '&1\orcl_dcs_x_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_X_02
   datafile
      '&1\orcl_dcs_x_02.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_X_03
   datafile
      '&1\orcl_dcs_x_03.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace DCS_X_04
   datafile
      '&1\orcl_dcs_x_04.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

REM TMCARRIER

create tablespace TM_DATA_TBS_01
   datafile
      '&1\orcl_tm_data_tbs_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace TM_DATA_TBS_02
   datafile
      '&1\orcl_tm_data_tbs_02.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace TM_INDEX_TBS_01
   datafile
      '&1\orcl_tm_index_tbs_01.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

create tablespace TM_INDEX_TBS_02
   datafile
      '&1\orcl_tm_index_tbs_02.dbf' size 50m
   autoextend on next 10M maxsize UNLIMITED
   extent management local uniform size 128K
   segment space management auto
/

REM PARCEL

create tablespace PCLDHL_D_01
   datafile
      '&1\orcl_PCLDHL_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLDHL_X_01
   datafile
      '&1\orcl_PCLDHL_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLTNT_D_01
   datafile
      '&1\orcl_PCLTNT_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLTNT_X_01
   datafile
      '&1\orcl_PCLTNT_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace USPS_D_01
   datafile
      '&1\orcl_USPS_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace USPS_X_01
   datafile
      '&1\orcl_USPS_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLUPS_D_01
   datafile
      '&1\orcl_UPCLUPS_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLUPS_X_01
   datafile
      '&1\orcl_PCLUPS_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLFDX_D_01
   datafile
      '&1\orcl_PCLFDX_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLFDX_X_01
   datafile
      '&1\orcl_PCLFDX_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLPUR_D_01
   datafile
      '&1\orcl_PCLPUR_D_01_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PCLPUR_X_01
   datafile
      '&1\orcl_PCLPUR_X_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/



create tablespace PRCL_D_02
   datafile
      '&1\orcl_PRCL_D_02_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_X_02
   datafile
      '&1\orcl_PRCL_X_02.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_D_03
   datafile
      '&1\orcl_PRCL_D_03_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_X_03
   datafile
      '&1\orcl_PRCL_X_03.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_D_04
   datafile
      '&1\orcl_PRCL_D_04_01.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/

create tablespace PRCL_X_04
   datafile
      '&1\orcl_PRCL_X_04.dbf' size 20m
      autoextend on next 10M maxsize UNLIMITED
      extent management local uniform size  128k 
      segment space management auto
/



exit
