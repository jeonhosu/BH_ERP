using System;
using System.Collections.Generic;
using System.Text;

namespace HRMF0705
{
    class XLPrinting_3
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        //private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        //private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 8;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 67;  // 1page : 61, 2page : 122, 3page : 183 - 복사되어질 행의 범위

        private int mCopyColumnSTART = 1;    //복사되어  진 행 누적 수
        private int mCopyColumnEND = 45;     //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

        private string mSend_ORG = string.Empty;
        private string mPrint_COUNT = string.Empty;

        #endregion;

        #region ----- Property -----

        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        public string OpenFileNameExcel
        {
            set
            {
                mXLOpenFileName = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public XLPrinting_3(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface, InfoSummit.Win.ControlAdv.ISMessageAdapter pMessageAdapter)
        {
            mPrinting = new XL.XLPrint();
            mAppInterface = pAppInterface;
            mMessageAdapter = pMessageAdapter;
        }

        #endregion;

        #region ----- XL File Open -----

        public bool XLFileOpen()
        {
            bool IsOpen = false;

            try
            {
                IsOpen = mPrinting.XLOpenFile(mXLOpenFileName);
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
            }

            return IsOpen;
        }

        #endregion;

        #region ----- Dispose -----

        public void Dispose()
        {
            mPrinting.XLOpenFileClose();
            mPrinting.XLClose();
        }

        #endregion;

        #region ----- MaxIncrement Methods ----

        private int MaxIncrement(string pPathBase, string pSaveFileName)
        {
            int vMaxNumber = 0;
            System.IO.DirectoryInfo vFolder = new System.IO.DirectoryInfo(pPathBase);
            string vPattern = string.Format("{0}*", pSaveFileName);
            System.IO.FileInfo[] vFiles = vFolder.GetFiles(vPattern);

            foreach (System.IO.FileInfo vFile in vFiles)
            {
                string vFileNameExt = vFile.Name;
                int vCutStart = vFileNameExt.LastIndexOf(".");
                string vFileName = vFileNameExt.Substring(0, vCutStart);

                int vCutRight = 3;
                int vSkip = vFileName.Length - vCutRight;
                string vTextNumber = vFileName.Substring(vSkip, vCutRight);
                int vNumber = int.Parse(vTextNumber);

                if (vNumber > vMaxNumber)
                {
                    vMaxNumber = vNumber;
                }
            }

            return vMaxNumber;
        }

        #endregion;

        #region ----- Line SLIP Methods ----

        #region ----- Array Set ----
        private void SetArray(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_IN_EARNER_DED_TAX, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[157];
            pXLColumn = new int[157];

            pGDColumn[0]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("CORP_NAME");              // 법인명(상호)   
            pGDColumn[1]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("VAT_NUMBER");             // 사업자번호     
            pGDColumn[2]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("NAME");                   // 성명           
            pGDColumn[3]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("REPRE_NUM");              // 주민번호 
            //--------------------------------------------------------------------------------------------------------------
            pGDColumn[4]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_01");          // 지급연월
            pGDColumn[5]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_01");          // 급여액
            pGDColumn[6]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_01");        // 상여액         
            pGDColumn[7]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_01");     // 계    
         
            pGDColumn[8]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_02");          // 지급연월
            pGDColumn[9]   = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_02");          // 급여액
            pGDColumn[10]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_02");        // 상여액         
            pGDColumn[11]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_02");     // 계    
         
            pGDColumn[12]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_03");          // 지급연월
            pGDColumn[13]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_03");          // 급여액
            pGDColumn[14]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_03");        // 상여액         
            pGDColumn[15]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_03");     // 계  
           
            pGDColumn[16]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_04");          // 지급연월
            pGDColumn[17]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_04");          // 급여액
            pGDColumn[18]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_04");        // 상여액         
            pGDColumn[19]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_04");     // 계
             
            pGDColumn[20]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_05");          // 지급연월
            pGDColumn[21]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_05");          // 급여액
            pGDColumn[22]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_05");        // 상여액         
            pGDColumn[23]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_05");     // 계 
            
            pGDColumn[24]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_06");          // 지급연월
            pGDColumn[25]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_06");          // 급여액
            pGDColumn[26]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_06");        // 상여액         
            pGDColumn[27]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_06");     // 계
             
            pGDColumn[28]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_07");          // 지급연월
            pGDColumn[29]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_07");          // 급여액
            pGDColumn[30]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_07");        // 상여액         
            pGDColumn[31]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_07");     // 계
             
            pGDColumn[32]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_08");          // 지급연월
            pGDColumn[33]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_08");          // 급여액
            pGDColumn[34]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_08");        // 상여액         
            pGDColumn[35]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_08");     // 계
             
            pGDColumn[36]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_09");          // 지급연월
            pGDColumn[37]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_09");          // 급여액
            pGDColumn[38]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_09");        // 상여액         
            pGDColumn[39]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_09");     // 계
             
            pGDColumn[40]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_10");          // 지급연월
            pGDColumn[41]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_10");          // 급여액
            pGDColumn[42]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_10");        // 상여액         
            pGDColumn[43]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_10");     // 계
             
            pGDColumn[44]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_11");          // 지급연월
            pGDColumn[45]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_11");          // 급여액
            pGDColumn[46]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_11");        // 상여액         
            pGDColumn[47]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_11");     // 계    
         
            pGDColumn[48]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_12");          // 지급연월
            pGDColumn[49]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_AMOUNT_12");          // 급여액
            pGDColumn[50]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("BONUS_AMOUNT_12");        // 상여액         
            pGDColumn[51]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS_12");     // 계
             
            pGDColumn[52]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_AMOUNT");       // 총 급여액        
            pGDColumn[53]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_BONUS_AMOUNT");     // 총 상여액      
            pGDColumn[54]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_PAY_BONUS");        // 계
            //-------------------------------------------------------------------------------------------------------------- 
            pGDColumn[55]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_01");          // 지급연월       
            pGDColumn[56]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_01");         // 야간근로수당 등
            pGDColumn[57]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_01");        // 차량유류비
     
            pGDColumn[58]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_02");          // 지급연월       
            pGDColumn[59]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_02");         // 야간근로수당 등
            pGDColumn[60]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_02");        // 차량유류비   
  
            pGDColumn[61]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_03");          // 지급연월       
            pGDColumn[62]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_03");         // 야간근로수당 등
            pGDColumn[63]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_03");        // 차량유류비
     
            pGDColumn[64]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_04");          // 지급연월       
            pGDColumn[65]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_04");         // 야간근로수당 등
            pGDColumn[66]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_04");        // 차량유류비 
    
            pGDColumn[67]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_05");          // 지급연월       
            pGDColumn[68]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_05");         // 야간근로수당 등
            pGDColumn[69]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_05");        // 차량유류비 
    
            pGDColumn[70]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_06");          // 지급연월       
            pGDColumn[71]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_06");         // 야간근로수당 등
            pGDColumn[72]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_06");        // 차량유류비
      
            pGDColumn[73]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_07");          // 지급연월       
            pGDColumn[74]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_07");         // 야간근로수당 등
            pGDColumn[75]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_07");        // 차량유류비 
    
            pGDColumn[76]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_08");          // 지급연월       
            pGDColumn[77]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_08");         // 야간근로수당 등
            pGDColumn[78]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_08");        // 차량유류비 
    
            pGDColumn[79]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_09");          // 지급연월       
            pGDColumn[80]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_09");         // 야간근로수당 등
            pGDColumn[81]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_09");        // 차량유류비 
    
            pGDColumn[82]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_10");          // 지급연월       
            pGDColumn[83]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_10");         // 야간근로수당 등
            pGDColumn[84]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_10");        // 차량유류비 
    
            pGDColumn[85]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_11");          // 지급연월       
            pGDColumn[86]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_11");         // 야간근로수당 등
            pGDColumn[87]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_11");        // 차량유류비 
    
            pGDColumn[88]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PAY_YYYYMM_12");          // 지급연월       
            pGDColumn[89]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_OT_12");         // 야간근로수당 등
            pGDColumn[90]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TAX_FREE_ETC_12");        // 차량유류비  
            //--------------------------------------------------------------------------------------------------------------
            pGDColumn[91]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_01");     // 소득세         
            pGDColumn[92]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_01");  // 주민세         
            pGDColumn[93]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_01");      // 연금보험       
            pGDColumn[94]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_01");       // 건강보험       
            pGDColumn[95]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_01");          // 고용보험       
            pGDColumn[96]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_02");     // 소득세         
            pGDColumn[97]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_02");  // 주민세         
            pGDColumn[98]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_02");      // 연금보험       
            pGDColumn[99]  = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_02");       // 건강보험       
            pGDColumn[100] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_02");          // 고용보험       
            pGDColumn[101] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_03");     // 소득세         
            pGDColumn[102] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_03");  // 주민세          
            pGDColumn[103] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_03");      // 연금보험       
            pGDColumn[104] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_03");       // 건강보험       
            pGDColumn[105] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_03");          // 고용보험       
            pGDColumn[106] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_04");     // 소득세         
            pGDColumn[107] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_04");  // 주민세         
            pGDColumn[108] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_04");      // 연금보험       
            pGDColumn[109] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_04");       // 건강보험       
            pGDColumn[110] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_04");          // 고용보험       
            pGDColumn[111] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_05");     // 소득세         
            pGDColumn[112] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_05");  // 주민세         
            pGDColumn[113] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_05");      // 연금보험       
            pGDColumn[114] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_05");       // 건강보험       
            pGDColumn[115] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_05");          // 고용보험       
            pGDColumn[116] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_06");     // 소득세         
            pGDColumn[117] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_06");  // 주민세         
            pGDColumn[118] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_06");      // 연금보험       
            pGDColumn[119] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_06");       // 건강보험       
            pGDColumn[120] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_06");          // 고용보험       
            pGDColumn[121] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_07");     // 소득세         
            pGDColumn[122] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_07");  // 주민세         
            pGDColumn[123] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_07");      // 연금보험       
            pGDColumn[124] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_07");       // 건강보험       
            pGDColumn[125] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_07");          // 고용보험       
            pGDColumn[126] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_08");     // 소득세         
            pGDColumn[127] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_08");  // 주민세         
            pGDColumn[128] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_08");      // 연금보험       
            pGDColumn[129] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_08");       // 건강보험       
            pGDColumn[130] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_08");          // 고용보험       
            pGDColumn[131] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_09");     // 소득세         
            pGDColumn[132] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_09");  // 주민세         
            pGDColumn[133] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_09");      // 연금보험       
            pGDColumn[134] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_09");       // 건강보험       
            pGDColumn[135] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_09");          // 고용보험       
            pGDColumn[136] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_10");     // 소득세         
            pGDColumn[137] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_10");  // 주민세         
            pGDColumn[138] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_10");      // 연금보험       
            pGDColumn[139] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_10");       // 건강보험       
            pGDColumn[140] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_10");          // 고용보험       
            pGDColumn[141] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_11");     // 소득세         
            pGDColumn[142] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_11");  // 주민세         
            pGDColumn[143] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_11");      // 연금보험       
            pGDColumn[144] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_11");       // 건강보험       
            pGDColumn[145] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_11");          // 고용보험       
            pGDColumn[146] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT_12");     // 소득세         
            pGDColumn[147] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT_12");  // 주민세         
            pGDColumn[148] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("ANNUITY_IN_AMT_12");      // 연금보험       
            pGDColumn[149] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("HEALTH_IN_AMT_12");       // 건강보험       
            pGDColumn[150] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("UMP_IN_AMT_12");          // 고용보험
            pGDColumn[151] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_SUBT_IN_TAX_AMT");   // 소득세 계         
            pGDColumn[152] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_SUBT_LOCAL_TAX_AMT");// 주민세 계         
            pGDColumn[153] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_ANNUITY_IN_AMT");    // 연금보험 계       
            pGDColumn[154] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_HEALTH_IN_AMT");     // 건강보험 계       
            pGDColumn[155] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("TOTAL_UMP_IN_AMT");        // 고용보험 계  
            pGDColumn[156] = pGrid_IN_EARNER_DED_TAX.GetColumnToIndex("PRINT_DATE");              // 출력날짜 


            pXLColumn[0] = 18; // 법인명(상호)      
            pXLColumn[1] = 18; // 사업자번호        
            pXLColumn[2]   =  18; // 성명              
            pXLColumn[3]   =  30; // 주민번호 
            //-----------------------------------------
            pXLColumn[4]   =   4; // 지급연월(1월)          
            pXLColumn[5]   =   8; // 급여액            
            pXLColumn[6]   =  12; // 상여액            
            pXLColumn[7]   =  36; // 계                
            pXLColumn[8]   =   4; // 지급연월(2월)          
            pXLColumn[9]   =   8; // 급여액            
            pXLColumn[10]  =  12; // 상여액            
            pXLColumn[11]  =  36; // 계                
            pXLColumn[12]  =   4; // 지급연월(3월)          
            pXLColumn[13]  =   8; // 급여액            
            pXLColumn[14]  =  12; // 상여액            
            pXLColumn[15]  =  36; // 계                
            pXLColumn[16]  =   4; // 지급연월(4월)          
            pXLColumn[17]  =   8; // 급여액            
            pXLColumn[18]  =  12; // 상여액            
            pXLColumn[19]  =  36; // 계                
            pXLColumn[20]  =   4; // 지급연월(5월)          
            pXLColumn[21]  =   8; // 급여액            
            pXLColumn[22]  =  12; // 상여액            
            pXLColumn[23]  =  36; // 계                
            pXLColumn[24]  =   4; // 지급연월(6월)          
            pXLColumn[25]  =   8; // 급여액            
            pXLColumn[26]  =  12; // 상여액            
            pXLColumn[27]  =  36; // 계                
            pXLColumn[28]  =   4; // 지급연월(7월)          
            pXLColumn[29]  =   8; // 급여액            
            pXLColumn[30]  =  12; // 상여액            
            pXLColumn[31]  =  36; // 계                
            pXLColumn[32]  =   4; // 지급연월(8월)          
            pXLColumn[33]  =   8; // 급여액            
            pXLColumn[34]  =  12; // 상여액            
            pXLColumn[35]  =  36; // 계                
            pXLColumn[36]  =   4; // 지급연월(9월)          
            pXLColumn[37]  =   8; // 급여액            
            pXLColumn[38]  =  12; // 상여액            
            pXLColumn[39]  =  36; // 계                
            pXLColumn[40]  =   4; // 지급연월(10월)          
            pXLColumn[41]  =   8; // 급여액            
            pXLColumn[42]  =  12; // 상여액            
            pXLColumn[43]  =  36; // 계                
            pXLColumn[44]  =   4; // 지급연월(11월)          
            pXLColumn[45]  =   8; // 급여액            
            pXLColumn[46]  =  12; // 상여액            
            pXLColumn[47]  =  36; // 계                
            pXLColumn[48]  =   4; // 지급연월(12월)          
            pXLColumn[49]  =   8; // 급여액            
            pXLColumn[50]  =  12; // 상여액            
            pXLColumn[51]  =  36; // 계                
            pXLColumn[52]  =   8; // 총 급여액         
            pXLColumn[53]  =  12; // 총 상여액         
            pXLColumn[54]  =  36; // 계 
            //-----------------------------------------   
            pXLColumn[55]  =   4; // 지급연월(1월)          
            pXLColumn[56]  =  16; // 야간근로수당 등   
            pXLColumn[57]  =  36; // 차량유류비        
            pXLColumn[58]  =   4; // 지급연월(2월)          
            pXLColumn[59]  =  16; // 야간근로수당 등   
            pXLColumn[60]  =  36; // 차량유류비        
            pXLColumn[61]  =   4; // 지급연월(3월)          
            pXLColumn[62]  =  16; // 야간근로수당 등   
            pXLColumn[63]  =  36; // 차량유류비        
            pXLColumn[64]  =   4; // 지급연월(4월)          
            pXLColumn[65]  =  16; // 야간근로수당 등   
            pXLColumn[66]  =  36; // 차량유류비        
            pXLColumn[67]  =   4; // 지급연월(5월)          
            pXLColumn[68]  =  16; // 야간근로수당 등   
            pXLColumn[69]  =  36; // 차량유류비        
            pXLColumn[70]  =   4; // 지급연월(6월)          
            pXLColumn[71]  =  16; // 야간근로수당 등   
            pXLColumn[72]  =  36; // 차량유류비        
            pXLColumn[73]  =   4; // 지급연월(7월)          
            pXLColumn[74]  =  16; // 야간근로수당 등   
            pXLColumn[75]  =  36; // 차량유류비        
            pXLColumn[76]  =   4; // 지급연월(8월)          
            pXLColumn[77]  =  16; // 야간근로수당 등   
            pXLColumn[78]  =  36; // 차량유류비        
            pXLColumn[79]  =   4; // 지급연월(9월)          
            pXLColumn[80]  =  16; // 야간근로수당 등   
            pXLColumn[81]  =  36; // 차량유류비        
            pXLColumn[82]  =   4; // 지급연월(10월)          
            pXLColumn[83]  =  16; // 야간근로수당 등   
            pXLColumn[84]  =  36; // 차량유류비        
            pXLColumn[85]  =   4; // 지급연월(11월)          
            pXLColumn[86]  =  16; // 야간근로수당 등   
            pXLColumn[87]  =  36; // 차량유류비        
            pXLColumn[88]  =   4; // 지급연월(12월)          
            pXLColumn[89]  =  16; // 야간근로수당 등   
            pXLColumn[90]  =  36; // 차량유류비 
            //-----------------------------------------
            pXLColumn[91]  =   9; // 소득세(1월)            
            pXLColumn[92]  =  14; // 주민세            
            pXLColumn[93]  =  25; // 연금보험          
            pXLColumn[94]  =  29; // 건강보험          
            pXLColumn[95]  =  33; // 고용보험          
            pXLColumn[96]  =   9; // 소득세(2월)            
            pXLColumn[97]  =  14; // 주민세            
            pXLColumn[98]  =  25; // 연금보험          
            pXLColumn[99]  =  29; // 건강보험          
            pXLColumn[100] =  33; // 고용보험          
            pXLColumn[101] =   9; // 소득세(3월)
            pXLColumn[102] =  14; // 주민세            
            pXLColumn[103] =  25; // 연금보험          
            pXLColumn[104] =  29; // 건강보험          
            pXLColumn[105] =  33; // 고용보험          
            pXLColumn[106] =   9; // 소득세(4월)            
            pXLColumn[107] =  14; // 주민세            
            pXLColumn[108] =  25; // 연금보험          
            pXLColumn[109] =  29; // 건강보험          
            pXLColumn[110] =  33; // 고용보험          
            pXLColumn[111] =   9; // 소득세(5월)            
            pXLColumn[112] =  14; // 주민세            
            pXLColumn[113] =  25; // 연금보험          
            pXLColumn[114] =  29; // 건강보험          
            pXLColumn[115] =  33; // 고용보험          
            pXLColumn[116] =   9; // 소득세(6월)            
            pXLColumn[117] =  14; // 주민세            
            pXLColumn[118] =  25; // 연금보험          
            pXLColumn[119] =  29; // 건강보험          
            pXLColumn[120] =  33; // 고용보험          
            pXLColumn[121] =   9; // 소득세(7월)            
            pXLColumn[122] =  14; // 주민세            
            pXLColumn[123] =  25; // 연금보험          
            pXLColumn[124] =  29; // 건강보험          
            pXLColumn[125] =  33; // 고용보험          
            pXLColumn[126] =   9; // 소득세(8월)            
            pXLColumn[127] =  14; // 주민세            
            pXLColumn[128] =  25; // 연금보험          
            pXLColumn[129] =  29; // 건강보험          
            pXLColumn[130] =  33; // 고용보험          
            pXLColumn[131] =   9; // 소득세(9월)            
            pXLColumn[132] =  14; // 주민세            
            pXLColumn[133] =  25; // 연금보험          
            pXLColumn[134] =  29; // 건강보험          
            pXLColumn[135] =  33; // 고용보험          
            pXLColumn[136] =   9; // 소득세(10월)            
            pXLColumn[137] =  14; // 주민세            
            pXLColumn[138] =  25; // 연금보험          
            pXLColumn[139] =  29; // 건강보험          
            pXLColumn[140] =  33; // 고용보험          
            pXLColumn[141] =   9; // 소득세(11월)            
            pXLColumn[142] =  14; // 주민세            
            pXLColumn[143] =  25; // 연금보험          
            pXLColumn[144] =  29; // 건강보험          
            pXLColumn[145] =  33; // 고용보험          
            pXLColumn[146] =   9; // 소득세(12월)           
            pXLColumn[147] =  14; // 주민세           
            pXLColumn[148] =  25; // 연금보험         
            pXLColumn[149] =  29; // 건강보험         
            pXLColumn[150] =  33; // 고용보험
            pXLColumn[151] =   9; // 소득세 계          
            pXLColumn[152] =  14; // 주민세 계         
            pXLColumn[153] =  25; // 연금보험 계        
            pXLColumn[154] =  29; // 건강보험 계         
            pXLColumn[155] =  33; // 고용보험 계
            pXLColumn[156] =  13;  // 출력날짜
        }

        #endregion;

        #region ----- Convert String Method ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mAppInterface.OnAppMessageEvent(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;

        #region ----- IsConvert Methods -----

        private bool IsConvertString(object pObject, out string pConvertString)
        {
            bool vIsConvert = false;
            pConvertString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is string;
                    if (vIsConvert == true)
                    {
                        pConvertString = pObject as string;
                    }
                }

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vIsConvert;
        }

        private bool IsConvertNumber(object pObject, out decimal pConvertDecimal)
        {
            bool vIsConvert = false;
            pConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        pConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vIsConvert;
        }

        private bool IsConvertDate(object pObject, out System.DateTime pConvertDateTimeShort)
        {
            bool vIsConvert = false;
            pConvertDateTimeShort = new System.DateTime();

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is System.DateTime;
                    if (vIsConvert == true)
                    {
                        System.DateTime vDateTime = (System.DateTime)pObject;
                        pConvertDateTimeShort = vDateTime;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vIsConvert;
        }

        #endregion;


        #endregion;

        #region ----- Line Write Method -----       

        #region -----XLLINE -----

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGridPRINT_INCOME_TAX, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, string pCourse)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;            
            bool IsConvert = false;

            //-----------------------------------------------------------
            // 비과세 소득 중 '야간근로수당'의 계산식을 위해 선언된 변수
            //-----------------------------------------------------------
            decimal v1Month  = 0m;
            decimal v2Month  = 0m;
            decimal v3Month  = 0m;
            decimal v4Month  = 0m;
            decimal v5Month  = 0m;
            decimal v6Month  = 0m;
            decimal v7Month  = 0m;
            decimal v8Month  = 0m;
            decimal v9Month  = 0m;
            decimal v10Month = 0m;
            decimal v11Month = 0m;
            decimal v12Month = 0m;

            bool vOverValueCheck = false;
            //-----------------------------------------------------------
            // 비과세 소득 중 '차량유류비'의 계산식을 위해 선언된 변수
            //-----------------------------------------------------------
            decimal v1MonthCar  = 0m;
            decimal v2MonthCar  = 0m;
            decimal v3MonthCar  = 0m;
            decimal v4MonthCar  = 0m;
            decimal v5MonthCar  = 0m;
            decimal v6MonthCar  = 0m;
            decimal v7MonthCar  = 0m;
            decimal v8MonthCar  = 0m;
            decimal v9MonthCar  = 0m;
            decimal v10MonthCar = 0m;
            decimal v11MonthCar = 0m;
            decimal v12MonthCar = 0m;
            //----------------------------------------------------------
            decimal vTotalMonth = 0;
            decimal vTotalMonthCar = 0;
            decimal vTotalValue = 0;
            //----------------------------------------------------------

            try
            {
                mPrinting.XLActiveSheet("Destination");

                // 법인명(상호)
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 사업자등록번호
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 성명
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민등록번호
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 7;
                //-------------------------------------------------------------------

                //---------------------------- 근로소득지급명세 --------------------------------//
                // 지급연월(1월)
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(2월)
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(3월)
                vGDColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(4월)
                vGDColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[17];
                vXLColumnIndex = pXLColumn[17];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[18];
                vXLColumnIndex = pXLColumn[18];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[19];
                vXLColumnIndex = pXLColumn[19];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(5월)
                vGDColumnIndex = pGDColumn[20];
                vXLColumnIndex = pXLColumn[20];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[21];
                vXLColumnIndex = pXLColumn[21];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[22];
                vXLColumnIndex = pXLColumn[22];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[23];
                vXLColumnIndex = pXLColumn[23];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(6월)
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[25];
                vXLColumnIndex = pXLColumn[25];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[26];
                vXLColumnIndex = pXLColumn[26];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[27];
                vXLColumnIndex = pXLColumn[27];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(7월)
                vGDColumnIndex = pGDColumn[28];
                vXLColumnIndex = pXLColumn[28];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[29];
                vXLColumnIndex = pXLColumn[29];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[30];
                vXLColumnIndex = pXLColumn[30];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[31];
                vXLColumnIndex = pXLColumn[31];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(8월)
                vGDColumnIndex = pGDColumn[32];
                vXLColumnIndex = pXLColumn[32];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[33];
                vXLColumnIndex = pXLColumn[33];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[34];
                vXLColumnIndex = pXLColumn[34];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[35];
                vXLColumnIndex = pXLColumn[35];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(9월)
                vGDColumnIndex = pGDColumn[36];
                vXLColumnIndex = pXLColumn[36];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[37];
                vXLColumnIndex = pXLColumn[37];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[38];
                vXLColumnIndex = pXLColumn[38];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[39];
                vXLColumnIndex = pXLColumn[39];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(10월)
                vGDColumnIndex = pGDColumn[40];
                vXLColumnIndex = pXLColumn[40];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[41];
                vXLColumnIndex = pXLColumn[41];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[42];
                vXLColumnIndex = pXLColumn[42];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[43];
                vXLColumnIndex = pXLColumn[43];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(11월)
                vGDColumnIndex = pGDColumn[44];
                vXLColumnIndex = pXLColumn[44];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[45];
                vXLColumnIndex = pXLColumn[45];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[46];
                vXLColumnIndex = pXLColumn[46];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[47];
                vXLColumnIndex = pXLColumn[47];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급연월(12월)
                vGDColumnIndex = pGDColumn[48];
                vXLColumnIndex = pXLColumn[48];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 급여액
                vGDColumnIndex = pGDColumn[49];
                vXLColumnIndex = pXLColumn[49];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액
                vGDColumnIndex = pGDColumn[50];
                vXLColumnIndex = pXLColumn[50];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[51];
                vXLColumnIndex = pXLColumn[51];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 급여액 계
                vGDColumnIndex = pGDColumn[52];
                vXLColumnIndex = pXLColumn[52];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 상여액 계
                vGDColumnIndex = pGDColumn[53];
                vXLColumnIndex = pXLColumn[53];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계
                vGDColumnIndex = pGDColumn[54];
                vXLColumnIndex = pXLColumn[54];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 6;
                //-------------------------------------------------------------------

                //---------------------------- 비과세 소득 --------------------------
                // 지급연월(1월)
                vGDColumnIndex = pGDColumn[55];
                vXLColumnIndex = pXLColumn[55];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로수당 등(1월)
                vGDColumnIndex = pGDColumn[56];
                vXLColumnIndex = pXLColumn[56];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal <= 2400000) // 해당 값이 2,400,000 보다 작거나 같다면
                    {
                        v1Month = vConvertDecimal;
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v1Month);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else // 해당 값이 2,400,000 보다 크다면
                    {
                        v1Month = 2400000;
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v1Month);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        vOverValueCheck = true;
                    }                    
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(1월)
                vGDColumnIndex = pGDColumn[57];
                vXLColumnIndex = pXLColumn[57];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v1MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v1MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if((v1Month + v1MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v1Month + v1MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(2월)
                vGDColumnIndex = pGDColumn[58];
                vXLColumnIndex = pXLColumn[58];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(2월)
                vGDColumnIndex = pGDColumn[59];
                vXLColumnIndex = pXLColumn[59];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else 
                    {
                        if ((v1Month + vConvertDecimal) <= 2400000) // 1월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                        {
                            v2Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v2Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v2Month = 2400000 - v1Month;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v2Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }   
                    }                    
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(2월)
                vGDColumnIndex = pGDColumn[60];
                vXLColumnIndex = pXLColumn[60];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v2MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v2MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v2Month + v2MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v2Month + v2MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(3월)
                vGDColumnIndex = pGDColumn[61];
                vXLColumnIndex = pXLColumn[61];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(3월)
                vGDColumnIndex = pGDColumn[62];
                vXLColumnIndex = pXLColumn[62];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + vConvertDecimal) <= 2400000) // 1월 값 + 2월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                        {
                            v3Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v3Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v3Month = 2400000 - (v1Month + v2Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v3Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    } 
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(3월)
                vGDColumnIndex = pGDColumn[63];
                vXLColumnIndex = pXLColumn[63];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v3MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v3MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v3Month + v3MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v3Month + v3MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(4월)
                vGDColumnIndex = pGDColumn[64];
                vXLColumnIndex = pXLColumn[64];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(4월)
                vGDColumnIndex = pGDColumn[65];
                vXLColumnIndex = pXLColumn[65];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + vConvertDecimal) <= 2400000) // 1월 값 + 2월 값 + 3월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                        {
                            v4Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v4Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v4Month = 2400000 - (v1Month + v2Month + v3Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v4Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비
                vGDColumnIndex = pGDColumn[66];
                vXLColumnIndex = pXLColumn[66];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v4MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v4MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v4Month + v4MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v4Month + v4MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(5월)
                vGDColumnIndex = pGDColumn[67];
                vXLColumnIndex = pXLColumn[67];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(5월)
                vGDColumnIndex = pGDColumn[68];
                vXLColumnIndex = pXLColumn[68];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + vConvertDecimal) <= 2400000) // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                        {
                            v5Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v5Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v5Month = 2400000 - (v1Month + v2Month + v3Month + v4Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v5Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(5월)
                vGDColumnIndex = pGDColumn[69];
                vXLColumnIndex = pXLColumn[69];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v5MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v5MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v5Month + v5MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v5Month + v5MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(6월)
                vGDColumnIndex = pGDColumn[70];
                vXLColumnIndex = pXLColumn[70];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(6월)
                vGDColumnIndex = pGDColumn[71];
                vXLColumnIndex = pXLColumn[71];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + vConvertDecimal) <= 2400000) 
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v6Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v6Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v6Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v6Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(6월)
                vGDColumnIndex = pGDColumn[72];
                vXLColumnIndex = pXLColumn[72];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v6MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v6MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;                
                if((v6Month + v6MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v6Month + v6MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(7월)
                vGDColumnIndex = pGDColumn[73];
                vXLColumnIndex = pXLColumn[73];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(7월)
                vGDColumnIndex = pGDColumn[74];
                vXLColumnIndex = pXLColumn[74];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v7Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v7Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v7Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v7Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(7월)
                vGDColumnIndex = pGDColumn[75];
                vXLColumnIndex = pXLColumn[75];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v7MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v7MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v7Month + v7MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v7Month + v7MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(8월)
                vGDColumnIndex = pGDColumn[76];
                vXLColumnIndex = pXLColumn[76];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(8월)
                vGDColumnIndex = pGDColumn[77];
                vXLColumnIndex = pXLColumn[77];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v8Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v8Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v8Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v8Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(8월)
                vGDColumnIndex = pGDColumn[78];
                vXLColumnIndex = pXLColumn[78];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v8MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v8Month + v8MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v8Month + v8MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(9월)
                vGDColumnIndex = pGDColumn[79];
                vXLColumnIndex = pXLColumn[79];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(9월)
                vGDColumnIndex = pGDColumn[80];
                vXLColumnIndex = pXLColumn[80];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v9Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v9Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v9Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v9Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(9월)
                vGDColumnIndex = pGDColumn[81];
                vXLColumnIndex = pXLColumn[81];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v9MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v9MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v9Month + v9MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v9Month + v9MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(10월)
                vGDColumnIndex = pGDColumn[82];
                vXLColumnIndex = pXLColumn[82];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(10월)
                vGDColumnIndex = pGDColumn[83];
                vXLColumnIndex = pXLColumn[83];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v10Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v10Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v10Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v10Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(10월)
                vGDColumnIndex = pGDColumn[84];
                vXLColumnIndex = pXLColumn[84];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v10MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v10MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v10Month + v10MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v10Month + v10MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(11월)
                vGDColumnIndex = pGDColumn[85];
                vXLColumnIndex = pXLColumn[85];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(11월)
                vGDColumnIndex = pGDColumn[86];
                vXLColumnIndex = pXLColumn[86];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + v10Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 10월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v11Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v11Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 10월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v11Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + v10Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v11Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(11월)
                vGDColumnIndex = pGDColumn[87];
                vXLColumnIndex = pXLColumn[87];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v11MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v11MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v11Month + v11MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v11Month + v11MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급년월(12월)
                vGDColumnIndex = pGDColumn[88];
                vXLColumnIndex = pXLColumn[88];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 야간근로 수당 등(12월)
                vGDColumnIndex = pGDColumn[89];
                vXLColumnIndex = pXLColumn[89];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vOverValueCheck == true) // 이미 2,400,000을 초과했을 경우, 다른 값은 미출력 처리
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        if ((v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + v10Month + v11Month + vConvertDecimal) <= 2400000)
                        {   // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 10월 값 + 11월 값 + 해당 값이 2,400,000 보다 작거나 같다면
                            v12Month = vConvertDecimal;
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v12Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                        }
                        else // 1월 값 + 2월 값 + 3월 값 + 4월 값 + 5월 값 + 6월 값 + 7월 값 + 8월 값 + 9월 값 + 10월 값 + 11월 값 + 해당 값이 2,400,000 보다 크다면
                        {
                            v12Month = 2400000 - (v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + v10Month + v11Month);
                            vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v12Month);
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                            vOverValueCheck = true;
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비(12월)
                vGDColumnIndex = pGDColumn[90];
                vXLColumnIndex = pXLColumn[90];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    v12MonthCar = vConvertDecimal;
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", v12MonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 가로 합계(야간근로수당 등 + 차량유류비)
                vXLColumnIndex = 41;
                if ((v12Month + v12MonthCar) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", (v12Month + v12MonthCar));
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 야간근로수당 등 총합계
                vXLColumnIndex = 16;                
                vTotalMonth = v1Month + v2Month + v3Month + v4Month + v5Month + v6Month + v7Month + v8Month + v9Month + v10Month + v11Month + v12Month;
                if (vTotalMonth != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vTotalMonth);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차량유류비 총합계
                vXLColumnIndex = 36;
                vTotalMonthCar = v1MonthCar + v2MonthCar + v3MonthCar + v4MonthCar + v5MonthCar + v6MonthCar + v7MonthCar + v8MonthCar + v9MonthCar + v10MonthCar + v11MonthCar + v12MonthCar;
                if (vTotalMonthCar != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vTotalMonthCar);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 비과세 총합계
                vXLColumnIndex = 41;
                vTotalValue = vTotalMonth + vTotalMonthCar;
                if (vTotalValue != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vTotalValue);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 4;
                //-------------------------------------------------------------------

                //------------------------ 근로소득원천징수액 -------------------------//
                // 소득세(1월)
                vGDColumnIndex = pGDColumn[91];
                vXLColumnIndex = pXLColumn[91];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(1월)
                vGDColumnIndex = pGDColumn[92];
                vXLColumnIndex = pXLColumn[92];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(1월)
                vGDColumnIndex = pGDColumn[93];
                vXLColumnIndex = pXLColumn[93];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(1월)
                vGDColumnIndex = pGDColumn[94];
                vXLColumnIndex = pXLColumn[94];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(1월)
                vGDColumnIndex = pGDColumn[95];
                vXLColumnIndex = pXLColumn[95];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(2월)
                vGDColumnIndex = pGDColumn[96];
                vXLColumnIndex = pXLColumn[96];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(2월)
                vGDColumnIndex = pGDColumn[97];
                vXLColumnIndex = pXLColumn[97];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(2월)
                vGDColumnIndex = pGDColumn[98];
                vXLColumnIndex = pXLColumn[98];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(2월)
                vGDColumnIndex = pGDColumn[99];
                vXLColumnIndex = pXLColumn[99];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(2월)
                vGDColumnIndex = pGDColumn[100];
                vXLColumnIndex = pXLColumn[100];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(3월)
                vGDColumnIndex = pGDColumn[101];
                vXLColumnIndex = pXLColumn[101];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(3월)
                vGDColumnIndex = pGDColumn[102];
                vXLColumnIndex = pXLColumn[102];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(3월)
                vGDColumnIndex = pGDColumn[103];
                vXLColumnIndex = pXLColumn[103];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(3월)
                vGDColumnIndex = pGDColumn[104];
                vXLColumnIndex = pXLColumn[104];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(3월)
                vGDColumnIndex = pGDColumn[105];
                vXLColumnIndex = pXLColumn[105];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(4월)
                vGDColumnIndex = pGDColumn[106];
                vXLColumnIndex = pXLColumn[106];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(4월)
                vGDColumnIndex = pGDColumn[107];
                vXLColumnIndex = pXLColumn[107];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(4월)
                vGDColumnIndex = pGDColumn[108];
                vXLColumnIndex = pXLColumn[108];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(4월)
                vGDColumnIndex = pGDColumn[109];
                vXLColumnIndex = pXLColumn[109];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(4월)
                vGDColumnIndex = pGDColumn[110];
                vXLColumnIndex = pXLColumn[110];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(5월)
                vGDColumnIndex = pGDColumn[111];
                vXLColumnIndex = pXLColumn[111];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(5월)
                vGDColumnIndex = pGDColumn[112];
                vXLColumnIndex = pXLColumn[112];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(5월)
                vGDColumnIndex = pGDColumn[113];
                vXLColumnIndex = pXLColumn[113];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(5월)
                vGDColumnIndex = pGDColumn[114];
                vXLColumnIndex = pXLColumn[114];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(5월)
                vGDColumnIndex = pGDColumn[115];
                vXLColumnIndex = pXLColumn[115];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(6월)
                vGDColumnIndex = pGDColumn[116];
                vXLColumnIndex = pXLColumn[116];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(6월)
                vGDColumnIndex = pGDColumn[117];
                vXLColumnIndex = pXLColumn[117];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(6월)
                vGDColumnIndex = pGDColumn[118];
                vXLColumnIndex = pXLColumn[118];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(6월)
                vGDColumnIndex = pGDColumn[119];
                vXLColumnIndex = pXLColumn[119];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(6월)
                vGDColumnIndex = pGDColumn[120];
                vXLColumnIndex = pXLColumn[120];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(7월)
                vGDColumnIndex = pGDColumn[121];
                vXLColumnIndex = pXLColumn[121];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(7월)
                vGDColumnIndex = pGDColumn[122];
                vXLColumnIndex = pXLColumn[122];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(7월)
                vGDColumnIndex = pGDColumn[123];
                vXLColumnIndex = pXLColumn[123];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(7월)
                vGDColumnIndex = pGDColumn[124];
                vXLColumnIndex = pXLColumn[124];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(7월)
                vGDColumnIndex = pGDColumn[125];
                vXLColumnIndex = pXLColumn[125];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(8월)
                vGDColumnIndex = pGDColumn[126];
                vXLColumnIndex = pXLColumn[126];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(8월)
                vGDColumnIndex = pGDColumn[127];
                vXLColumnIndex = pXLColumn[127];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(8월)
                vGDColumnIndex = pGDColumn[128];
                vXLColumnIndex = pXLColumn[128];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(8월)
                vGDColumnIndex = pGDColumn[129];
                vXLColumnIndex = pXLColumn[129];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(8월)
                vGDColumnIndex = pGDColumn[130];
                vXLColumnIndex = pXLColumn[130];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(9월)
                vGDColumnIndex = pGDColumn[131];
                vXLColumnIndex = pXLColumn[131];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(9월)
                vGDColumnIndex = pGDColumn[132];
                vXLColumnIndex = pXLColumn[132];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(9월)
                vGDColumnIndex = pGDColumn[133];
                vXLColumnIndex = pXLColumn[133];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(9월)
                vGDColumnIndex = pGDColumn[134];
                vXLColumnIndex = pXLColumn[134];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(9월)
                vGDColumnIndex = pGDColumn[135];
                vXLColumnIndex = pXLColumn[135];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(10월)
                vGDColumnIndex = pGDColumn[136];
                vXLColumnIndex = pXLColumn[136];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(10월)
                vGDColumnIndex = pGDColumn[137];
                vXLColumnIndex = pXLColumn[137];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(10월)
                vGDColumnIndex = pGDColumn[138];
                vXLColumnIndex = pXLColumn[138];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(10월)
                vGDColumnIndex = pGDColumn[139];
                vXLColumnIndex = pXLColumn[139];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(10월)
                vGDColumnIndex = pGDColumn[140];
                vXLColumnIndex = pXLColumn[140];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(11월)
                vGDColumnIndex = pGDColumn[141];
                vXLColumnIndex = pXLColumn[141];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(11월)
                vGDColumnIndex = pGDColumn[142];
                vXLColumnIndex = pXLColumn[142];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(11월)
                vGDColumnIndex = pGDColumn[143];
                vXLColumnIndex = pXLColumn[143];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(11월)
                vGDColumnIndex = pGDColumn[144];
                vXLColumnIndex = pXLColumn[144];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(11월)
                vGDColumnIndex = pGDColumn[145];
                vXLColumnIndex = pXLColumn[145];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세(12월)
                vGDColumnIndex = pGDColumn[146];
                vXLColumnIndex = pXLColumn[146];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세(12월)
                vGDColumnIndex = pGDColumn[147];
                vXLColumnIndex = pXLColumn[147];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험(12월)
                vGDColumnIndex = pGDColumn[148];
                vXLColumnIndex = pXLColumn[148];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험(12월)
                vGDColumnIndex = pGDColumn[149];
                vXLColumnIndex = pXLColumn[149];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험(12월)
                vGDColumnIndex = pGDColumn[150];
                vXLColumnIndex = pXLColumn[150];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 소득세 계
                vGDColumnIndex = pGDColumn[151];
                vXLColumnIndex = pXLColumn[151];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세 계
                vGDColumnIndex = pGDColumn[152];
                vXLColumnIndex = pXLColumn[152];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연금보험 계
                vGDColumnIndex = pGDColumn[153];
                vXLColumnIndex = pXLColumn[153];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험 계
                vGDColumnIndex = pGDColumn[154];
                vXLColumnIndex = pXLColumn[154];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 고용보험 계
                vGDColumnIndex = pGDColumn[155];
                vXLColumnIndex = pXLColumn[155];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 출력 날짜
                vGDColumnIndex = pGDColumn[156];
                vXLColumnIndex = pXLColumn[156];
                vObject = pGridPRINT_INCOME_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------
            }

            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #endregion;

        #region ----- Excel Main Wirte  Method Backup----

        public int WriteMain(InfoSummit.Win.ControlAdv.ISGridAdvEx pGridIN_EARNER_DED_TAX)
        {
            string vMessageText = string.Empty;
            bool isOpen = XLFileOpen();
            mCopyLineSUM = 1;
            mPageNumber = 0;

            int[] vGDColumn;
            int[] vXLColumn;

            int vTotalRow = pGridIN_EARNER_DED_TAX.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            SetArray(pGridIN_EARNER_DED_TAX, out vGDColumn, out vXLColumn);
            mPrinting.XLActiveSheet("SourceTab1");

            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;
                pGridIN_EARNER_DED_TAX.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Printing : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "SRC_TAB1");
                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                pGridIN_EARNER_DED_TAX.CurrentCellMoveTo(vRow, 0);
                pGridIN_EARNER_DED_TAX.Focus();
                pGridIN_EARNER_DED_TAX.CurrentCellActivate(vRow, 0);

                vPrintingLine = XLLine(pGridIN_EARNER_DED_TAX, vRow, vPrintingLine, vGDColumn, vXLColumn, "SRC_TAB1");
            }

            return mPageNumber;

            //---------------------------------------------------------------------------------------------------
            // 설  명 : Form에서 성명을 선택하지 않았을 시, '전 직원' 출력이 가능하도록 구현한 소스 코드입니다.
            //          향후, 1인 출력이 아닌 전체 출력으로 변경해야 할 경우 사용하세요.
            // 날  짜 : 2011. 6. 14(화)
            // 작성자 : 이선희J
            //---------------------------------------------------------------------------------------------------
            /*
            string vMessageText = string.Empty;
            bool isOpen = XLFileOpen();
            mCopyLineSUM = 1;
            mPageNumber = 0;

            int[] vGDColumn;
            int[] vXLColumn;

            int vTotalRow = gridIN_EARNER_DED_TAX.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            int vSecondPrinting = 30;
            int vCountPrinting = 0;

            SetArray(gridIN_EARNER_DED_TAX, out vGDColumn, out vXLColumn);
            mPrinting.XLActiveSheet("SourceTab1");

            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;
                gridIN_EARNER_DED_TAX.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Printing : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                if (isOpen == true)
                {
                    vCountPrinting++;

                    mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "SRC_TAB1");
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                    gridIN_EARNER_DED_TAX.CurrentCellMoveTo(vRow, 0);
                    gridIN_EARNER_DED_TAX.Focus();
                    gridIN_EARNER_DED_TAX.CurrentCellActivate(vRow, 0);

                    vPrintingLine = XLLine(gridIN_EARNER_DED_TAX, vRow, vPrintingLine, vGDColumn, vXLColumn, "SRC_TAB1");

                    if (vSecondPrinting < vCountPrinting)
                    {
                        Printing(1, vSecondPrinting);

                        mPrinting.XLOpenFileClose();
                        isOpen = XLFileOpen();

                        vCountPrinting = 0;
                        vPrintingLine = 1;
                        mCopyLineSUM = 1;
                    }
                    else if (vTotalRow == vRowCount)
                    {
                        Printing(1, vSecondPrinting);
                    }
                }
            }
            mPrinting.XLOpenFileClose();            

            return mPageNumber;
            */
        }

        #endregion;

        #region ----- Header Write Method ----

        private void XLHeader(string pDate)
        {
            int vXLine = 0;
            int vXLColumn = 0;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                vXLine = 53;
                vXLColumn = 9;
                mPrinting.XLSetCell(vXLine, vXLColumn, pDate);

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }


            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                vXLine = 61;
                vXLColumn = 9;
                mPrinting.XLSetCell(vXLine, vXLColumn, pDate);

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //첫번째 페이지 복사
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine, string pCourse)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            if (pCourse == "SRC_TAB1")
            {
                pPrinting.XLActiveSheet("SourceTab1");
            }

            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //페이지 번호

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            mPrinting.XLPrinting(pPageSTART, pPageEND);
        }

        #endregion;

        #region ----- Save Methods ----

        public void SAVE(string pSaveFileName)
        {
            System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

            int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            vMaxNumber = vMaxNumber + 1;
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder.ToString(), vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;

    }
}
