USE [SIPIDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACCOUNT_STATEMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<REFAT>
-- Create date: <19/12/2011>
-- Description:	<THIS PROCEDURE WILL GENERATE GENERAL LEDGER RECORD FROM "JOURNAL_DETAILS" TABLE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ACCOUNT_STATEMENT]
@accountId BIGINT,
@fromDate DATE,
@toDate DATE
AS
BEGIN
	IF EXISTS(SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @fromDate AND @toDate) AND (JV_ACCOUNT_ID = @accountId))
		BEGIN
			SELECT	CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
			,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
			,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
			,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
			,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
			,JOURNAL_VOUCHAR.ID
			,JV_ID
			,JV_ACCOUNT_ID
			,JV_ACCOUNT_CODE
			,JV_ACCOUNT_NAME
			,JV_DEBIT_AMOUNT
			,JV_CREDIT_AMOUNT
			,JV_DATE
			,JV_NOTES
			,JV_CHEQUE_NO
			,JV_CHEQUE_DATE
			,JV_BANK_REMARK FROM JOURNAL_VOUCHAR join CHART_ACCOUNT on JOURNAL_VOUCHAR.JV_ACCOUNT_ID = CHART_ACCOUNT.CHART_ACC_ID
					WHERE JV_ID in (SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @fromDate AND @toDate) AND (JV_ACCOUNT_ID = @accountId))
					ORDER BY JV_ID 
		END

	--ELSE
	--	BEGIN
	--		SELECT CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
	--		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
	--		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
	--		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
	--		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
	--		FROM CHART_ACCOUNT WHERE CHART_ACCOUNT.CHART_ACC_NAME = @accountTitle
	--	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_BANK_STATEMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<REFAT>
-- Create date: <09/02/2012>
-- Description:	<THIS PROCEDURE WILL GENERATE Bank STATEMENT RECORD FROM "JOURNAL_DETAILS" TABLE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_BANK_STATEMENT]
@accountId BIGINT,
@fromDate DATE,
@toDate DATE
AS
BEGIN
	IF EXISTS(SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @fromDate AND @toDate) AND (JV_ACCOUNT_ID = @accountId))
		BEGIN
			SELECT	CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
			,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
			,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
			,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
			,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
			,JOURNAL_VOUCHAR.ID
			,JV_ID
			,JV_ACCOUNT_ID
			,JV_ACCOUNT_CODE
			,JV_ACCOUNT_NAME
			,JV_DEBIT_AMOUNT
			,JV_CREDIT_AMOUNT
			,JV_DATE
			,JV_NOTES
			,JV_CHEQUE_NO
			,JV_CHEQUE_DATE
			,JV_BANK_REMARK FROM JOURNAL_VOUCHAR join CHART_ACCOUNT on JOURNAL_VOUCHAR.JV_ACCOUNT_ID = CHART_ACCOUNT.CHART_ACC_ID
					WHERE JV_ID in (SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @fromDate AND @toDate) AND (JV_ACCOUNT_ID = @accountId))
					ORDER BY JV_DATE
		END

	--ELSE
	--	BEGIN
	--		SELECT CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
	--		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
	--		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
	--		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
	--		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
	--		FROM CHART_ACCOUNT WHERE CHART_ACCOUNT.CHART_ACC_NAME = @accountTitle
	--	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CHART_OF_ACCOUNT_UPDATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHART_OF_ACCOUNT_UPDATE]
 
 @CHART_ACC_ID BIGINT,
 @CHART_ACC_STATUS VARCHAR(10)
 
 AS  
   BEGIN
       SET NOCOUNT ON;
       
       UPDATE CHART_ACCOUNT SET
       [CHART_ACC_STATUS] = @CHART_ACC_STATUS
       WHERE [CHART_ACC_ID] =@CHART_ACC_ID;
       
       UPDATE CHART_ACCOUNT SET
       [CHART_ACC_STATUS] = @CHART_ACC_STATUS
       WHERE [CHART_ACC_PARENT_ID] =@CHART_ACC_ID;
        
   END

