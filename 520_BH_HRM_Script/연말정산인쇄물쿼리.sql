-- Create table
create table HRA_YEAR__CERTIFICATE
(
  PRINT_NUM         VARCHAR2(10) not null,
  CHECK_MONTH       VARCHAR2(7) not null,
  CHECK_SEQ         NUMBER not null,
  PERSON_NUMB       VARCHAR2(6),
  PRINT_YEAR        VARCHAR2(4) not null,
  PRINT_DATE        DATE not null,
  CERT_CODE         VARCHAR2(2) not null,
  PRINT_COUNT       NUMBER default 0 not null,
  DESCRIPTION       VARCHAR2(100) not null,
  SEND_CORP         VARCHAR2(50),
  CREATED_BY        NUMBER not null,
  CREATION_DATE     DATE not null,
  LAST_UPDATED_BY   NUMBER not null,
  LAST_UPDATE_DATE  DATE not null,
  LAST_UPDATE_LOGIN NUMBER not null
)
tablespace IFC_TS_DATA
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.PRINT_NUM
  is '�߱޹�ȣ';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.CHECK_MONTH
  is 'üũ���';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.CHECK_SEQ
  is 'üũ����-������ȣ';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.PRINT_YEAR
  is '¡���⵵';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.PRINT_DATE
  is '�߱�����';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.CERT_CODE
  is '�����ڵ�(HC92)';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.PRINT_COUNT
  is '�μ�Ƚ��';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.DESCRIPTION
  is '�뵵';
comment on column EIFC.IFC_HR_WITHHOLD_CERTIFICATE.SEND_CORP
  is '����ó';
-- Create/Recreate indexes 
create index EIFC.IFC_HR_WITHHOLD_CERTIFICATE_N1 on EIFC.IFC_HR_WITHHOLD_CERTIFICATE (CHECK_MONTH)
  tablespace IFC_TS_IDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index EIFC.IFC_HR_WITHHOLD_CERTIFICATE_N2 on EIFC.IFC_HR_WITHHOLD_CERTIFICATE (PERSON_NUMB)
  tablespace IFC_TS_IDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create unique index EIFC.IFC_HR_WITHHOLD_CERTIFICATE_U1 on EIFC.IFC_HR_WITHHOLD_CERTIFICATE (PRINT_NUM)
  tablespace IFC_TS_IDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
