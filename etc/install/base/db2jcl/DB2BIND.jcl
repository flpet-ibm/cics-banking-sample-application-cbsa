//*
//* Copyright IBM Corp. 2023       
//*
//DB2BIND JOB 'DB2',NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,
//          MSGLEVEL=(1,1),REGION=4M   
//*
//*
//* Please change @DB2_HLQ@  to DSNC10.DBCG
//*  (to the high level qualifiers of your
//* system's DB2 datasets (SDSNLOAD et cetera)
//*
//* Please change @BANK_DBRMLIB@ to CBSA.CICSBSA.DBRM
//* (to the name you chose
//* for the DBRMLIB provided by Hursley Bank)
//*
//* Please change @DB2_SUBSYSTEM@ to DBCG
//* (to the name of your chosen DB2
//* subsystem (which must be running on the same MVS image as this
//* batch job)
//*
//* Please change @BANK_PACKAGE@ to PCBSA
//* to the name you have chosen for the
//* package name in DB2, for example PHBANK.
//*
//* Please change @DB2_OWNER@ to IBMUSER
//* to the userid that will own the DB2
//* resources
//*
//* Please change @BANK_PLAN@ to CBSA
//*  to the desired DB2 plan name
//*
//* Please change @DB2_DSNTEP_PLAN@ to DSNTEP12
//* to the name of the plan that was
//* used for the DSNTEP2 utility program
//*
//* Please change @DB2_DSNTEP_LOADLIB@ to
//* to the name of the load library
//* that contains the DSNTEP2 utility program
//*
//* Please change @BANK_USER@ to IBMUSER
//* to the userid that will be accessing the
//* plan
//BIND    EXEC PGM=IKJEFT01
//STEPLIB  DD  DISP=SHR,DSN=DSNC10.DBCG.SDSNEXIT
//         DD  DISP=SHR,DSN=DSNC10.SDSNLOAD
//DBRMLIB  DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(CREACC)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(CRECUST)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(DBCRFUN)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(DELACC)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(DELCUS)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(INQACC)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(INQACCCU)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(BANKDATA)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(UPDACC)
//     DD DISP=SHR,DSN=CBSA.CICSBSA.DBRM(XFRFUN)
//SYSPRINT DD  SYSOUT=*
//SYSTSPRT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSTSIN DD *
 DSN S(DBCG)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(CREACC) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(CRECUST) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(DBCRFUN) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(DELACC) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(DELCUS) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(INQACC) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(INQACCCU) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(BANKDATA) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(UPDACC) -
 ACTION(REPLACE)

 BIND PACKAGE(PCBSA) OWNER(IBMUSER) -
 QUALIFIER(IBMUSER) -
 MEMBER(XFRFUN) -
 ACTION(REPLACE)

  BIND PLAN(CBSA) -
   OWNER(IBMUSER) -
   ISOLATION(UR) -
   PKLIST( -
   NULLID.*,PCBSA.* )
 END
//********************************************************************
//***    GRANT EXECUTE AUTHORITY ON PLAN CBSA
//********************************************************************
//GRANT EXEC PGM=IKJEFT01,REGION=0M
//STEPLIB  DD  DISP=SHR,DSN=DSNC10.DBCG.SDSNEXIT
//         DD  DISP=SHR,DSN=DSNC10.SDSNLOAD
//SYSUDUMP DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
DSN SYSTEM(DBCG)
RUN PROGRAM(DSNTEP2) PLAN(DSNTEP12) -
LIB('DSNC10.DBCG.RUNLIB.LOAD')
//SYSIN DD *
 SET CURRENT SQLID = 'IBMUSER';
 GRANT EXECUTE ON PLAN CBSA TO CICSUSER;
 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
     IBMUSER.ACCOUNT TO CICSUSER;
 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
     IBMUSER.PROCTRAN TO CICSUSER;
 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
     IBMUSER.CONTROL TO CICSUSER;
/*