GO
/****** Object:  StoredProcedure [dbo].[SP_CURRENT_BALANCE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <13/12/2011>
-- Description:	<THIS PROCEDURE WILL GENERATE GENERAL LEDGER RECORD FROM "JOURNAL_DETAILS" TABLE>
--Modify:REFAT(18-12-2011)
-- =============================================
CREATE PROCEDURE [dbo].[SP_CURRENT_BALANCE]
@pJV_ACCOUNT_ID BIGINT,
@pDateTo DATE
AS
BEGIN
If exists(
SELECT	 CHART_ACCOUNT.CHART_ACC_NAME
		,CHART_ACCOUNT.CHART_ACC_ID
		,CHART_ACCOUNT.CHART_ACC_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
		,JV_ID
		,JV_ACCOUNT_NAME
		,JV_DEBIT_AMOUNT
		,JV_CREDIT_AMOUNT
		,JV_DATE
		,JV_NOTES
  FROM JOURNAL_VOUCHAR,CHART_ACCOUNT 
		
		
WHERE (JV_DATE <= @pDateTo) 
		AND CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID
		AND JV_ACCOUNT_ID = @pJV_ACCOUNT_ID)
SELECT	 CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
		,JV_ID
		,JV_ACCOUNT_NAME
		,JV_DEBIT_AMOUNT
		,JV_CREDIT_AMOUNT
		,JV_DATE
		,JV_NOTES
  FROM JOURNAL_VOUCHAR,CHART_ACCOUNT 
		
		
WHERE (JV_DATE <= @pDateTo) 
		AND CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID 
		and JV_ACCOUNT_ID = @pJV_ACCOUNT_ID ORDER BY JV_ACCOUNT_NAME
ELSE
select 
		 CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
from CHART_ACCOUNT where CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CURRENT_BALANCE_REVENUE_EXPENSE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<REFAT
-- Create date: <08/05/2012>
-- Description:	<THIS PROCEDURE WILL GENERATE GENERAL LEDGER RECORD FROM "JOURNAL_DETAILS" TABLE>
--Modify:REFAT(18-12-2011)
-- =============================================
CREATE PROCEDURE [dbo].[SP_CURRENT_BALANCE_REVENUE_EXPENSE]
@pJV_ACCOUNT_ID BIGINT,
@pDateFrom DATE,
@pDateTo DATE

AS
BEGIN
If exists(
SELECT	 CHART_ACCOUNT.CHART_ACC_NAME
		,CHART_ACCOUNT.CHART_ACC_ID
		,CHART_ACCOUNT.CHART_ACC_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
		,JV_ID
		,JV_ACCOUNT_NAME
		,JV_DEBIT_AMOUNT
		,JV_CREDIT_AMOUNT
		,JV_DATE
		,JV_NOTES
  FROM JOURNAL_VOUCHAR,CHART_ACCOUNT 
		
		
WHERE (JV_DATE>=@pDateFrom AND JV_DATE < @pDateTo) 
		AND CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID
		AND JV_ACCOUNT_ID = @pJV_ACCOUNT_ID)
SELECT	 CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
		,JV_ID
		,JV_ACCOUNT_NAME
		,JV_DEBIT_AMOUNT
		,JV_CREDIT_AMOUNT
		,JV_DATE
		,JV_NOTES
  FROM JOURNAL_VOUCHAR,CHART_ACCOUNT 
		
		
WHERE (JV_DATE>=@pDateFrom AND JV_DATE < @pDateTo) 
		AND CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID 
		and JV_ACCOUNT_ID = @pJV_ACCOUNT_ID ORDER BY JV_ACCOUNT_NAME
ELSE
select 
		 CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
from CHART_ACCOUNT where CHART_ACCOUNT.CHART_ACC_ID = @pJV_ACCOUNT_ID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CURRENT_DEBIT_CREDIT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Refat>
-- Create date: <11 January, 2012>
-- Description:	<to know about current credit and debit amount of a particular account>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CURRENT_DEBIT_CREDIT]
@ACC_ID BIGINT,
@FISCALYEAR DATE,
@pJD_DATE DATE
AS
BEGIN	
	Select SUM(cc.Debit) as DEBIT,SUM(cc.Credit) as CREDIT FROM
		(SELECT SUM(JV_DEBIT_AMOUNT) as Debit, SUM(JV_CREDIT_AMOUNT) as Credit FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @FISCALYEAR AND @pJD_DATE) AND JV_ACCOUNT_ID=@ACC_ID
			 UNION
		SELECT  CHART_ACC_OPENING_BALANCE_DR as Debit, CHART_ACC_OPENING_BALANCE_CR as Credit FROM CHART_ACCOUNT WHERE CHART_ACC_ID=@ACC_ID) cc  
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CURRENT_DEBIT_CREDIT_DEPRICIATION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <25 January, 2012>
-- Description:	<to know about current credit and debit amount of a particular account>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CURRENT_DEBIT_CREDIT_DEPRICIATION]
@ACC_ID BIGINT
AS
BEGIN	
	Select SUM(cc.Debit) as DEBIT,SUM(cc.Credit) as CREDIT FROM
		(SELECT SUM(JV_DEBIT_AMOUNT) as Debit, SUM(JV_CREDIT_AMOUNT) as Credit FROM JOURNAL_VOUCHAR WHERE JV_ACCOUNT_ID=@ACC_ID
			 UNION
		SELECT  CHART_ACC_OPENING_BALANCE_DR as Debit, CHART_ACC_OPENING_BALANCE_CR as Credit FROM CHART_ACCOUNT WHERE CHART_ACC_ID=@ACC_ID) cc  
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DEBIT_CREDIT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL DEBIT AND CREDIT VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_DEBIT_CREDIT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Debit int,
   @total_Credit int
		BEGIN
			SET @total_Debit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Cheque Deposit' OR JV_BANK_REMARK='Cash Deposit');			
			SET @total_Credit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Cheque Payment' OR JV_BANK_REMARK='Cash Payment');
		END
  SELECT @total_Debit AS TOTAL_DEBIT,@total_Credit AS TOTAL_CREDIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_DEBIT_CREDIT_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL DEBIT AND CREDIT VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_DEBIT_CREDIT_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Debit int,
   @total_Credit int
		BEGIN
			SET @total_Debit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND (JV_BANK_REMARK='Cheque Deposit' OR JV_BANK_REMARK='Cash Deposit'));			
			SET @total_Credit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND (JV_BANK_REMARK='Cheque Payment' OR JV_BANK_REMARK='Cash Payment'));
		END
  SELECT @total_Debit AS TOTAL_DEBIT,@total_Credit AS TOTAL_CREDIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_DEPRICIATION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <26 January, 2012>
-- Description:	<DELETE ALL DATA FROM DEPRICIATION TABLE>
-- ==============================================
 CREATE PROCEDURE [dbo].[SP_DELETE_DEPRICIATION]
 
 AS
   BEGIN
     SET NOCOUNT ON;
        DECLARE @STARTDATE DATE,@ENDDATE DATE
      SET @STARTDATE = (SELECT F_YEAR_START_DATE FROM FISCAL_YEAR WHERE F_YEAR_STATUS = 'Active' )
      SET @ENDDATE = (SELECT F_YEAR_END_DATE FROM FISCAL_YEAR WHERE F_YEAR_STATUS = 'Active' )
      
      DELETE  FROM DEPRICIATION
      WHERE ACCESS_DATE BETWEEN @STARTDATE AND @ENDDATE
      
   END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ALL_DEPRICIATION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <23 January, 2012>
-- Description:	<GET ALL DATA FROM DEPRICIATION TABLE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_ALL_DEPRICIATION]


AS
 BEGIN
    SET NOCOUNT ON;
    DECLARE @STARTDATE DATE,@ENDDATE DATE
      SET @STARTDATE = (SELECT F_YEAR_START_DATE FROM FISCAL_YEAR WHERE F_YEAR_STATUS = 'Active' )
      SET @ENDDATE = (SELECT F_YEAR_END_DATE FROM FISCAL_YEAR WHERE F_YEAR_STATUS = 'Active' )
    
SELECT ACCESS_BY ,
       ACCESS_DATE ,
       ACCOUNT_ID ,
       ORIGINAL_COST ,
       DEP_VALUE ,
       NEW_ORIGINAL_COST ,
       JOURNAL_ID
        FROM DEPRICIATION 

 WHERE ACCESS_DATE BETWEEN @STARTDATE AND @ENDDATE 
 
 END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DEPRICIATION_ALL]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <30 January, 2012>
-- Description:	<GET ALL DATA FROM DEPRICIATION TABLE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_DEPRICIATION_ALL]

AS
 BEGIN
    SET NOCOUNT ON;
    
  SELECT DEPRICIATION.ACCESS_BY ,
         DEPRICIATION.ACCESS_DATE ,
         DEPRICIATION.ACCOUNT_ID ,
         ORIGINAL_COST ,
         DEP_VALUE ,
         NEW_ORIGINAL_COST ,
        JOURNAL_ID,DEP_PERCENTAGE, CHART_ACC_NAME AS ACCOUNT_NAME
        FROM DEPRICIATION JOIN DEPRICIATION_SETUP ON DEPRICIATION.ACCOUNT_ID = DEPRICIATION_SETUP.ACCOUNT_ID
                          JOIN CHART_ACCOUNT ON  DEPRICIATION.ACCOUNT_ID = CHART_ACCOUNT.CHART_ACC_ID    
 
 END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DEPRICIATION_DATE_WISE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <30 January, 2012>
-- Description:	<GET ALL DATA FROM DEPRICIATION TABLE IN FISCAL YEAR DATE WISE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_DEPRICIATION_DATE_WISE]
@STARTDATE DATE,
@ENDDATE DATE

AS
 BEGIN
    SET NOCOUNT ON;
    
  SELECT DEPRICIATION.ACCESS_BY ,
         DEPRICIATION.ACCESS_DATE ,
         DEPRICIATION.ACCOUNT_ID ,
         DEPRICIATION_SETUP.DEBIT_ACC_ID,
         ORIGINAL_COST ,
         DEP_VALUE ,
         NEW_ORIGINAL_COST ,
        JOURNAL_ID,DEP_PERCENTAGE, CHART_ACC_NAME AS ACCOUNT_NAME
        FROM DEPRICIATION JOIN DEPRICIATION_SETUP ON DEPRICIATION.ACCOUNT_ID = DEPRICIATION_SETUP.ACCOUNT_ID
                          JOIN CHART_ACCOUNT ON  DEPRICIATION.ACCOUNT_ID = CHART_ACCOUNT.CHART_ACC_ID    

        WHERE DEPRICIATION.ACCESS_DATE BETWEEN @STARTDATE AND @ENDDATE 
 
 END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_JVID_WITHOUT_BANK]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_JVID_WITHOUT_BANK]
AS
BEGIN
	select JV_ID from (select * from JOURNAL_VOUCHAR where JV_BANK_REMARK='Journal') journal
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_NET_INCOME_LOSS]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Refat>
-- Create date: <11 January, 2012>
-- Description:	<Get Net Income Or Loss For Balance Sheet>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GET_NET_INCOME_LOSS]
	@FISCALYEAR DATE,
	@pJD_DATE DATE
AS
BEGIN
	SET NOCOUNT ON;	

	Select SUM(t.CREDIT)-Sum(t.DEBIT) AS NET_INCOME_LOSS from
	(Select SUM(cc.Debit) as DEBIT,SUM(cc.Credit) as CREDIT FROM
		(SELECT JV_ACCOUNT_ID as REF,SUM(JV_DEBIT_AMOUNT) as Debit, SUM(JV_CREDIT_AMOUNT) as Credit FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @FISCALYEAR AND @pJD_DATE) GROUP BY JV_ACCOUNT_ID		
			UNION
		SELECT CHART_ACC_ID as REF,CHART_ACC_OPENING_BALANCE_DR as Debit, CHART_ACC_OPENING_BALANCE_CR as Credit FROM CHART_ACCOUNT
		)cc  
	join CHART_ACCOUNT as CT on cc.REF=CT.CHART_ACC_ID where CT.CHART_ACC_PARENT_TYPE = 'REVENUE' or CT.CHART_ACC_PARENT_TYPE = 'EXPENSE'
	) t
END

GO
/****** Object:  StoredProcedure [dbo].[SP_HEADER_ACC_NAME]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <29 January, 2012>
-- Description:	<GET PARENT ACCOUNT NAME WHICH R ALREADY MAKE TRANSACTION>
-- =============================================
CREATE PROCEDURE [dbo].[SP_HEADER_ACC_NAME]
AS
 BEGIN
   SET NOCOUNT ON;
   
   SELECT DISTINCT JV.JV_ACCOUNT_NAME,JV.JV_ACCOUNT_ID FROM (SELECT CHART_ACC_NAME,CHART_ACC_ID FROM CHART_ACCOUNT WHERE CHART_ACC_HEADER='Yes') CA 
     JOIN JOURNAL_VOUCHAR JV ON 
     CA.CHART_ACC_ID=JV.JV_ACCOUNT_ID 
     
 END

GO
/****** Object:  StoredProcedure [dbo].[SP_HEADER_STATEMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HEADER_STATEMENT]
@accountId BIGINT
AS
BEGIN
	IF EXISTS(SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_ACCOUNT_ID = @accountId))
		BEGIN
			SELECT	CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
			,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
			,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
			,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
			,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
			,JOURNAL_VOUCHAR.ID
			,JV_ID
			,JV_ACCOUNT_ID
			,JV_ACCOUNT_CODE
			,JV_ACCOUNT_NAME
			,JV_DEBIT_AMOUNT
			,JV_CREDIT_AMOUNT
			,JV_DATE
			,JV_NOTES
			,JV_CHEQUE_NO
			,JV_CHEQUE_DATE
			,JV_BANK_REMARK FROM JOURNAL_VOUCHAR join CHART_ACCOUNT on JOURNAL_VOUCHAR.JV_ACCOUNT_ID = CHART_ACCOUNT.CHART_ACC_ID
					WHERE JV_ID in (SELECT JV_ID FROM JOURNAL_VOUCHAR WHERE (JV_ACCOUNT_ID = @accountId))
					ORDER BY JV_DATE
		END
--Modified By Refat(19 th feb'2012)
	--ELSE
	--	BEGIN
	--		SELECT CHART_ACCOUNT.CHART_ACC_NAME as COA_NAME
	--		,CHART_ACCOUNT.CHART_ACC_ID as COA_ID
	--		,CHART_ACCOUNT.CHART_ACC_CODE as COA_CODE
	--		,'OP_DR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_DR
	--		,'OP_CR'=CHART_ACCOUNT.CHART_ACC_OPENING_BALANCE_CR
	--		FROM CHART_ACCOUNT WHERE CHART_ACCOUNT.CHART_ACC_NAME = @accountTitle
	--	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INCOME_STATEMENT_FINAL]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <22/12/2011>
-- Description:	<THIS PROCEDURE WILL GENERATE INCOME RECORD FROM "JOURNAL_VOUCHAR" AND "CHART_ACCOUNT" TABLE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INCOME_STATEMENT_FINAL]
@FisStartDate DATE,
@pJD_DATE DATE
AS
DECLARE @FISCALYEAREND DATE

SELECT cc.ACCOUNT_TITLE,cc.ACC_ID,cc.ACC_CODE,SUM(cc.Debit) as DEBIT,SUM(cc.Credit) as CREDIT,dd.CHART_ACC_PARENT_TYPE--,dd.COA_TYPE,dd.COA_SUB_ACCOUNT
FROM
	   (SELECT JV_ACCOUNT_NAME as ACCOUNT_TITLE, JV_ACCOUNT_ID as ACC_ID,JV_ACCOUNT_CODE as ACC_CODE, SUM(JV_DEBIT_AMOUNT) as Debit, SUM(JV_CREDIT_AMOUNT) as Credit
		FROM JOURNAL_VOUCHAR --jv
		where JV_DATE BETWEEN @FisStartDate AND @pJD_DATE
		GROUP BY JV_ACCOUNT_NAME,JV_ACCOUNT_ID,JV_ACCOUNT_CODE
	UNION  
		SELECT  CHART_ACC_NAME as ACCOUNT_TITLE,CHART_ACC_ID as ACC_ID,CHART_ACC_CODE as ACC_CODE,
		SUM(CHART_ACC_OPENING_BALANCE_DR) as Debit, SUM(CHART_ACC_OPENING_BALANCE_CR) as Credit
		FROM CHART_ACCOUNT --COA
		GROUP BY CHART_ACC_NAME,CHART_ACC_ID,CHART_ACC_CODE ) cc

JOIN	
	(SELECT  CHART_ACC_NAME,CHART_ACC_CODE,CHART_ACC_PARENT_TYPE
	 FROM CHART_ACCOUNT 
     GROUP BY CHART_ACC_NAME,CHART_ACC_CODE,CHART_ACC_PARENT_TYPE)dd
ON cc.ACCOUNT_TITLE=dd.CHART_ACC_NAME
GROUP BY cc.ACCOUNT_TITLE,cc.ACC_ID,cc.ACC_CODE,dd.CHART_ACC_PARENT_TYPE

GO
/****** Object:  StoredProcedure [dbo].[SP_JOURNAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL JOURNAL AND CONTRA VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_JOURNAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_journal int,
   @total_contra int
		BEGIN
			SET @total_journal =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Journal');			
			SET @total_contra =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Contra Voucher');
		END
  SELECT @total_journal AS TOTAL_JOURNAL,@total_contra AS TOTAL_CONTRA
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_JOURNAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL JOURNAL AND CONTRA VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_JOURNAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_journal int,
   @total_contra int
		BEGIN
			SET @total_journal =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND JV_BANK_REMARK='Journal');			
			SET @total_contra =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND JV_BANK_REMARK='Contra Voucher');
		END
  SELECT @total_journal AS TOTAL_JOURNAL,@total_contra AS TOTAL_CONTRA
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_JOURNAL_VOUCHAR_LAST_ID]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <11-12-2011>
-- Description:	<Generate Last Journal-ID>
-- =============================================
CREATE PROCEDURE [dbo].[SP_JOURNAL_VOUCHAR_LAST_ID]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE
		@vJV_ID VARCHAR(20),
		@countRow INT	
	SELECT @countRow=COUNT(*) FROM JOURNAL_VOUCHAR 	
	IF(@countRow<>0)		
		BEGIN
			DECLARE @num int
			SELECT @num=(max(CONVERT(int, SUBSTRING( JV_ID,3,8)))+1)  FROM JOURNAL_VOUCHAR
			SET @vJV_ID=(SELECT Distinct('JV'+RIGHT ('000000'+ CAST(@num as varchar), 6))  FROM JOURNAL_VOUCHAR)
		END
	ELSE
		SET	@vJV_ID='JV000001'
	SELECT @vJV_ID AS JOURNAL_ID	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_RECEIVE_PAYMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--REFAT(10-05-2012)
CREATE PROCEDURE [dbo].[SP_RECEIVE_PAYMENT]
@pFromDate DATE,
@pToDate DATE,
@pParentType VARCHAR(50)
AS
BEGIN
	SELECT JV_ACCOUNT_ID,SUM(JV_DEBIT_AMOUNT) AS Debit,SUM(JV_CREDIT_AMOUNT) AS Credit FROM JOURNAL_VOUCHAR
		WHERE JV_ACCOUNT_ID IN (SELECT CHART_ACC_ID FROM CHART_ACCOUNT WHERE CHART_ACC_PARENT_TYPE=@pParentType)
		AND(JV_DATE BETWEEN @pFromDate AND @pToDate) GROUP BY JV_ACCOUNT_ID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL CONTRA VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_contra int
		BEGIN
			SET @total_contra =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Contra Voucher');
		END
  SELECT @total_contra AS TOTAL_CONTRA
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL CONTRA VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_CONTRA_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_contra int
		BEGIN
			SET @total_contra =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND JV_BANK_REMARK='Contra Voucher');
		END
  SELECT @total_contra AS TOTAL_CONTRA
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_DEPOSIT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL DEPOSIT VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_DEPOSIT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Debit int
		BEGIN
			SET @total_Debit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND (JV_BANK_REMARK='Cheque Deposit' OR JV_BANK_REMARK='Cash Deposit'));			
			
		END
  SELECT @total_Debit AS TOTAL_DEBIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_DEPOSIT_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL DEBIT  VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_DEPOSIT_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Debit int
		BEGIN
			SET @total_Debit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND (JV_BANK_REMARK='Cheque Deposit' OR JV_BANK_REMARK='Cash Deposit'));			
		END
  SELECT @total_Debit AS TOTAL_DEBIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_JOURNAL_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL JOURNAL VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_JOURNAL_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_journal int
		BEGIN
			SET @total_journal =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND JV_BANK_REMARK='Journal');
		END
  SELECT @total_journal AS TOTAL_JOURNAL
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_JOURNAL_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL JOURNAL  VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_JOURNAL_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_journal int
		BEGIN
			SET @total_journal =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND JV_BANK_REMARK='Journal');			
		END
  SELECT @total_journal AS TOTAL_JOURNAL
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_PAYMENT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL PAYMENT VOUCHER BETWEEN DATE RANGE>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_PAYMENT_VOUCHER_FOR_DAY_BOOK_BETWEEN_DATE]

@From_Date DATE,
@To_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Credit int
		BEGIN
			SET @total_Credit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE (JV_DATE BETWEEN @From_Date AND @To_Date) AND (JV_BANK_REMARK='Cheque Payment' OR JV_BANK_REMARK='Cash Payment'));
		END
  SELECT @total_Credit AS TOTAL_CREDIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_PAYMENT_VOUCHER_FOR_DAY_BOOK_BY_DATE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <17-04-2011>
-- Description:	<COUNT TOTAL CREDIT VOUCHER>
-- =============================================

CREATE PROCEDURE [dbo].[SP_TOTAL_PAYMENT_VOUCHER_FOR_DAY_BOOK_BY_DATE]

@Journal_Date DATE

AS
  BEGIN
  SET NOCOUNT ON;
   Declare
   @total_Credit int
		BEGIN
			SET @total_Credit =(SELECT COUNT(DISTINCT JV_ID) FROM JOURNAL_VOUCHAR WHERE JV_DATE=@Journal_Date  AND (JV_BANK_REMARK='Cheque Payment' OR JV_BANK_REMARK='Cash Payment'));
		END
  SELECT @total_Credit AS TOTAL_CREDIT
  END

GO
/****** Object:  StoredProcedure [dbo].[SP_TRIAL_BALANCE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<AMIN>
-- Create date: <20/12/2011>
-- Description:	<THIS PROCEDURE IS USING FOR DISPLAY TRIAL BALANCE>
-- =============================================
CREATE PROCEDURE [dbo].[SP_TRIAL_BALANCE]
(@FiscalStartDate DATE,@pJD_DATE DATE)
WITH 
EXECUTE AS CALLER
AS
BEGIN
	SET NOCOUNT ON;
Select cc.ACCOUNT_TITLE,cc.ACCOUNT_ID,cc.CODE,SUM(cc.Debit) as DEBIT,SUM(cc.Credit) as CREDIT from
(SELECT JV_ACCOUNT_NAME as ACCOUNT_TITLE, JV_ACCOUNT_ID as ACCOUNT_ID,JV_ACCOUNT_CODE as CODE, SUM(JV_DEBIT_AMOUNT) as Debit, SUM(JV_CREDIT_AMOUNT) as Credit
FROM JOURNAL_VOUCHAR --jv
where JV_DATE BETWEEN @FiscalStartDate AND @pJD_DATE
GROUP BY JV_ACCOUNT_NAME,JV_ACCOUNT_ID,JV_ACCOUNT_CODE
UNION
SELECT  CHART_ACC_NAME as ACCOUNT_TITLE,CHART_ACC_ID as ACCOUNT_ID,CHART_ACC_CODE as CODE, SUM(CHART_ACC_OPENING_BALANCE_DR) as Debit, SUM(CHART_ACC_OPENING_BALANCE_CR) as Credit
FROM CHART_ACCOUNT  --COA
WHERE CHART_ACC_HEADER='No'
GROUP BY CHART_ACC_NAME,CHART_ACC_ID,CHART_ACC_CODE ) cc
group by ACCOUNT_TITLE,ACCOUNT_ID,CODE
END

GO
/****** Object:  StoredProcedure [dbo].[Student_Money_Receipt_Report]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[Student_Money_Receipt_Report] 
	@StudentId int,
	@semesterId int,
	@Year int,
	@date date
AS
BEGIN
	select CampusName,CampusAddress,ApplicantName,DepartmentName,SemesterNo,Name,Amount,ReceiveAmount,ReceiveDate,AccadamicInfo_RollNo
from STUDENTFEES
left join FEESDETAILS on STUDENTFEES.FeesDetailsId=FEESDETAILS.Id
left join SEMESTER on STUDENTFEES.SemesterId=SEMESTER.Id
left join DEPARTMENT on STUDENTFEES.DepartmentId=DEPARTMENT.Id
left join ADMISSIONINFO on STUDENTFEES.StudentPkId=ADMISSIONINFO.Id
left join CAMPUSINFO on ADMISSIONINFO.CampusId=CAMPUSINFO.Id
left join STUDENTFEESCOLLECTION on STUDENTFEES.StudentPkId=STUDENTFEESCOLLECTION.StudentPKId and STUDENTFEESCOLLECTION.SemesterId=@semesterId and STUDENTFEESCOLLECTION.Year=@Year and ReceiveDate=@date

where STUDENTFEES.StudentPKId=@StudentId and STUDENTFEES.SemesterId=@semesterId  and STUDENTFEES.Year=@Year
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateStudentPaymentAmount]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateStudentPaymentAmount]
	@StudentId int,
	@semesterId int,
	@Year int,
	@PaidAmount int,
	@DueAmount int

AS
BEGIN
	 
	--SET NOCOUNT ON;
	--select PaidAmount
	--from STUDENTFEES
	UPDATE STUDENTFEES
	SET PaidAmount=@PaidAmount,
	DueAmount=@DueAmount
   
   WHERE StudentPkId=@StudentId and SemesterId=@semesterId and Year=@Year


END

GO
/****** Object:  Table [dbo].[ACCOUNT_TYPE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ACCOUNT_TYPE](
	[ACC_TYPE_ID] [bigint] IDENTITY(100,1) NOT NULL,
	[ACC_NAME] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ACCOUNT_TYPE] PRIMARY KEY CLUSTERED 
(
	[ACC_TYPE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ADD_STUDENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADD_STUDENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [varchar](50) NULL,
	[ProgramId] [int] NULL,
	[DepartmentId] [int] NULL,
	[CampusId] [int] NULL,
	[Session] [varchar](50) NULL,
	[AccadamicYear] [varchar](50) NULL,
	[BatchId] [int] NULL,
	[BanglaProgram] [int] NULL,
	[BangDepartment] [int] NULL,
	[BanglaCampas] [int] NULL,
	[BanglaSession] [nvarchar](200) NULL,
	[BanglaAccadamicYear] [varchar](50) NULL,
	[BanglaBatch] [int] NULL,
	[ApplicantName] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Nationality] [varchar](50) NULL,
	[BloodGroup] [int] NULL,
	[ReligionId] [int] NULL,
	[Interest] [varchar](50) NULL,
	[OthersInfo] [varchar](max) NULL,
	[BanglaApplicantName] [nvarchar](200) NULL,
	[BanglaGender] [bit] NULL,
	[BanglaNationality] [nvarchar](200) NULL,
	[BanglaReligion] [int] NULL,
	[BanglaHobby] [nvarchar](200) NULL,
	[BanglaInterest] [nvarchar](200) NULL,
	[BanglaOthersInfo] [nvarchar](200) NULL,
	[FatherName] [varchar](50) NULL,
	[MotherName] [varchar](50) NULL,
	[FreedomFighter] [bit] NULL,
	[Tribal] [bit] NULL,
	[FathersMobileNo] [varchar](50) NULL,
	[MothersMobileNo] [varchar](50) NULL,
	[TelephoneNo] [varchar](50) NULL,
	[PermanentHouserNo] [varchar](50) NULL,
	[PermanentRoadNo] [varchar](50) NULL,
	[PermanentBlock] [varchar](50) NULL,
	[PermanentSector] [varchar](50) NULL,
	[PermanentPostId] [int] NULL,
	[PermanentThanaId] [int] NULL,
	[PermanentDistrictid] [int] NULL,
	[PresentHouserNo] [varchar](50) NULL,
	[PresentRoadNo] [varchar](50) NULL,
	[PresentBlock] [varchar](50) NULL,
	[PresentSector] [varchar](50) NULL,
	[PresentPostId] [int] NULL,
	[PresentThanaId] [int] NULL,
	[PresentDistrictId] [int] NULL,
	[BanglaFatherName] [nvarchar](200) NULL,
	[BanglaMotherName] [nvarchar](200) NULL,
	[BanglaFreedomFighter] [bit] NULL,
	[BanglaTribal] [bit] NULL,
	[BanglaPermanentHouserNo] [nvarchar](200) NULL,
	[BanglaPermanentRoadNo] [nvarchar](200) NULL,
	[BanglaPermanentBlock] [nvarchar](200) NULL,
	[BanglaPermanentSector] [nvarchar](200) NULL,
	[BanglaPermanentPost] [int] NULL,
	[BanglaPermanentThana] [int] NULL,
	[BanglaPermanentDistrict] [int] NULL,
	[BanglaPresentHouserNo] [nvarchar](200) NULL,
	[BanglaPresentRoadNo] [nvarchar](200) NULL,
	[BanglaPresentBlock] [nvarchar](200) NULL,
	[BanglaPresentSector] [nvarchar](200) NULL,
	[BanglaPresentPost] [int] NULL,
	[BanglaPresentThana] [int] NULL,
	[BanglaPresentDistrict] [int] NULL,
	[GuardianName] [varchar](50) NULL,
	[GuardianMobileNo] [varchar](50) NULL,
	[GuardianEmail] [varchar](50) NULL,
	[GuardianHouserNo] [varchar](50) NULL,
	[GuardianRoadNo] [varchar](50) NULL,
	[GuardianBlock] [varchar](50) NULL,
	[GuardianSector] [varchar](50) NULL,
	[GuardianPostId] [int] NULL,
	[GuardianThanaId] [int] NULL,
	[GuardianDistrictId] [int] NULL,
	[BanglaGuardianName] [nvarchar](200) NULL,
	[BanglaGuardianHouserNo] [nvarchar](200) NULL,
	[BanglaGuardianRoadNo] [nvarchar](200) NULL,
	[BanglaGuardianBlock] [nvarchar](200) NULL,
	[BanglaGuardianSector] [nvarchar](200) NULL,
	[BanglaGuardianPost] [int] NULL,
	[BanglaGuardianThana] [int] NULL,
	[BanglaGuardianDistrict] [int] NULL,
	[DateOfBirth] [datetime] NULL,
 CONSTRAINT [PK_ADD_STUDENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ADMISSIONINFO]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADMISSIONINFO](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [varchar](50) NULL,
	[ProgramId] [int] NULL,
	[DepartmentId] [int] NULL,
	[CampusId] [int] NULL,
	[Session] [varchar](50) NULL,
	[AccadamicYear] [varchar](50) NULL,
	[BatchId] [int] NULL,
	[BanglaProgram] [int] NULL,
	[BangDepartment] [int] NULL,
	[BanglaCampas] [int] NULL,
	[BanglaSession] [nvarchar](200) NULL,
	[BanglaAccadamicYear] [nvarchar](50) NULL,
	[BanglaBatch] [int] NULL,
	[ApplicantName] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[BanglaDateOfBirth] [datetime] NULL,
	[Nationality] [varchar](50) NULL,
	[BloodGroup] [int] NULL,
	[ReligionId] [int] NULL,
	[Interest] [varchar](50) NULL,
	[OthersInfo] [varchar](max) NULL,
	[BanglaApplicantName] [nvarchar](200) NULL,
	[BanglaGender] [nvarchar](50) NULL,
	[BanglaNationality] [nvarchar](200) NULL,
	[BanglaReligion] [int] NULL,
	[BanglaHobby] [nvarchar](200) NULL,
	[BanglaInterest] [nvarchar](200) NULL,
	[BanglaOthersInfo] [nvarchar](200) NULL,
	[FatherName] [varchar](50) NULL,
	[MotherName] [varchar](50) NULL,
	[FreedomFighter] [bit] NULL,
	[Tribal] [bit] NULL,
	[FathersMobileNo] [varchar](50) NULL,
	[MothersMobileNo] [varchar](50) NULL,
	[TelephoneNo] [varchar](50) NULL,
	[PermanentHouserNo] [varchar](50) NULL,
	[PermanentRoadNo] [varchar](50) NULL,
	[PermanentBlock] [varchar](50) NULL,
	[PermanentSector] [varchar](50) NULL,
	[PermanentPostId] [int] NULL,
	[PermanentThanaId] [int] NULL,
	[PermanentDistrictid] [int] NULL,
	[PresentHouserNo] [varchar](50) NULL,
	[PresentRoadNo] [varchar](50) NULL,
	[PresentBlock] [varchar](50) NULL,
	[PresentSector] [varchar](50) NULL,
	[PresentPostId] [int] NULL,
	[PresentThanaId] [int] NULL,
	[PresentDistrictId] [int] NULL,
	[BanglaFatherName] [nvarchar](200) NULL,
	[BanglaMotherName] [nvarchar](200) NULL,
	[BanglaFreedomFighter] [bit] NULL,
	[BanglaTribal] [bit] NULL,
	[BanglaPermanentHouserNo] [nvarchar](200) NULL,
	[BanglaPermanentRoadNo] [nvarchar](200) NULL,
	[BanglaPermanentBlock] [nvarchar](200) NULL,
	[BanglaPermanentSector] [nvarchar](200) NULL,
	[BanglaPermanentPost] [int] NULL,
	[BanglaPermanentThana] [int] NULL,
	[BanglaPermanentDistrict] [int] NULL,
	[BanglaPresentHouserNo] [nvarchar](200) NULL,
	[BanglaPresentRoadNo] [nvarchar](200) NULL,
	[BanglaPresentBlock] [nvarchar](200) NULL,
	[BanglaPresentSector] [nvarchar](200) NULL,
	[BanglaPresentPost] [int] NULL,
	[BanglaPresentThana] [int] NULL,
	[BanglaPresentDistrict] [int] NULL,
	[GuardianName] [varchar](50) NULL,
	[GuardianMobileNo] [varchar](50) NULL,
	[GuardianEmail] [varchar](50) NULL,
	[GuardianHouserNo] [varchar](50) NULL,
	[GuardianRoadNo] [varchar](50) NULL,
	[GuardianBlock] [varchar](50) NULL,
	[GuardianSector] [varchar](50) NULL,
	[GuardianPostId] [int] NULL,
	[GuardianThanaId] [int] NULL,
	[GuardianDistrictId] [int] NULL,
	[BanglaGuardianName] [nvarchar](200) NULL,
	[BanglaGuardianHouserNo] [nvarchar](200) NULL,
	[BanglaGuardianRoadNo] [nvarchar](200) NULL,
	[BanglaGuardianBlock] [nvarchar](200) NULL,
	[BanglaGuardianSector] [nvarchar](200) NULL,
	[BanglaGuardianPost] [int] NULL,
	[BanglaGuardianThana] [int] NULL,
	[BanglaGuardianDistrict] [int] NULL,
	[Student_Photo] [varbinary](max) NULL,
	[Student_Signature] [varbinary](max) NULL,
	[AccadamicInfo_ExamNme] [nvarchar](50) NULL,
	[AccadamicInfo_Group] [nvarchar](50) NULL,
	[AccadamicInfo_Board] [nvarchar](50) NULL,
	[AccadamicInfo_SchoolName] [nvarchar](50) NULL,
	[AccadamicInfo_RollNo] [int] NULL,
	[AccadamicInfo_RegistrationNo] [int] NULL,
	[AccadamicInfo_PassingYear] [int] NULL,
	[AccadamicInfo_GPA] [varchar](50) NULL,
	[CurrentSemester] [int] NULL,
	[BoardRollNo] [int] NULL,
	[BoardRegistrationNo] [int] NULL,
 CONSTRAINT [PK_ADMIDDIONINFO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ADMISSIONOFFICE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADMISSIONOFFICE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OfficeName] [varchar](50) NOT NULL,
	[CampusId] [int] NOT NULL,
 CONSTRAINT [PK_ADMISSIONOFFICE_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALL_ACCOUNT_TYPE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALL_ACCOUNT_TYPE](
	[ACC_TYPE_ID] [bigint] NOT NULL,
	[ACC_NAME] [varchar](50) NULL,
 CONSTRAINT [PK_ALL_ACCOUNT_TYPE] PRIMARY KEY CLUSTERED 
(
	[ACC_TYPE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BALANCE_SHEET_CONFIGURE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BALANCE_SHEET_CONFIGURE](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCID] [bigint] NULL,
 CONSTRAINT [PK_BALANCE_SHEET_CONFIGURE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BATCH]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BATCH](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[BatchNo] [varchar](50) NULL,
	[BanglaBatch] [nvarchar](200) NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BLOODGROUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BLOODGROUP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BloodGroupName] [varchar](50) NULL,
 CONSTRAINT [PK_BLOODGROUP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_ISSUE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK_ISSUE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentPKId] [int] NULL,
	[StudentId] [varchar](50) NULL,
	[Semester] [varchar](50) NULL,
	[BookId] [int] NULL,
	[ReceiveDate] [date] NULL,
	[ReturnDate] [date] NULL,
	[BookReturnStatus] [varchar](50) NULL,
	[DelayReturn] [varchar](50) NULL,
	[BookReturnDateFromStudent] [date] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_BOOK_ISSUE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOKS_DETAILS]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOKS_DETAILS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProgramId] [int] NULL,
	[DepartmentId] [int] NULL,
	[BookName] [varchar](50) NULL,
	[BookAuthor] [varchar](50) NULL,
	[BookEdition] [varchar](50) NULL,
	[PublishedYear] [int] NULL,
	[SelfNumber] [varchar](50) NULL,
	[EntryDate] [date] NULL,
	[Quantiry] [int] NULL,
 CONSTRAINT [PK_BOOKS_DETAILS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CAMPUSINFO]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CAMPUSINFO](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampusName] [varchar](50) NOT NULL,
	[CampusAddress] [varchar](50) NOT NULL,
	[ContactPerson] [varchar](50) NOT NULL,
	[MobileNumber] [varchar](50) NOT NULL,
	[BanglaCampus] [nvarchar](200) NULL,
 CONSTRAINT [PK_CampusInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHART_ACCOUNT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHART_ACCOUNT](
	[CHART_ACC_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CHART_ACC_CODE] [varchar](50) NULL,
	[CHART_ACC_PARENT_ID] [bigint] NULL,
	[CHART_ACC_PARENT_TYPE] [varchar](50) NULL,
	[CHART_ACC_NAME] [varchar](50) NULL,
	[CHART_ACC_OPENING_BALANCE_DR] [decimal](18, 2) NULL,
	[CHART_ACC_OPENING_BALANCE_CR] [decimal](18, 2) NULL,
	[CHART_ACC_HEADER] [varchar](10) NULL,
	[CHART_ACC_STATUS] [varchar](10) NULL,
	[CHART_ACC_CREATION_DATE] [date] NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATE] [date] NULL,
 CONSTRAINT [PK_CHART_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[CHART_ACC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CLASSPERIOD]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASSPERIOD](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Period] [nvarchar](50) NULL,
	[StartTime] [nchar](10) NULL,
	[EndTime] [nchar](10) NULL,
 CONSTRAINT [PK_CLASSPERIOD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COMPANY_SETUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COMPANY_SETUP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY_NAME] [varchar](100) NULL,
	[ADDRESS] [varchar](250) NULL,
	[PHONE] [varchar](50) NULL,
	[FAX] [varchar](50) NULL,
	[EMAIL] [varchar](50) NULL,
	[WEBSITE] [varchar](100) NULL,
	[LOGO] [varbinary](max) NULL,
	[PROP_NAME] [varchar](50) NULL,
 CONSTRAINT [PK_COMPANY_SETUP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COURSE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COURSE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NULL,
	[ProgramId] [int] NULL,
	[SemesterId] [int] NULL,
	[CourseName] [varchar](50) NULL,
	[BanglaCourseName] [nvarchar](50) NULL,
	[CourseCode] [varchar](50) NULL,
	[TheoryCredit] [decimal](18, 0) NULL,
	[PracticalCredit] [decimal](18, 0) NULL,
	[TotalCredit] [decimal](18, 0) NULL,
	[TheoryMarkasContinuousAssessment] [decimal](18, 0) NULL,
	[TheoryMarkasFinalExam] [decimal](18, 0) NULL,
	[PracticalMarkasContinuousAssessment] [decimal](18, 0) NULL,
	[PracticalMarkasFinalExam] [decimal](18, 0) NULL,
	[TotalMarks] [decimal](18, 0) NULL,
 CONSTRAINT [PK_COURSE_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COURSE_ASSIGN_TO_STUDENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentPkId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
	[CourseId] [int] NULL,
	[PreStudentTheoryMarksContinuousAssessment] [decimal](18, 0) NULL,
	[PreStudentPracticalMarksContinuousAssessment] [decimal](18, 0) NULL,
	[PreStudentTheoryMarksFinalExam] [decimal](18, 0) NULL,
	[PreStudentPracticalTheoryMarksFinalExam] [decimal](18, 0) NULL,
	[TotalMarks] [decimal](18, 0) NULL,
 CONSTRAINT [PK_COURSE_ASSIGN_TO_STUDENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CREATE_ROUTINE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CREATE_ROUTINE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Day] [varchar](50) NULL,
	[ClassRutinGroupId] [varchar](50) NULL,
	[FirstClass] [int] NULL,
	[FirstCourse] [int] NULL,
	[FirstTeacher] [int] NULL,
	[SecondClass] [int] NULL,
	[SecondCourse] [int] NULL,
	[SecondTeacher] [int] NULL,
	[ThirdClass] [int] NULL,
	[ThirdCourse] [int] NULL,
	[ThirdTeacher] [int] NULL,
	[ForthClass] [int] NULL,
	[ForthCourse] [int] NULL,
	[ForthTeacher] [int] NULL,
	[FifthClass] [int] NULL,
	[FifthCourse] [int] NULL,
	[FifthTeacher] [int] NULL,
	[SixthClass] [int] NULL,
	[SixthCourse] [int] NULL,
	[SixthTeacher] [int] NULL,
	[SeventhClass] [int] NULL,
	[SeventhCourse] [int] NULL,
	[SeventhTeacher] [int] NULL,
	[EighthClass] [int] NULL,
	[EighthCourse] [int] NULL,
	[EighthTeacher] [int] NULL,
	[Year] [varchar](50) NULL,
	[ProgramId] [int] NULL,
	[DepartmentId] [int] NULL,
	[SemesterId] [int] NULL,
 CONSTRAINT [PK_CREATE_ROUTINE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CUSTOMER_EMPLOYEE_SETUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CUSTOMER_EMPLOYEE_SETUP](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCOUNT_ID] [bigint] NOT NULL,
	[NAME] [varchar](50) NULL,
	[CONTACT_NO] [varchar](50) NULL,
	[CONTACT_PERSON] [varchar](100) NULL,
	[NATIONAL_ID] [varchar](50) NULL,
	[ADDRESS] [varchar](500) NULL,
 CONSTRAINT [PK_CUSTOMER_EMPLOYEE_SETUP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DAY]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DAY](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DaySeveneven] [varchar](50) NULL,
	[BanglaDay] [nvarchar](50) NULL,
 CONSTRAINT [PK_DAY] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEPARTMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPARTMENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](50) NOT NULL,
	[DepartmentCode] [varchar](50) NOT NULL,
	[BanglaDepartment] [nvarchar](200) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEPOSIT_PAYMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPOSIT_PAYMENT](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCOUNT_ID] [bigint] NOT NULL,
	[DEPOSIT_PAYMENT_DATE] [date] NULL,
	[AMOUNT] [decimal](18, 2) NULL,
	[BANK_ACCOUNT_ID] [bigint] NULL,
	[DESCRIPTION] [varchar](500) NULL,
	[BANK_INFO_CHEQUE] [varchar](250) NULL,
	[BANK_CHEQUE] [varchar](50) NULL,
	[BANK_CHEQUE_DATE] [date] NULL,
	[CLEARING_DATE] [date] NULL,
	[STATUS] [varchar](50) NULL,
	[TRANSACTION_TYPE] [varchar](50) NULL,
	[JOURNAL_VOUCHER] [varchar](50) NULL,
	[CANCEL_JVOUCHAR] [varchar](500) NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATETIME] [datetime] NULL,
 CONSTRAINT [PK_DEPOSIT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEPRICIATION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPRICIATION](
	[DEP_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCOUNT_ID] [bigint] NOT NULL,
	[ORIGINAL_COST] [decimal](18, 2) NULL,
	[DEP_VALUE] [decimal](18, 2) NULL,
	[NEW_ORIGINAL_COST] [decimal](18, 2) NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATE] [date] NULL,
	[JOURNAL_ID] [varchar](50) NULL,
 CONSTRAINT [PK_DEPRICIATION] PRIMARY KEY CLUSTERED 
(
	[DEP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEPRICIATION_SETUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPRICIATION_SETUP](
	[DEP_SET_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCOUNT_ID] [bigint] NOT NULL,
	[DEP_PERCENTAGE] [decimal](18, 2) NULL,
	[DEBIT_ACC_ID] [bigint] NULL,
	[CREDIT_ACC_ID] [bigint] NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATE] [date] NULL,
 CONSTRAINT [PK_DEPRICIATION_SETUP] PRIMARY KEY CLUSTERED 
(
	[DEP_SET_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DISTRICT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DISTRICT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DistrictName] [varchar](50) NULL,
	[BanglaDistrict] [nvarchar](200) NULL,
 CONSTRAINT [PK_DISTRICT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FEESDETAILS]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FEESDETAILS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FEESDETAILS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FEESSETUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FEESSETUP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
	[Year] [int] NULL,
	[FeesDetailsId] [int] NULL,
	[Amount] [int] NULL,
	[Total] [int] NULL,
	[CampusId] [int] NOT NULL,
 CONSTRAINT [PK_FeesSetup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FISCAL_YEAR]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FISCAL_YEAR](
	[F_YEAR_ID] [int] IDENTITY(1,1) NOT NULL,
	[F_YEAR_NAME] [varchar](50) NULL,
	[F_YEAR_START_DATE] [date] NOT NULL,
	[F_YEAR_END_DATE] [date] NOT NULL,
	[F_YEAR_STATUS] [varchar](50) NOT NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATE] [datetime] NULL,
 CONSTRAINT [PK_FISCAL_YEAR] PRIMARY KEY CLUSTERED 
(
	[F_YEAR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GS_tblCategory]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GS_tblCategory](
	[ItemCategoryID] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
	[CategoryTypeID] [tinyint] NULL,
 CONSTRAINT [PK_GS_tblCategory] PRIMARY KEY CLUSTERED 
(
	[ItemCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INCOME_SHEET_CONFIGURE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INCOME_SHEET_CONFIGURE](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCID] [bigint] NULL,
 CONSTRAINT [PK_INCOME_SHEET_CONFIGURE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JOURNAL_TRANSACTION_TYPE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JOURNAL_TRANSACTION_TYPE](
	[Id] [int] NOT NULL,
	[TypeName] [varchar](50) NULL,
 CONSTRAINT [PK_JOURNAL_TRANSACTION_TYPE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JOURNAL_VOUCHAR]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JOURNAL_VOUCHAR](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[JV_ID] [varchar](50) NOT NULL,
	[JV_ACCOUNT_ID] [bigint] NOT NULL,
	[JV_ACCOUNT_NAME] [varchar](50) NULL,
	[JV_ACCOUNT_CODE] [varchar](50) NULL,
	[JV_DEBIT_AMOUNT] [decimal](18, 2) NULL,
	[JV_CREDIT_AMOUNT] [decimal](18, 2) NULL,
	[JV_NOTES] [varchar](250) NULL,
	[JV_DATE] [date] NULL,
	[JV_CHEQUE_NO] [varchar](50) NULL,
	[JV_CHEQUE_DATE] [date] NULL,
	[JV_BANK_REMARK] [varchar](100) NULL,
	[JV_ACCESS_BY] [varchar](50) NULL,
	[JV_ACCESS_DATE] [date] NULL,
 CONSTRAINT [PK_JOURNAL_VOUCHAR] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LMS_tblCompany]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LMS_tblCompany](
	[strCompanyID] [varchar](50) NOT NULL,
	[strCompany] [varchar](100) NOT NULL,
	[strAddress] [varchar](200) NULL,
	[strIUser] [varchar](50) NULL,
	[strEUser] [varchar](50) NULL,
	[dtIDate] [datetime] NULL,
	[dtEDate] [datetime] NULL,
 CONSTRAINT [PK_LMS_tblCompany] PRIMARY KEY CLUSTERED 
(
	[strCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MEMBER_ACC_TYPE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEMBER_ACC_TYPE](
	[TABLE_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MEMBER_ACCOUNT_TYPE_ID] [bigint] NOT NULL,
	[ACCOUNT_PREFIX] [varchar](50) NULL,
 CONSTRAINT [PK_MEMBER_ACC_TYPE] PRIMARY KEY CLUSTERED 
(
	[TABLE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MEMBER_ASSIGN]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMBER_ASSIGN](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MEMBER_ID] [bigint] NULL,
	[MEMBER_PARENT_ACC_ID] [bigint] NULL,
	[ACC_ID] [bigint] NULL,
 CONSTRAINT [PK_MEMBER_ASSIGN] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MEMBER_INFO]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEMBER_INFO](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MEMBER_NO] [varchar](50) NULL,
	[NO_OF_SHARE] [varchar](50) NULL,
	[MEMBER_FULL_NAME] [varchar](100) NULL,
	[FATHER_NAME] [varchar](100) NULL,
	[MOTHER_NAME] [varchar](100) NULL,
	[HUSBAND_NAME] [varchar](100) NULL,
	[PRESENT_ADDRESS] [varchar](250) NULL,
	[PERMANENT_ADDRESS] [varchar](250) NULL,
	[MOBILE_NO] [int] NULL,
	[EDUCATION_STATUS] [varchar](200) NULL,
	[MEMBER_BIRTH_DATE] [date] NULL,
	[RELIGION] [varchar](50) NULL,
	[MEMBER_OCCUPATION] [varchar](100) NULL,
	[MARITAL_STATUS] [varchar](50) NULL,
	[NATIONALITY] [varchar](50) NULL,
	[NOMINEE_NAME] [varchar](100) NULL,
	[NOMINEE_BIRTH_DATE] [date] NULL,
	[NOMINEE_OCCUPATION] [varchar](100) NULL,
	[RELATION_WITH_NOMINEE] [varchar](100) NULL,
	[MEMBER_PHOTO] [varbinary](max) NULL,
	[DIGITAL_SIGNATURE] [varbinary](max) NULL,
	[NOMINEE_PHOTO] [varbinary](max) NULL,
	[ACCESS_BY] [varchar](50) NULL,
	[ACCESS_DATE] [date] NULL,
 CONSTRAINT [PK_MEMBER_INFO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MODULE_PERMISSION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MODULE_PERMISSION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MODULE_NAME] [varchar](50) NULL,
	[USER_GROUP_ID] [bigint] NULL,
 CONSTRAINT [PK_MODULE_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ONLINEDEPARTMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ONLINEDEPARTMENT](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ONLINEDEPARTMENT] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ONLINEEXAM]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ONLINEEXAM](
	[ExamId] [int] IDENTITY(1,1) NOT NULL,
	[ExamName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ONLINEEXAM] PRIMARY KEY CLUSTERED 
(
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PIS_EMPLOYEE_INFO]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_EMPLOYEE_INFO](
	[GEmployeeGenInfoID] [uniqueidentifier] NOT NULL,
	[GCompanyGenInfoID] [uniqueidentifier] NOT NULL,
	[GFactoryID] [uniqueidentifier] NULL,
	[GDesignationInfoID] [uniqueidentifier] NULL,
	[GLocationID] [uniqueidentifier] NULL,
	[GDepartmentID] [uniqueidentifier] NULL,
	[GEmployeeCatID] [uniqueidentifier] NULL,
	[StrEmpID] [varchar](12) NULL,
	[StrEmpCardNo] [varchar](20) NULL,
	[StrEmpOldCardNo] [varchar](20) NULL,
	[StrEmpOwnLanguageID] [varchar](10) NULL,
	[StrEmpName] [varchar](200) NOT NULL,
	[StrEmpNameOwnLanguage] [nvarchar](200) NULL,
	[intGender] [int] NULL,
	[bitSystemUser] [bit] NULL,
	[GReligionID] [uniqueidentifier] NULL,
	[intMaritalStatus] [int] NULL,
	[dtBirthDate] [datetime] NOT NULL,
	[dtJoiningDate] [datetime] NOT NULL,
	[StrFatherName] [varchar](100) NULL,
	[StrMotherName] [varchar](100) NULL,
	[StrCurrentAddress] [varchar](250) NULL,
	[StrCurrAddrVillageMohalla] [varchar](100) NULL,
	[StrCurrAddrPostOfficeName] [varchar](100) NULL,
	[StrCurrAddrPostCode] [varchar](20) NULL,
	[GCurrAddrAreaInfoID] [uniqueidentifier] NULL,
	[GCurrAddrThanaUpazilaInfoID] [uniqueidentifier] NULL,
	[GCurrAddrDistrictInfoID] [uniqueidentifier] NULL,
	[StrPermanentAddress] [varchar](250) NULL,
	[StrPerAddrVillageMohalla] [varchar](100) NULL,
	[StrPerAddrPostofficeName] [varchar](100) NULL,
	[StrPerAddrPostCode] [varchar](20) NULL,
	[GPerAddrAreaInfoID] [uniqueidentifier] NULL,
	[GPerAddrThanaUpazilaInfoID] [uniqueidentifier] NULL,
	[GPerAddrDistrictInfoID] [uniqueidentifier] NULL,
	[StrEmpPssportNo] [varchar](50) NULL,
	[StrEmpNationalID] [varchar](20) NULL,
	[strEmpMobileNo] [varchar](20) NULL,
	[numEmpWeightKG] [numeric](6, 2) NULL,
	[StrEmpIdenMark] [varchar](100) NULL,
	[intLatePresentPunishmentFlag] [int] NULL,
	[GCreatedBy] [uniqueidentifier] NULL,
	[DtCreatedOn] [datetime] NULL,
	[GUpdatedBy] [uniqueidentifier] NULL,
	[DtUpdatedOn] [datetime] NULL,
	[strEmailAdress] [varchar](100) NULL,
	[DtConfirmationDate] [datetime] NULL,
	[DtResignRetireTerminationDate] [datetime] NULL,
	[strGrade] [varchar](50) NULL,
	[strShift] [varchar](50) NULL,
	[chkEligibleForOverTime] [bit] NULL,
	[strAlternatePhone] [varchar](50) NULL,
	[strTIN] [varchar](50) NULL,
	[strNationalIDCard] [varchar](80) NULL,
	[strAgeString] [varchar](80) NULL,
	[strFunctionalDesignation] [varchar](80) NULL,
	[strBloodGroup] [varchar](80) NULL,
	[GNationalityID] [uniqueidentifier] NULL,
	[bitCarryForwardProcessForDataUpdate] [bit] NULL,
	[bitHeadOffice] [bit] NOT NULL,
	[bitIsRoaster] [bit] NULL,
	[bitEligibleForVistaGLAccount] [bit] NULL,
	[intActiveStatus] [int] NULL,
	[DivisionID] [uniqueidentifier] NULL,
	[FingerPrintNo] [varchar](50) NULL,
	[RelationWithAlternatePhoneOwner] [varchar](50) NULL,
	[ShiftID] [tinyint] NULL,
	[RosterGroupID] [uniqueidentifier] NULL,
	[GPaymentRuleSetupID] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblBloodGroup]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblBloodGroup](
	[BloodGroupID] [varchar](50) NOT NULL,
	[BloodGroupName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PIS_tblBloodGroup] PRIMARY KEY CLUSTERED 
(
	[BloodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblCategory]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblCategory](
	[CategoryID] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PIS_tblCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblCategoryEmp]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblCategoryEmp](
	[CategoryEmpID] [uniqueidentifier] NOT NULL,
	[CategoryEmpName] [varchar](100) NOT NULL,
	[CategoryTypeID] [int] NULL,
 CONSTRAINT [PK_PIS_tblCategoryEmp] PRIMARY KEY CLUSTERED 
(
	[CategoryEmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblCategorySalary]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblCategorySalary](
	[CategorySalaryID] [uniqueidentifier] NOT NULL,
	[CategorySalaryName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PIS_tblCategorySalary] PRIMARY KEY CLUSTERED 
(
	[CategorySalaryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblCountry]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblCountry](
	[Id] [int] NOT NULL,
	[CountryName] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblCountry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblDepartment]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblDepartment](
	[GDepartmentID] [uniqueidentifier] NOT NULL,
	[StrDepartmentName] [varchar](100) NOT NULL,
	[StrDepartmentCode] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblDepartment] PRIMARY KEY CLUSTERED 
(
	[GDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblDesignationInfo]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblDesignationInfo](
	[GDesignationInfoID] [uniqueidentifier] NOT NULL,
	[StrDesignationName] [varchar](100) NOT NULL,
	[GGradeInfoID] [uniqueidentifier] NOT NULL,
	[StrDesignationCode] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblDesignationInfo] PRIMARY KEY CLUSTERED 
(
	[GDesignationInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblDistrictInfo]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblDistrictInfo](
	[GDistrictInfoID] [uniqueidentifier] NOT NULL,
	[GCountryNameID] [uniqueidentifier] NOT NULL,
	[StrDistrictCode] [varchar](10) NULL,
	[StrDistrictName] [nvarchar](100) NOT NULL,
	[StrDistrictDescription] [varchar](250) NULL,
 CONSTRAINT [PK_PIS_tblDistrictInfo] PRIMARY KEY CLUSTERED 
(
	[GDistrictInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblDivision]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblDivision](
	[DivisionID] [uniqueidentifier] NOT NULL,
	[DivisionName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PIS_tblDivision] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblEmpAssignment]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PIS_tblEmpAssignment](
	[GEmpAssignID] [uniqueidentifier] NOT NULL,
	[GEmployeeGenInfoID] [uniqueidentifier] NOT NULL,
	[SectionID] [uniqueidentifier] NULL,
	[FloorID] [uniqueidentifier] NULL,
	[BlockID] [uniqueidentifier] NULL,
	[MachineID] [uniqueidentifier] NULL,
	[TableID] [uniqueidentifier] NULL,
	[AssetID] [uniqueidentifier] NULL,
	[CategoryID] [uniqueidentifier] NULL,
	[CategoryEmpID] [uniqueidentifier] NULL,
	[CategorySalaryID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PIS_tblEmpAssignment] PRIMARY KEY CLUSTERED 
(
	[GEmpAssignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PIS_tblEmpEducationInfo]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblEmpEducationInfo](
	[GEmpEducationInfoID] [uniqueidentifier] NOT NULL,
	[GEmployeeGenInfoID] [uniqueidentifier] NOT NULL,
	[GEmpEduDegreeID] [uniqueidentifier] NOT NULL,
	[intEmpEduDegreeYear] [int] NOT NULL,
	[GEmpEduGroupSubject] [uniqueidentifier] NULL,
	[StrEmpEduInstituteName] [varchar](250) NOT NULL,
	[GEmpEduResultID] [uniqueidentifier] NOT NULL,
	[GEmpEduBoardID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PIS_tblEmpEducationInfo] PRIMARY KEY CLUSTERED 
(
	[GEmpEducationInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblEmployeeGenInfo]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblEmployeeGenInfo](
	[GEmployeeGenInfoID] [uniqueidentifier] NOT NULL,
	[GCompanyGenInfoID] [uniqueidentifier] NULL,
	[GFactoryID] [uniqueidentifier] NULL,
	[GDesignationInfoID] [uniqueidentifier] NULL,
	[GLocationID] [uniqueidentifier] NULL,
	[GDepartmentID] [uniqueidentifier] NULL,
	[GEmployeeCatID] [uniqueidentifier] NULL,
	[StrEmpID] [varchar](12) NULL,
	[StrEmpCardNo] [varchar](20) NULL,
	[StrEmpOldCardNo] [varchar](20) NULL,
	[StrEmpOwnLanguageID] [varchar](10) NULL,
	[StrEmpName] [varchar](200) NULL,
	[StrEmpNameOwnLanguage] [nvarchar](200) NULL,
	[intGender] [int] NULL,
	[bitSystemUser] [bit] NULL,
	[GReligionID] [uniqueidentifier] NULL,
	[intMaritalStatus] [int] NULL,
	[dtBirthDate] [datetime] NOT NULL,
	[dtJoiningDate] [datetime] NOT NULL,
	[StrFatherName] [varchar](100) NULL,
	[StrMotherName] [varchar](100) NULL,
	[StrCurrentAddress] [varchar](250) NULL,
	[StrCurrAddrVillageMohalla] [varchar](100) NULL,
	[StrCurrAddrPostOfficeName] [varchar](100) NULL,
	[StrCurrAddrPostCode] [varchar](20) NULL,
	[GCurrAddrAreaInfoID] [uniqueidentifier] NULL,
	[GCurrAddrThanaUpazilaInfoID] [uniqueidentifier] NULL,
	[GCurrAddrDistrictInfoID] [uniqueidentifier] NULL,
	[StrPermanentAddress] [varchar](250) NULL,
	[StrPerAddrVillageMohalla] [varchar](100) NULL,
	[StrPerAddrPostofficeName] [varchar](100) NULL,
	[StrPerAddrPostCode] [varchar](20) NULL,
	[GPerAddrAreaInfoID] [uniqueidentifier] NULL,
	[GPerAddrThanaUpazilaInfoID] [uniqueidentifier] NULL,
	[GPerAddrDistrictInfoID] [uniqueidentifier] NULL,
	[StrEmpPssportNo] [varchar](50) NULL,
	[StrEmpNationalID] [varchar](20) NULL,
	[strEmpMobileNo] [varchar](20) NULL,
	[numEmpWeightKG] [numeric](6, 2) NULL,
	[StrEmpIdenMark] [varchar](100) NULL,
	[intLatePresentPunishmentFlag] [int] NULL,
	[GCreatedBy] [uniqueidentifier] NULL,
	[DtCreatedOn] [datetime] NULL,
	[GUpdatedBy] [uniqueidentifier] NULL,
	[DtUpdatedOn] [datetime] NULL,
	[strEmailAdress] [varchar](100) NULL,
	[DtConfirmationDate] [datetime] NULL,
	[DtResignRetireTerminationDate] [datetime] NULL,
	[strGrade] [varchar](50) NULL,
	[strShift] [varchar](50) NULL,
	[chkEligibleForOverTime] [bit] NULL,
	[strAlternatePhone] [varchar](50) NULL,
	[strTIN] [varchar](50) NULL,
	[strNationalIDCard] [varchar](80) NULL,
	[strAgeString] [varchar](80) NULL,
	[strFunctionalDesignation] [varchar](80) NULL,
	[strBloodGroup] [varchar](80) NULL,
	[GNationalityID] [uniqueidentifier] NULL,
	[bitCarryForwardProcessForDataUpdate] [bit] NULL,
	[bitHeadOffice] [bit] NULL,
	[bitIsRoaster] [bit] NULL,
	[bitEligibleForVistaGLAccount] [bit] NULL,
	[intActiveStatus] [int] NULL,
	[DivisionID] [uniqueidentifier] NULL,
	[FingerPrintNo] [varchar](50) NULL,
	[RelationWithAlternatePhoneOwner] [varchar](50) NULL,
	[ShiftID] [tinyint] NULL,
	[RosterGroupID] [uniqueidentifier] NULL,
	[GPaymentRuleSetupID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PIS_tblEmployeeGenInfo] PRIMARY KEY CLUSTERED 
(
	[GEmployeeGenInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblGender]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblGender](
	[Id] [int] NOT NULL,
	[GenderName] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblGender] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblGradeInfo]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblGradeInfo](
	[GGradeInfoID] [uniqueidentifier] NOT NULL,
	[GGradeTypeID] [uniqueidentifier] NULL,
	[StrGradeName] [varchar](20) NOT NULL,
	[StrGradeDesc] [varchar](250) NULL,
	[numMinimumSalary] [numeric](18, 2) NOT NULL,
	[numMaximumSalary] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_PIS_tblGradeInfo] PRIMARY KEY CLUSTERED 
(
	[GGradeInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblJobStatus]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblJobStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[JobStatus] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblJobStatus_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblMaritalStatus]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblMaritalStatus](
	[Id] [int] NOT NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_PIS_tblMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblReligion]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblReligion](
	[GReligionID] [uniqueidentifier] NOT NULL,
	[ReligionName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PIS_tblReligion] PRIMARY KEY CLUSTERED 
(
	[GReligionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblSection]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblSection](
	[SectionID] [uniqueidentifier] NOT NULL,
	[SectionName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PIS_tblSection] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIS_tblWorkTimeScheduleSetup]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIS_tblWorkTimeScheduleSetup](
	[GWorkTimeScheduleSetupID] [uniqueidentifier] NOT NULL,
	[intWorkScheduleShift] [int] NOT NULL,
	[strWorkTimeSchedule] [varchar](50) NOT NULL,
	[dtWorkStartTime] [datetime] NOT NULL,
	[dtWorkEndTime] [datetime] NOT NULL,
	[dtLunchMiddleBreakStartTime] [datetime] NOT NULL,
	[dtLunchMiddleBreakEndTime] [datetime] NOT NULL,
	[dtFirstTeaBreakStartTime] [datetime] NOT NULL,
	[dtFirstTeaBreakEndTime] [datetime] NOT NULL,
	[dtSecondTeaBreakStartTime] [datetime] NULL,
	[dtSecondTeaBreakEndTime] [datetime] NULL,
	[numTotalWorkingHours] [numeric](5, 2) NOT NULL,
	[intRecordStatus] [int] NOT NULL,
 CONSTRAINT [PK_PIS_tblWorkTimeScheduleSetup] PRIMARY KEY CLUSTERED 
(
	[GWorkTimeScheduleSetupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[POST]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[POST](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostName] [varchar](50) NULL,
	[ThanaId] [int] NULL,
	[DistrictId] [int] NULL,
	[PostCode] [varchar](50) NULL,
	[BanglaPostName] [nvarchar](200) NULL,
 CONSTRAINT [PK_POST] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PROGRAM]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PROGRAM](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NULL,
	[ProgramName] [varchar](50) NULL,
	[ProgramCode] [varchar](50) NULL,
	[BanglaProgram] [nvarchar](200) NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RELIGION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RELIGION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReligionName] [varchar](50) NULL,
	[BanglaReligion] [nvarchar](200) NULL,
 CONSTRAINT [PK_Religion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLEWISE_MENU]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROLEWISE_MENU](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MODULE_ID] [int] NULL,
	[USER_GROUP_ID] [bigint] NOT NULL,
	[PARENT_MENU_NAME] [varchar](50) NULL,
	[PARENT_MENU_CONTENT] [varchar](100) NULL,
	[CHILD_MENU_NAME] [varchar](50) NULL,
	[CHILD_MENU_CONTENT] [varchar](100) NULL,
 CONSTRAINT [PK_ROLEWISE_MENU] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROUTINEGROUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROUTINEGROUP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [varchar](50) NULL,
	[ProgramId] [int] NULL,
	[DepartmentId] [int] NULL,
	[SemesterId] [int] NULL,
 CONSTRAINT [PK_RUTINGROUP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SEMESTER]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SEMESTER](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SemesterNo] [varchar](50) NULL,
	[BanglaSemesterNo] [nvarchar](50) NULL,
 CONSTRAINT [PK_SEMESTER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SIPI_DEPARTMENT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SIPI_DEPARTMENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SIPI_ProgramId] [int] NULL,
	[SIPI_DepartmentName] [varchar](50) NULL,
	[SIPI_DepartmentCode] [varchar](50) NULL,
	[BanglaSIPI_Department] [nvarchar](200) NULL,
	[SIPI_DepartmentRegulation] [varchar](50) NULL,
	[SIPI_DepartmentEntryDate] [date] NULL,
 CONSTRAINT [PK_SIPI_DEPARTMENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SIPI_PROGRAM]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SIPI_PROGRAM](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SIPI_ProgramName] [varchar](50) NOT NULL,
	[SIPI_ProgramTime] [varchar](50) NULL,
	[BanglaSIPI_Program] [nvarchar](200) NULL,
 CONSTRAINT [PK_SIPI_PROGRAM] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STUDENT_ATTENDENCE]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STUDENT_ATTENDENCE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentPKId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CampusId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
	[Year] [int] NULL,
	[Date] [datetime] NOT NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_STUDENT_ATTENDENCE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STUDENT_CURRENT_SEMESTER_STATUS]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENT_CURRENT_SEMESTER_STATUS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentPKId] [int] NULL,
	[CurrentSemesterId] [int] NULL,
 CONSTRAINT [PK_STUDENT_CURRENT_SEMESTER_STATUS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STUDENT_RESULT]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENT_RESULT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentPKId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
	[YearId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[TheoryMarksConAssess] [decimal](18, 0) NULL,
	[TheoryMarksFinalExam] [decimal](18, 0) NULL,
	[PracticalMarksConAssess] [decimal](18, 0) NULL,
	[PracticalMarksFinalExam] [decimal](18, 0) NULL,
	[TotalMarks] [decimal](18, 0) NULL,
 CONSTRAINT [PK_STUDENT_RESULT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STUDENTFEES]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STUDENTFEES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
	[Year] [int] NULL,
	[FeesDetailsId] [int] NULL,
	[Amount] [int] NULL,
	[Total] [int] NULL,
	[StudentPkId] [int] NULL,
	[DiscountAmount] [int] NULL,
	[DiscountPercent] [int] NULL,
	[TotalPayableAmount] [int] NULL,
	[PaidAmount] [int] NULL,
	[DueAmount] [int] NULL,
	[PaidStatus] [varchar](50) NULL,
 CONSTRAINT [PK_STUDENTFEES] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STUDENTFEESCOLLECTION]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENTFEESCOLLECTION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentPKId] [int] NULL,
	[SemesterId] [int] NULL,
	[Year] [int] NULL,
	[ReceiveableAmount] [int] NULL,
	[ReceiveAmount] [int] NULL,
	[DueAmount] [int] NULL,
	[ReceiveDate] [datetime] NULL,
 CONSTRAINT [PK_STUDENTFEESCOLLECTION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCfgCommon]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCfgCommon](
	[GCfgCommonID] [uniqueidentifier] NOT NULL,
	[GCfgCommonTypeID] [uniqueidentifier] NOT NULL,
	[intSlNo] [int] NOT NULL,
	[StrName] [varchar](200) NOT NULL,
	[StrDescription] [varchar](250) NULL,
	[IntIncrementalPK] [int] NOT NULL,
 CONSTRAINT [PK_tblCfgCommon] PRIMARY KEY CLUSTERED 
(
	[GCfgCommonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCfgCommonType]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCfgCommonType](
	[GCfgCommonTypeID] [uniqueidentifier] NOT NULL,
	[intSLNo] [int] NOT NULL,
	[strModuleName] [varchar](50) NULL,
	[strType] [varchar](50) NULL,
 CONSTRAINT [PK_tblCfgCommonType] PRIMARY KEY CLUSTERED 
(
	[GCfgCommonTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFactory]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFactory](
	[GFactoryID] [uniqueidentifier] NOT NULL,
	[intFactoryID] [tinyint] NULL,
	[GCommonIDFactoryType] [uniqueidentifier] NOT NULL,
	[StrFactoryName] [varchar](100) NOT NULL,
	[StrFactoryShortName] [varchar](20) NOT NULL,
	[StrAddress] [varchar](250) NOT NULL,
	[StrDistrict] [varchar](50) NOT NULL,
	[StrCountry] [varchar](50) NOT NULL,
	[StrTelephone] [varchar](50) NOT NULL,
	[StrEmail] [varchar](50) NOT NULL,
	[StrFax] [varchar](50) NOT NULL,
	[StrRemark] [varchar](250) NOT NULL,
	[BitStatus] [bit] NOT NULL,
	[SealWithSignature] [image] NULL,
	[GCreatedBy] [varchar](100) NOT NULL,
	[DtCreatedOn] [datetime] NOT NULL,
	[GUpdatedBy] [varchar](100) NOT NULL,
	[DtUpdatedOn] [datetime] NOT NULL,
	[FactoryNameOwnLanguage] [nvarchar](500) NULL,
	[FactoryAddressOwnLanguage] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tblFactory] PRIMARY KEY CLUSTERED 
(
	[GFactoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TEACHER]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TEACHER](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherName] [varchar](50) NULL,
	[DepartmentId] [int] NULL,
	[CampusId] [int] NULL,
 CONSTRAINT [PK_TEACHER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test_district]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test_district](
	[Id] [int] NOT NULL,
	[DistrictName] [varchar](50) NULL,
	[BanglaDistrict] [nvarchar](200) NULL,
 CONSTRAINT [PK_test_district] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[THANA]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[THANA](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ThanaName] [varchar](50) NULL,
	[DistrictId] [int] NULL,
	[BanglaThanaName] [nvarchar](200) NULL,
 CONSTRAINT [PK_THANA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER](
	[USER_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[USER_NAME] [varchar](50) NULL,
	[USER_PASSWORD] [varchar](50) NULL,
	[USER_GROUP_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[USER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER_GROUP]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER_GROUP](
	[GROUP_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[GROUP_NAME] [varchar](50) NULL,
 CONSTRAINT [PK_USER_GROUP] PRIMARY KEY CLUSTERED 
(
	[GROUP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[YEAR]    Script Date: 07-Mar-15 12:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YEAR](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
 CONSTRAINT [PK_YEAR] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[LMS_tblCompany] ADD  CONSTRAINT [DF_LMS_tblCompany_dtIDate]  DEFAULT (getdate()) FOR [dtIDate]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_GEmployeeGenInfoID]  DEFAULT (newid()) FOR [GEmployeeGenInfoID]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_bitSystemUser]  DEFAULT ((0)) FOR [bitSystemUser]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_intLatePresentPunishmentFlag]  DEFAULT ((0)) FOR [intLatePresentPunishmentFlag]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_chkEligibleForOverTime]  DEFAULT ((0)) FOR [chkEligibleForOverTime]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_bitCarryForwardProcessForDataUpdate]  DEFAULT ((0)) FOR [bitCarryForwardProcessForDataUpdate]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_bitIsRoaster]  DEFAULT ((0)) FOR [bitIsRoaster]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_bitEligibleForVistaGLAccount]  DEFAULT ((0)) FOR [bitEligibleForVistaGLAccount]
GO
ALTER TABLE [dbo].[PIS_EMPLOYEE_INFO] ADD  CONSTRAINT [DF_EMPLOYEE_INFO_intActiveStatus]  DEFAULT ((1)) FOR [intActiveStatus]
GO
ALTER TABLE [dbo].[PIS_tblCategoryEmp] ADD  CONSTRAINT [DF_PIS_tblCategoryEmp_CategoryTypeID]  DEFAULT ((2)) FOR [CategoryTypeID]
GO
ALTER TABLE [dbo].[PIS_tblDistrictInfo] ADD  CONSTRAINT [DF_PIS_tblDistrictInfo_GDistrictInfoID]  DEFAULT (newid()) FOR [GDistrictInfoID]
GO
ALTER TABLE [dbo].[PIS_tblEmpAssignment] ADD  CONSTRAINT [DF_PIS_tblEmpAssignment_GEmpAssignID]  DEFAULT (newid()) FOR [GEmpAssignID]
GO
ALTER TABLE [dbo].[PIS_tblEmpEducationInfo] ADD  CONSTRAINT [DF_PIS_tblEmpEducationInfo_GEmpEducationInfoID]  DEFAULT (newid()) FOR [GEmpEducationInfoID]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_GEmployeeGenInfoID]  DEFAULT (newid()) FOR [GEmployeeGenInfoID]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_bitSystemUser]  DEFAULT ((0)) FOR [bitSystemUser]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_intLatePresentPunishmentFlag]  DEFAULT ((0)) FOR [intLatePresentPunishmentFlag]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_chkEligibleForOverTime]  DEFAULT ((0)) FOR [chkEligibleForOverTime]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_bitCarryForwardProcessForDataUpdate]  DEFAULT ((0)) FOR [bitCarryForwardProcessForDataUpdate]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_bitIsRoaster]  DEFAULT ((0)) FOR [bitIsRoaster]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_bitEligibleForVistaGLAccount]  DEFAULT ((0)) FOR [bitEligibleForVistaGLAccount]
GO
ALTER TABLE [dbo].[PIS_tblEmployeeGenInfo] ADD  CONSTRAINT [DF_PIS_tblEmployeeGenInfo_intActiveStatus]  DEFAULT ((1)) FOR [intActiveStatus]
GO
ALTER TABLE [dbo].[PIS_tblGradeInfo] ADD  CONSTRAINT [DF_PIS_tblGradeInfo_GGradeInfoID]  DEFAULT (newid()) FOR [GGradeInfoID]
GO
ALTER TABLE [dbo].[PIS_tblGradeInfo] ADD  CONSTRAINT [DF_PIS_tblGradeInfo_numMinimumSalary]  DEFAULT ((0)) FOR [numMinimumSalary]
GO
ALTER TABLE [dbo].[PIS_tblGradeInfo] ADD  CONSTRAINT [DF_PIS_tblGradeInfo_numMaximumSalary]  DEFAULT ((0)) FOR [numMaximumSalary]
GO
ALTER TABLE [dbo].[PIS_tblWorkTimeScheduleSetup] ADD  CONSTRAINT [DF_PIS_tblWorkTimeScheduleSetup_GWorkTimeScheduleSetupID]  DEFAULT (newid()) FOR [GWorkTimeScheduleSetupID]
GO
ALTER TABLE [dbo].[PIS_tblWorkTimeScheduleSetup] ADD  CONSTRAINT [DF_PIS_tblWorkTimeScheduleSetup_numTotalWorkingHours]  DEFAULT ((0)) FOR [numTotalWorkingHours]
GO
ALTER TABLE [dbo].[PIS_tblWorkTimeScheduleSetup] ADD  CONSTRAINT [DF_PIS_tblWorkTimeScheduleSetup_intRecordStatus]  DEFAULT ((1)) FOR [intRecordStatus]
GO
ALTER TABLE [dbo].[tblCfgCommon] ADD  CONSTRAINT [DF_tblCfgCommon_GCfgCommonID]  DEFAULT (newid()) FOR [GCfgCommonID]
GO
ALTER TABLE [dbo].[tblCfgCommonType] ADD  CONSTRAINT [DF_tblCfgCommonType_GCfgCommonTypeID]  DEFAULT (newid()) FOR [GCfgCommonTypeID]
GO
ALTER TABLE [dbo].[tblFactory] ADD  CONSTRAINT [DF_tblFactory_GFactoryID]  DEFAULT (newid()) FOR [GFactoryID]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_BATCH] FOREIGN KEY([BatchId])
REFERENCES [dbo].[BATCH] ([ID])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_BATCH]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_CAMPUSINFO] FOREIGN KEY([CampusId])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_CAMPUSINFO]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_CAMPUSINFO_CAMPUS] FOREIGN KEY([BanglaCampas])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_CAMPUSINFO_CAMPUS]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_GuardianDISTRICTDID] FOREIGN KEY([GuardianDistrictId])
REFERENCES [dbo].[DISTRICT] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_GuardianDISTRICTDID]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PermanentDISTRICTID] FOREIGN KEY([PermanentDistrictid])
REFERENCES [dbo].[DISTRICT] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PermanentDISTRICTID]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PermanentPostId] FOREIGN KEY([PermanentPostId])
REFERENCES [dbo].[POST] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PermanentPostId]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PermanentThanaId] FOREIGN KEY([PermanentThanaId])
REFERENCES [dbo].[THANA] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PermanentThanaId]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_POST] FOREIGN KEY([GuardianPostId])
REFERENCES [dbo].[POST] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_POST]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PresentDISTRICTId] FOREIGN KEY([PresentDistrictId])
REFERENCES [dbo].[DISTRICT] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PresentDISTRICTId]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PresentPostId] FOREIGN KEY([PresentPostId])
REFERENCES [dbo].[POST] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PresentPostId]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_PresentThanaId] FOREIGN KEY([PresentThanaId])
REFERENCES [dbo].[THANA] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_PresentThanaId]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_RELIGION] FOREIGN KEY([ReligionId])
REFERENCES [dbo].[RELIGION] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_RELIGION]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_SEMESTER] FOREIGN KEY([CurrentSemester])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_SEMESTER]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_SIPI_PROGRAM] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[SIPI_PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_SIPI_PROGRAM]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_SIPIDEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_SIPIDEPARTMENT]
GO
ALTER TABLE [dbo].[ADMISSIONINFO]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONINFO_THANA] FOREIGN KEY([GuardianThanaId])
REFERENCES [dbo].[THANA] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONINFO] CHECK CONSTRAINT [FK_ADMISSIONINFO_THANA]
GO
ALTER TABLE [dbo].[ADMISSIONOFFICE]  WITH CHECK ADD  CONSTRAINT [FK_ADMISSIONOFFICE_CAMPUSINFO] FOREIGN KEY([CampusId])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[ADMISSIONOFFICE] CHECK CONSTRAINT [FK_ADMISSIONOFFICE_CAMPUSINFO]
GO
ALTER TABLE [dbo].[BALANCE_SHEET_CONFIGURE]  WITH CHECK ADD  CONSTRAINT [FK_BALANCE_SHEET_CONFIGURE_CHART_ACCOUNT] FOREIGN KEY([ACCID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[BALANCE_SHEET_CONFIGURE] CHECK CONSTRAINT [FK_BALANCE_SHEET_CONFIGURE_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[BOOK_ISSUE]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_ISSUE_ADMISSIONINFO] FOREIGN KEY([StudentPKId])
REFERENCES [dbo].[ADMISSIONINFO] ([Id])
GO
ALTER TABLE [dbo].[BOOK_ISSUE] CHECK CONSTRAINT [FK_BOOK_ISSUE_ADMISSIONINFO]
GO
ALTER TABLE [dbo].[BOOK_ISSUE]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_ISSUE_BOOKS_DETAILS] FOREIGN KEY([BookId])
REFERENCES [dbo].[BOOKS_DETAILS] ([Id])
GO
ALTER TABLE [dbo].[BOOK_ISSUE] CHECK CONSTRAINT [FK_BOOK_ISSUE_BOOKS_DETAILS]
GO
ALTER TABLE [dbo].[BOOKS_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKS_DETAILS_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[BOOKS_DETAILS] CHECK CONSTRAINT [FK_BOOKS_DETAILS_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[BOOKS_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKS_DETAILS_SIPI_PROGRAM] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[SIPI_PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[BOOKS_DETAILS] CHECK CONSTRAINT [FK_BOOKS_DETAILS_SIPI_PROGRAM]
GO
ALTER TABLE [dbo].[COURSE]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_PROGRAM] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[SIPI_PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[COURSE] CHECK CONSTRAINT [FK_COURSE_PROGRAM]
GO
ALTER TABLE [dbo].[COURSE]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[COURSE] CHECK CONSTRAINT [FK_COURSE_SEMESTER]
GO
ALTER TABLE [dbo].[COURSE]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[COURSE] CHECK CONSTRAINT [FK_COURSE_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_ADMISSIONINFO] FOREIGN KEY([StudentPkId])
REFERENCES [dbo].[ADMISSIONINFO] ([Id])
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT] CHECK CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_ADMISSIONINFO]
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_COURSE] FOREIGN KEY([CourseId])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT] CHECK CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_COURSE]
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT] CHECK CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_SEMESTER]
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT]  WITH CHECK ADD  CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[COURSE_ASSIGN_TO_STUDENT] CHECK CONSTRAINT [FK_COURSE_ASSIGN_TO_STUDENT_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD] FOREIGN KEY([FirstClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD1] FOREIGN KEY([SecondClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD1]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD2] FOREIGN KEY([ThirdClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD2]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD3] FOREIGN KEY([ForthClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD3]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD4] FOREIGN KEY([FifthClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD4]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD5] FOREIGN KEY([SixthClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD5]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD6] FOREIGN KEY([SeventhClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD6]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD7] FOREIGN KEY([EighthClass])
REFERENCES [dbo].[CLASSPERIOD] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_CLASSPERIOD7]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE] FOREIGN KEY([FirstCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE1] FOREIGN KEY([SecondCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE1]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE2] FOREIGN KEY([ThirdCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE2]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE3] FOREIGN KEY([ForthCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE3]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE4] FOREIGN KEY([FifthCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE4]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE5] FOREIGN KEY([SixthCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE5]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE6] FOREIGN KEY([SeventhCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE6]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_COURSE7] FOREIGN KEY([EighthCourse])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_COURSE7]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_SEMESTER]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_SIPI_PROGRAM] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[SIPI_PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_SIPI_PROGRAM]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER] FOREIGN KEY([FirstTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER1] FOREIGN KEY([SecondTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER1]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER2] FOREIGN KEY([ThirdTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER2]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER3] FOREIGN KEY([ForthTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER3]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER4] FOREIGN KEY([FifthTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER4]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER5] FOREIGN KEY([SixthTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER5]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER6] FOREIGN KEY([SeventhTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER6]
GO
ALTER TABLE [dbo].[CREATE_ROUTINE]  WITH CHECK ADD  CONSTRAINT [FK_CREATE_ROUTINE_TEACHER7] FOREIGN KEY([EighthTeacher])
REFERENCES [dbo].[TEACHER] ([Id])
GO
ALTER TABLE [dbo].[CREATE_ROUTINE] CHECK CONSTRAINT [FK_CREATE_ROUTINE_TEACHER7]
GO
ALTER TABLE [dbo].[CUSTOMER_EMPLOYEE_SETUP]  WITH CHECK ADD  CONSTRAINT [FK_CUSTOMER_EMPLOYEE_SETUP_CHART_ACCOUNT] FOREIGN KEY([ACCOUNT_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[CUSTOMER_EMPLOYEE_SETUP] CHECK CONSTRAINT [FK_CUSTOMER_EMPLOYEE_SETUP_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[DEPOSIT_PAYMENT]  WITH CHECK ADD  CONSTRAINT [FK_DEPOSIT_PAYMENT_CHART_ACCOUNT] FOREIGN KEY([ACCOUNT_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[DEPOSIT_PAYMENT] CHECK CONSTRAINT [FK_DEPOSIT_PAYMENT_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[DEPRICIATION_SETUP]  WITH CHECK ADD  CONSTRAINT [FK_DEPRICIATION_SETUP_CHART_ACCOUNT] FOREIGN KEY([ACCOUNT_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[DEPRICIATION_SETUP] CHECK CONSTRAINT [FK_DEPRICIATION_SETUP_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[FEESSETUP]  WITH CHECK ADD  CONSTRAINT [FK_FEESSETUP_CAMPUSINFO] FOREIGN KEY([CampusId])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[FEESSETUP] CHECK CONSTRAINT [FK_FEESSETUP_CAMPUSINFO]
GO
ALTER TABLE [dbo].[FEESSETUP]  WITH CHECK ADD  CONSTRAINT [FK_FEESSETUP_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[FEESSETUP] CHECK CONSTRAINT [FK_FEESSETUP_SEMESTER]
GO
ALTER TABLE [dbo].[FEESSETUP]  WITH CHECK ADD  CONSTRAINT [FK_FEESSETUP_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[FEESSETUP] CHECK CONSTRAINT [FK_FEESSETUP_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[INCOME_SHEET_CONFIGURE]  WITH CHECK ADD  CONSTRAINT [FK_INCOME_SHEET_CONFIGURE_CHART_ACCOUNT] FOREIGN KEY([ACCID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[INCOME_SHEET_CONFIGURE] CHECK CONSTRAINT [FK_INCOME_SHEET_CONFIGURE_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[JOURNAL_VOUCHAR]  WITH CHECK ADD  CONSTRAINT [FK_JOURNAL_VOUCHAR_CHART_ACCOUNT] FOREIGN KEY([JV_ACCOUNT_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[JOURNAL_VOUCHAR] CHECK CONSTRAINT [FK_JOURNAL_VOUCHAR_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[MEMBER_ACC_TYPE]  WITH CHECK ADD  CONSTRAINT [FK_MEMBER_ACC_TYPE_CHART_ACCOUNT] FOREIGN KEY([MEMBER_ACCOUNT_TYPE_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[MEMBER_ACC_TYPE] CHECK CONSTRAINT [FK_MEMBER_ACC_TYPE_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[MEMBER_ASSIGN]  WITH CHECK ADD  CONSTRAINT [FK_MEMBER_ASSIGN_CHART_ACCOUNT] FOREIGN KEY([ACC_ID])
REFERENCES [dbo].[CHART_ACCOUNT] ([CHART_ACC_ID])
GO
ALTER TABLE [dbo].[MEMBER_ASSIGN] CHECK CONSTRAINT [FK_MEMBER_ASSIGN_CHART_ACCOUNT]
GO
ALTER TABLE [dbo].[MODULE_PERMISSION]  WITH CHECK ADD  CONSTRAINT [FK_MODULE_PERMISSION_USER_GROUP] FOREIGN KEY([USER_GROUP_ID])
REFERENCES [dbo].[USER_GROUP] ([GROUP_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MODULE_PERMISSION] CHECK CONSTRAINT [FK_MODULE_PERMISSION_USER_GROUP]
GO
ALTER TABLE [dbo].[POST]  WITH CHECK ADD  CONSTRAINT [FK_POST_DISTRICT] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DISTRICT] ([Id])
GO
ALTER TABLE [dbo].[POST] CHECK CONSTRAINT [FK_POST_DISTRICT]
GO
ALTER TABLE [dbo].[POST]  WITH CHECK ADD  CONSTRAINT [FK_POST_THANA] FOREIGN KEY([ThanaId])
REFERENCES [dbo].[THANA] ([Id])
GO
ALTER TABLE [dbo].[POST] CHECK CONSTRAINT [FK_POST_THANA]
GO
ALTER TABLE [dbo].[PROGRAM]  WITH CHECK ADD  CONSTRAINT [FK_PROGRAM_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[PROGRAM] CHECK CONSTRAINT [FK_PROGRAM_DEPARTMENT]
GO
ALTER TABLE [dbo].[ROLEWISE_MENU]  WITH CHECK ADD  CONSTRAINT [FK_ROLEWISE_MENU_MODULE_PERMISSION] FOREIGN KEY([MODULE_ID])
REFERENCES [dbo].[MODULE_PERMISSION] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ROLEWISE_MENU] CHECK CONSTRAINT [FK_ROLEWISE_MENU_MODULE_PERMISSION]
GO
ALTER TABLE [dbo].[ROLEWISE_MENU]  WITH CHECK ADD  CONSTRAINT [FK_ROLEWISE_MENU_USER_GROUP] FOREIGN KEY([USER_GROUP_ID])
REFERENCES [dbo].[USER_GROUP] ([GROUP_ID])
GO
ALTER TABLE [dbo].[ROLEWISE_MENU] CHECK CONSTRAINT [FK_ROLEWISE_MENU_USER_GROUP]
GO
ALTER TABLE [dbo].[ROUTINEGROUP]  WITH CHECK ADD  CONSTRAINT [FK_ROUTINEGROUP_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[ROUTINEGROUP] CHECK CONSTRAINT [FK_ROUTINEGROUP_DEPARTMENT]
GO
ALTER TABLE [dbo].[ROUTINEGROUP]  WITH CHECK ADD  CONSTRAINT [FK_ROUTINEGROUP_PROGRAM] FOREIGN KEY([ProgramId])
REFERENCES [dbo].[PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[ROUTINEGROUP] CHECK CONSTRAINT [FK_ROUTINEGROUP_PROGRAM]
GO
ALTER TABLE [dbo].[ROUTINEGROUP]  WITH CHECK ADD  CONSTRAINT [FK_ROUTINEGROUP_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[ROUTINEGROUP] CHECK CONSTRAINT [FK_ROUTINEGROUP_SEMESTER]
GO
ALTER TABLE [dbo].[SIPI_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [FK_SIPI_DEPARTMENT_SIPI_PROGRAM] FOREIGN KEY([SIPI_ProgramId])
REFERENCES [dbo].[SIPI_PROGRAM] ([Id])
GO
ALTER TABLE [dbo].[SIPI_DEPARTMENT] CHECK CONSTRAINT [FK_SIPI_DEPARTMENT_SIPI_PROGRAM]
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_ATTENDENCE_ADMISSIONINFO] FOREIGN KEY([StudentPKId])
REFERENCES [dbo].[ADMISSIONINFO] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE] CHECK CONSTRAINT [FK_STUDENT_ATTENDENCE_ADMISSIONINFO]
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_ATTENDENCE_CAMPUSINFO] FOREIGN KEY([CampusId])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE] CHECK CONSTRAINT [FK_STUDENT_ATTENDENCE_CAMPUSINFO]
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_ATTENDENCE_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE] CHECK CONSTRAINT [FK_STUDENT_ATTENDENCE_SEMESTER]
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_ATTENDENCE_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_ATTENDENCE] CHECK CONSTRAINT [FK_STUDENT_ATTENDENCE_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[STUDENT_CURRENT_SEMESTER_STATUS]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_CURRENT_SEMESTER_STATUS_STUDENT_CURRENT_SEMESTER_STATUS] FOREIGN KEY([CurrentSemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_CURRENT_SEMESTER_STATUS] CHECK CONSTRAINT [FK_STUDENT_CURRENT_SEMESTER_STATUS_STUDENT_CURRENT_SEMESTER_STATUS]
GO
ALTER TABLE [dbo].[STUDENT_RESULT]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_RESULT_ADMISSIONINFO] FOREIGN KEY([StudentPKId])
REFERENCES [dbo].[ADMISSIONINFO] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_RESULT] CHECK CONSTRAINT [FK_STUDENT_RESULT_ADMISSIONINFO]
GO
ALTER TABLE [dbo].[STUDENT_RESULT]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_RESULT_COURSE] FOREIGN KEY([CourseId])
REFERENCES [dbo].[COURSE] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_RESULT] CHECK CONSTRAINT [FK_STUDENT_RESULT_COURSE]
GO
ALTER TABLE [dbo].[STUDENT_RESULT]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_RESULT_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_RESULT] CHECK CONSTRAINT [FK_STUDENT_RESULT_SEMESTER]
GO
ALTER TABLE [dbo].[STUDENT_RESULT]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_RESULT_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[STUDENT_RESULT] CHECK CONSTRAINT [FK_STUDENT_RESULT_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[STUDENTFEES]  WITH CHECK ADD  CONSTRAINT [FK_STUDENTFEES_FEESDETAILS] FOREIGN KEY([FeesDetailsId])
REFERENCES [dbo].[FEESDETAILS] ([Id])
GO
ALTER TABLE [dbo].[STUDENTFEES] CHECK CONSTRAINT [FK_STUDENTFEES_FEESDETAILS]
GO
ALTER TABLE [dbo].[STUDENTFEESCOLLECTION]  WITH CHECK ADD  CONSTRAINT [FK_STUDENTFEESCOLLECTION_ADMISSIONINFO] FOREIGN KEY([StudentPKId])
REFERENCES [dbo].[ADMISSIONINFO] ([Id])
GO
ALTER TABLE [dbo].[STUDENTFEESCOLLECTION] CHECK CONSTRAINT [FK_STUDENTFEESCOLLECTION_ADMISSIONINFO]
GO
ALTER TABLE [dbo].[STUDENTFEESCOLLECTION]  WITH CHECK ADD  CONSTRAINT [FK_STUDENTFEESCOLLECTION_SEMESTER] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[SEMESTER] ([Id])
GO
ALTER TABLE [dbo].[STUDENTFEESCOLLECTION] CHECK CONSTRAINT [FK_STUDENTFEESCOLLECTION_SEMESTER]
GO
ALTER TABLE [dbo].[TEACHER]  WITH CHECK ADD  CONSTRAINT [FK_TEACHER_CAMPUSINFO] FOREIGN KEY([CampusId])
REFERENCES [dbo].[CAMPUSINFO] ([Id])
GO
ALTER TABLE [dbo].[TEACHER] CHECK CONSTRAINT [FK_TEACHER_CAMPUSINFO]
GO
ALTER TABLE [dbo].[TEACHER]  WITH CHECK ADD  CONSTRAINT [FK_TEACHER_SIPI_DEPARTMENT] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[SIPI_DEPARTMENT] ([Id])
GO
ALTER TABLE [dbo].[TEACHER] CHECK CONSTRAINT [FK_TEACHER_SIPI_DEPARTMENT]
GO
ALTER TABLE [dbo].[THANA]  WITH CHECK ADD  CONSTRAINT [FK_THANA_DISTRICT] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DISTRICT] ([Id])
GO
ALTER TABLE [dbo].[THANA] CHECK CONSTRAINT [FK_THANA_DISTRICT]
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD  CONSTRAINT [FK_USER_USER_GROUP] FOREIGN KEY([USER_GROUP_ID])
REFERENCES [dbo].[USER_GROUP] ([GROUP_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_USER_GROUP]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 for Worker 2 for Staff' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PIS_tblCategoryEmp', @level2type=N'COLUMN',@level2name=N'CategoryTypeID'
GO
