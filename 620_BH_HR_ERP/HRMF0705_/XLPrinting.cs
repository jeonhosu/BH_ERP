using System;

namespace HRMF0705
{
    public class XLPrinting
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

        private int mPrintingLineSTART_1 = 1;  //Line // 1page, 2page, 3page
        private int mPrintingLineSTART_2 = 6;  //Line // 5page

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX_1 = 183;  // 1page : 61, 2page : 122, 3page : 183 - 복사되어질 행의 범위
        private int mIncrementCopyMAX_2 = 61;   // 5page

        private int mCopyColumnSTART = 1;    //복사되어  진 행 누적 수
        private int mCopyColumnEND = 43;     //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface, InfoSummit.Win.ControlAdv.ISMessageAdapter pMessageAdapter)
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

        #region ----- Array Set 1 ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[140];
            pXLColumn = new int[140];

            //----[ 1 page ]------------------------------------------------------------------------------------------------------
            pGDColumn[0] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RESIDENT_TYPE");        // 거주 구분(거주자1/거주자2)    
            pGDColumn[1] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NATIONALITY_TYPE");     // 내외국인 구분(내국인1/외국인9)
            pGDColumn[2] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FOREIGN_TAX_YN");       // 외국인단일세율적용
            pGDColumn[3] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSEHOLD_TYPE");       // 세대주 구분(세대주1/세대원2)              
            pGDColumn[4] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_KEEP_TYPE");       // 연말정산구분

            pGDColumn[5] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CORP_NAME");            // 법인명(상호)                  
            pGDColumn[6] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRESIDENT_NAME");       // 대표자(성명)                  
            pGDColumn[7] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("VAT_NUMBER");           // 사업자등록번호              
            pGDColumn[8] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ORG_ADDRESS");          // 소재지(주소)

            pGDColumn[9] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NAME");                 // 성명
            pGDColumn[10] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REPRE_NUM");           // 주민번호
            pGDColumn[11] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PERSON_ADDRESS");      // 주소  

            //--------------------------------------------------------------------------------------------------------------------
            // I 근무처별 소득 명세
            //--------------------------------------------------------------------------------------------------------------------                      
            pGDColumn[12] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME");      // 주(현)근무처명
            pGDColumn[13] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NAME1");    // 종(전)1근무처명 
            pGDColumn[14] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NAME2");    // 종(전)2근무처명

            pGDColumn[15] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER");     // 주(현)사업자번호 
            pGDColumn[16] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NUM1");     // 종(전)1사업잡번호
            pGDColumn[17] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NUM2");     // 종(전)2사업잡번호 

            pGDColumn[18] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE");         // 주(현)근무기간
            pGDColumn[19] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE1");        // 종(전)1근무기간
            pGDColumn[20] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE2");        // 종(전)2근무기간

            pGDColumn[21] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE");         // 주(현)감면기간 
            pGDColumn[22] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE1");        // 종(전)1감면기간
            pGDColumn[23] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE2");        // 종(전)2감면기간

            pGDColumn[24] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_PAY_TOT_AMT");     // 주(현)급여 
            pGDColumn[25] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PAY_TOTAL_AMT1");      // 종(전)1급여
            pGDColumn[26] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PAY_TOTAL_AMT2");      // 종(전)2급여

            pGDColumn[27] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_BONUS_TOT_AMT");   // 주(현)상여   
            pGDColumn[28] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BONUS_TOTAL_AMT1");    // 종(전)1상여 
            pGDColumn[29] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BONUS_TOTAL_AMT2");    // 종(전)2상여

            pGDColumn[30] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_ADD_BONUS_AMT");   // 주(현)인정상여   
            pGDColumn[31] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADD_BONUS_AMT1");      // 종(전)1인정상여
            pGDColumn[32] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADD_BONUS_AMT2");      // 종(전)2인정상여

            pGDColumn[33] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_STOCK_BENE_AMT");  // 주(현)주식매수선택권
            pGDColumn[34] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STOCK_BENE_AMT1");     // 종(전)1주식매수선택권
            pGDColumn[35] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STOCK_BENE_AMT2");     // 종(전)2주식매수선택권

            pGDColumn[36] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT");       // 주(현)우리사주조합인출금
            pGDColumn[37] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT1");      // 종(전)1우리사주조합인출금
            pGDColumn[38] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT2");      // 종(전)2우리사주조합인출금

            pGDColumn[39] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_TOTAL_AMOUNT");    // 주(현)계     
            pGDColumn[40] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AMOUNT1");       // 종(전)1계   
            pGDColumn[41] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AMOUNT2");       // 종(전)2계  

            //--------------------------------------------------------------------------------------------------------------------
            // II 비과세 및 감면 소득 명세
            //--------------------------------------------------------------------------------------------------------------------
            pGDColumn[42] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_OUTSIDE_AMT");  // 비과세_주(현)국외근로
            pGDColumn[43] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OUTSIDE_AMT1");     // 비과세_종(전)1국외근로
            pGDColumn[44] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OUTSIDE_AMT2");     // 비과세_종(전)2국외근로

            pGDColumn[45] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_OT_AMT");       // 비과세_주(현)야간근로수당 
            pGDColumn[46] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OT_AMT1");          // 비과세_종(전)1야간근로수당
            pGDColumn[47] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OT_AMT2");          // 비과세_종(전)2야간근로수당

            pGDColumn[48] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_BIRTH_AMT");    // 비과세_주(현)출산/보육수당
            pGDColumn[49] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_BIRTH_AMT1");       // 비과세_종(전)1출산/보육수당
            pGDColumn[50] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_BIRTH_AMT2");       // 비과세_종(전)2출산/보육수당

            pGDColumn[51] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_FOREIGNER_AMT");// 비과세_주(현)외국인근로자
            pGDColumn[52] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_FOREIGNER_AMT1");   // 비과세_종(전)1외국인근로자
            pGDColumn[53] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_FOREIGNER_AMT2");   // 비과세_종(전)2외국인근로자

            pGDColumn[54] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_TOTAL_AMOUNT"); // 비과세_주(현)비과세소득계
            pGDColumn[55] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_TOTAL_AMOUNT1");    // 비과세_종(전)1비과세소득계
            pGDColumn[56] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_TOTAL_AMOUNT2");    // 비과세_종(전)2비과세소득계

            pGDColumn[57] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT"); // 비과세_주(현)감면소득계
            pGDColumn[58] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT1");// 비과세_종(전)1감면소득계
            pGDColumn[59] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT2");// 비과세_종(전)2감면소득계

            //--------------------------------------------------------------------------------------------------------------------
            // III 세액 명세
            //--------------------------------------------------------------------------------------------------------------------
            pGDColumn[60] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_IN_TAX_AMT");      // 결정세액_소득세               
            pGDColumn[61] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_LOCAL_TAX_AMT");   // 결정세액_지방소득세               
            pGDColumn[62] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_SP_TAX_AMT");      // 결정세액_농특세               
            pGDColumn[63] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_TAX_AMOUNT");      // 결정세액_계   

            pGDColumn[64] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_COMPANY_NUM1");    // 기납부세액_종(전)1사업자번호  
            pGDColumn[65] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_IN_TAX_AMT1");     // 기납부세액_종(전)1소득세      
            pGDColumn[66] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_LOCAL_TAX_AMT1");  // 기납부세액_종(전)1지방소득세      
            pGDColumn[67] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_SP_TAX_AMT1");     // 기납부세액_종(전)1농특세      
            pGDColumn[68] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_TOTAL_TAX_AMT1");  // 기납부세액_종(전)1계      

            pGDColumn[69] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_COMPANY_NUM2");    // 기납부세액_종(전)2사업자번호  
            pGDColumn[70] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_IN_TAX_AMT2");     // 기납부세액_종(전)2소득세      
            pGDColumn[71] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_LOCAL_TAX_AMT2");  // 기납부세액_종(전)2지방소득세      
            pGDColumn[72] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_SP_TAX_AMT2");     // 기납부세액_종(전)2농특세      
            pGDColumn[73] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_TOTAL_TAX_AMT2");  // 기납부세액_종(전)2계        

            pGDColumn[74] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_IN_TAX_AMT");      // 기납부세액_주(현)소득세       
            pGDColumn[75] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LOCAL_TAX_AMT");   // 기납부세액_주(현)지방소득세       
            pGDColumn[76] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_SP_TAX_AMT");      // 기납부세액_주(현)농특세       
            pGDColumn[77] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_TAX_AMOUNT");      // 기납부세액_주(현)계

            pGDColumn[78] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT");     // 차감징수세액_소득세           
            pGDColumn[79] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT");  // 차감징수세액_지방소득세         
            pGDColumn[80] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_SP_TAX_AMT");     // 차감징수세액_농특세           
            pGDColumn[81] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_TAX_AMOUNT");     // 차감징수세액_계

            //----[ 2 page ]------------------------------------------------------------------------------------------------------
            pGDColumn[82] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_TOT_AMT");           // 총급여
            pGDColumn[83] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PERS_ANNU_BANK_AMT");       // 개인연금저축소득공제
              
            pGDColumn[84] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_DED_AMT");           // 근로소득공제
            pGDColumn[85] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ANNU_BANK_AMT");            // 연금저축소득공제
         
            pGDColumn[86] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_AMT");               // 근로소득금액
            pGDColumn[87] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SMALL_CORPOR_DED_AMT");     // 소기업/소상공인 공제부금 소득공제
         
            pGDColumn[88] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PER_DED_AMT");              // 기본(본인)
            pGDColumn[89] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_APP_SAVE_AMT");       // 청약저축
           
            pGDColumn[90] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SPOUSE_DED_AMT");           // 기본(배우자)
            pGDColumn[91] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_APP_DEPOSIT_AMT");    // 주택청약종합저축
         
            pGDColumn[92] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUPP_DED_COUNT");           // 기본(부양인원 - 인원)            
            pGDColumn[93] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUPP_DED_AMT");             // 기본(부양인원 - 금액)
            pGDColumn[94] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_SAVE_AMT");           // 장기주택마련저축
             
            pGDColumn[95] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OLD_DED_COUNT");            // 추가공제(경로수 - 인원)          
            pGDColumn[96] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OLD_DED_AMT");              // 추가공제(경로수 - 금액)
            pGDColumn[97] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORKER_HOUSE_SAVE_AMT");    // 근로자주택마련저축
          
            pGDColumn[98] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_DED_COUNT");         // 추가공제(장애인 - 인원)          
            pGDColumn[99] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_DED_AMT");           // 추가공제(장애인 - 금액)
            pGDColumn[100] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INVES_AMT");               // 투자조합출자등 소득공제
          
            pGDColumn[101] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WOMAN_DED_AMT");           // 추가공제(부녀세대)
            pGDColumn[102] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CREDIT_AMT");              // 신용카드등 소득공제
   
            pGDColumn[103] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CHILD_DED_COUNT");         // 추가공제(자녀양육 - 인원)        
            pGDColumn[104] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CHILD_DED_AMT");           // 추가공제(자녀양육 - 금액)
            pGDColumn[105] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EMPL_STOCK_AMT");          // 우리사주출자
        
            pGDColumn[106] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BIRTH_DED_COUNT");         // 추가공제(출산입양 - 인원)        
            pGDColumn[107] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BIRTH_DED_AMT");           // 추가공제(출산입양 - 금액)
            pGDColumn[108] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_STOCK_SAVING_AMT");   // 장기주식형저축

            pGDColumn[109] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HIRE_KEEP_EMPLOY_AMT");    // 고용유지중소기업소득공제

            pGDColumn[110] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MANY_CHILD_DED_COUNT");    // 다자녀공제(인원)                 
            pGDColumn[111] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MANY_CHILD_DED_AMT");      // 다자녀공제(금액) 
                
            pGDColumn[112] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NATI_ANNU_AMT");           // 국민연금보험료공제               

            pGDColumn[113] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ETC_DED_SUM");             // 그밖의소득공제 계

            pGDColumn[114] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_STD_AMT");             // 종합과세표준

            pGDColumn[115] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("COMP_TAX_AMT");            // 산출세액

            pGDColumn[116] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_IN_LAW_AMT");     // 소득세법
                  
            pGDColumn[117] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETR_ANNU_AMT");           // 퇴직연금소득공제                 
            pGDColumn[118] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_SP_LAW_AMT");     // 조세특례제한법

            pGDColumn[119] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MEDIC_INSUR_AMT");         // 건강보험료                       
            pGDColumn[120] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HIRE_INSUR_AMT");          // 고용보험료                       
            pGDColumn[121] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("GUAR_INSUR_AMT");          // 보장성보험                       
            pGDColumn[122] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_INSUR_AMT");        // 장애인전용 
                      
            pGDColumn[123] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MEDIC_AMT");               // 특별공제(의료비) 
            pGDColumn[124] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_SUM");            // 세액감면 계  
  
            pGDColumn[125] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EDUCATION_AMT");           // 특별공제(교육비) 
            pGDColumn[126] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_INCOME_AMT");      // 근로소득                

            pGDColumn[127] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_INTER_AMT");         // 특별공제(주택임차차입금) 
            pGDColumn[128] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_TAXGROUP_AMT");    // 납세조합공제

            pGDColumn[129] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_MONTHLY_AMT");       // 특별공제(월세)
                   
            pGDColumn[130] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_HOUSE_PROF_AMT");     // 특별공제(장기주택차입금)
            pGDColumn[131] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_HOUSE_DEBT_AMT");  // 주택차입금

            pGDColumn[132] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DONAT_AMT");               // 특별공제(기부금) 
            pGDColumn[133] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_DONAT_POLI_AMT");  // 기부 정치자금

            pGDColumn[134] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_OUTSIDE_PAY_AMT"); // 외국 납부

            pGDColumn[135] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SP_DED_SUM");              // 특별공제(계)

            pGDColumn[136] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STAND_DED_AMT");           // 특별공제(표준공제)
            pGDColumn[137] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_SUM");             // 세액공제 계         
                  
            pGDColumn[138] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_DED_AMT");            // 차감소득금액                      
            pGDColumn[139] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SET_TAX_SUM");             // 결정세액                         

            //----[ 1 page ]------------------------------------------------------------------------------------------------------
            pXLColumn[0] = 37;  // 거주 구분(거주자1/거주자2)    
            pXLColumn[1] = 37;  // 내외국인 구분(내국인1/외국인9)
            pXLColumn[2] = 39;  // 외국인단일세율적용            
            pXLColumn[3] = 37;  // 세대주 구분(세대주1/세대원2)  
            pXLColumn[4] = 37;  // 연말정산구분                  

            pXLColumn[5] = 11;  // 법인명(상호)                  
            pXLColumn[6] = 30;  // 대표자(성명)                  
            pXLColumn[7] = 11;  // 사업자등록번호                
            pXLColumn[8] = 11;  // 소재지(주소)                  

            pXLColumn[9] = 11;  // 성명                          
            pXLColumn[10] = 30;  // 주민번호                      
            pXLColumn[11] = 11;  // 주소                          

            //--------------------------------------------------------------------------------------------------------------------
            // I 근무처별 소득 명세
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[12] = 11;  // 주(현)근무처명                
            pXLColumn[13] = 17;  // 종(전)1근무처명               
            pXLColumn[14] = 23;  // 종(전)2근무처명               

            pXLColumn[15] = 11;  // 주(현)사업자번호              
            pXLColumn[16] = 17;  // 종(전)1사업잡번호             
            pXLColumn[17] = 23;  // 종(전)2사업잡번호             

            pXLColumn[18] = 11;  // 주(현)근무기간                
            pXLColumn[19] = 17;  // 종(전)1근무기간               
            pXLColumn[20] = 23;  // 종(전)2근무기간               

            pXLColumn[21] = 11;  // 주(현)감면기간                
            pXLColumn[22] = 17;  // 종(전)1감면기간               
            pXLColumn[23] = 23;  // 종(전)2감면기간               

            pXLColumn[24] = 11;  // 주(현)급여                    
            pXLColumn[25] = 17;  // 종(전)1급여                   
            pXLColumn[26] = 23;  // 종(전)2급여                   

            pXLColumn[27] = 11;  // 주(현)상여                    
            pXLColumn[28] = 17;  // 종(전)1상여                   
            pXLColumn[29] = 23;  // 종(전)2상여                   

            pXLColumn[30] = 11;  // 주(현)인정상여                
            pXLColumn[31] = 17;  // 종(전)1인정상여               
            pXLColumn[32] = 23;  // 종(전)2인정상여               

            pXLColumn[33] = 11;  // 주(현)주식매수선택권          
            pXLColumn[34] = 17;  // 종(전)1주식매수선택권         
            pXLColumn[35] = 23;  // 종(전)2주식매수선택권         

            pXLColumn[36] = 11;  // 주(현)우리사주조합인출금      
            pXLColumn[37] = 17;  // 종(전)1우리사주조합인출금     
            pXLColumn[38] = 23;  // 종(전)2우리사주조합인출금     

            pXLColumn[39] = 11;  // 주(현)계                      
            pXLColumn[40] = 17;  // 종(전)1계                     
            pXLColumn[41] = 23;  // 종(전)2계                     

            //--------------------------------------------------------------------------------------------------------------------
            // II 비과세 및 감면 소득 명세
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[42] = 11;  // 비과세_주(현)국외근로       
            pXLColumn[43] = 17;  // 비과세_종(전)1국외근로      
            pXLColumn[44] = 23;  // 비과세_종(전)2국외근로      

            pXLColumn[45] = 11;  // 비과세_주(현)야간근로수당   
            pXLColumn[46] = 17;  // 비과세_종(전)1야간근로수당  
            pXLColumn[47] = 23;  // 비과세_종(전)2야간근로수당  

            pXLColumn[48] = 11;  // 비과세_주(현)출산/보육수당  
            pXLColumn[49] = 17;  // 비과세_종(전)1출산/보육수당 
            pXLColumn[50] = 23;  // 비과세_종(전)2출산/보육수당 

            pXLColumn[51] = 11;  // 비과세_주(현)외국인근로자   
            pXLColumn[52] = 17;  // 비과세_종(전)1외국인근로자  
            pXLColumn[53] = 23;  // 비과세_종(전)2외국인근로자  

            pXLColumn[54] = 11;  // 비과세_주(현)비과세소득계   
            pXLColumn[55] = 17;  // 비과세_종(전)1비과세소득계  
            pXLColumn[56] = 23;  // 비과세_종(전)2비과세소득계  

            pXLColumn[57] = 11;  // 비과세_주(현)감면소득계     
            pXLColumn[58] = 17;  // 비과세_종(전)1감면소득계    
            pXLColumn[59] = 23;  // 비과세_종(전)2감면소득계    

            //--------------------------------------------------------------------------------------------------------------------
            // III 세액 명세
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[60] = 19;  // 결정세액_소득세              
            pXLColumn[61] = 25;  // 결정세액_지방소득세          
            pXLColumn[62] = 31;  // 결정세액_농특세              
            pXLColumn[63] = 36;  // 결정세액_계                  

            pXLColumn[64] = 14;  // 기납부세액_종(전)1사업자번호 
            pXLColumn[65] = 19;  // 기납부세액_종(전)1소득세     
            pXLColumn[66] = 25;  // 기납부세액_종(전)1지방소득세 
            pXLColumn[67] = 31;  // 기납부세액_종(전)1농특세     
            pXLColumn[68] = 36;  // 기납부세액_종(전)1계         

            pXLColumn[69] = 14;  // 기납부세액_종(전)2사업자번호 
            pXLColumn[70] = 19;  // 기납부세액_종(전)2소득세     
            pXLColumn[71] = 25;  // 기납부세액_종(전)2지방소득세 
            pXLColumn[72] = 31;  // 기납부세액_종(전)2농특세                  
            pXLColumn[73] = 36;  // 기납부세액_종(전)2계         

            pXLColumn[74] = 19;  // 기납부세액_주(현)소득세      
            pXLColumn[75] = 25;  // 기납부세액_주(현)지방소득세  
            pXLColumn[76] = 31;  // 기납부세액_주(현)농특세      
            pXLColumn[77] = 36;  // 기납부세액_주(현)계          

            pXLColumn[78] = 19;  // 차감징수세액_소득세          
            pXLColumn[79] = 25;  // 차감징수세액_지방소득세      
            pXLColumn[80] = 31;  // 차감징수세액_농특세          
            pXLColumn[81] = 36;  // 차감징수세액_계  

            //----[ 2 page ]------------------------------------------------------------------------------------------------------
            pXLColumn[82] = 16; // 총급여
            pXLColumn[83] = 36; // 개인연금저축소득공제

            pXLColumn[84] = 16; // 근로소득공제
            pXLColumn[85] = 36; // 연금저축소득공제

            pXLColumn[86] = 16; // 근로소득금액
            pXLColumn[87] = 36; // 소기업/소상공인 공제부금 소득공제

            pXLColumn[88] = 16; // 기본(본인)
            pXLColumn[89] = 36; // 청약저축

            pXLColumn[90] = 16; // 기본(배우자)
            pXLColumn[91] = 36; // 주택청약종합저축

            pXLColumn[92] = 10; // 기본(부양인원 - 인원)            
            pXLColumn[93] = 16; // 기본(부양인원 - 금액)
            pXLColumn[94] = 36; // 장기주택마련저축

            pXLColumn[95] = 10; // 추가공제(경로수 - 인원)          
            pXLColumn[96] = 16; // 추가공제(경로수 - 금액)
            pXLColumn[97] = 36; // 근로자주택마련저축

            pXLColumn[98] = 10; // 추가공제(장애인 - 인원)          
            pXLColumn[99] = 16; // 추가공제(장애인 - 금액)
            pXLColumn[100] = 36; // 투자조합출자등 소득공제

            pXLColumn[101] = 16; // 추가공제(부녀세대)
            pXLColumn[102] = 36; // 신용카드등 소득공제

            pXLColumn[103] = 10; // 추가공제(자녀양육 - 인원)        
            pXLColumn[104] = 16; // 추가공제(자녀양육 - 금액)
            pXLColumn[105] = 36; // 우리사주출자

            pXLColumn[106] = 11; // 추가공제(출산입양 - 인원)        
            pXLColumn[107] = 16; // 추가공제(출산입양 - 금액)
            pXLColumn[108] = 36; // 장기주식형저축

            pXLColumn[109] = 36; // 고용유지중소기업소득공제

            pXLColumn[110] = 9; // 다자녀공제(인원)                 
            pXLColumn[111] = 16; // 다자녀공제(금액) 

            pXLColumn[112] = 16; // 국민연금보험료공제               

            pXLColumn[113] = 36; // 그밖의소득공제 계

            pXLColumn[114] = 36; // 종합과세표준

            pXLColumn[115] = 36; // 산출세액

            pXLColumn[116] = 36; // 소득세법

            pXLColumn[117] = 16; // 퇴직연금소득공제                 
            pXLColumn[118] = 36; // 조세특례제한법

            pXLColumn[119] = 16; // 건강보험료                       
            pXLColumn[120] = 16; // 고용보험료                       
            pXLColumn[121] = 16; // 보장성보험                       
            pXLColumn[122] = 16; // 장애인전용 

            pXLColumn[123] = 16; // 특별공제(의료비) 
            pXLColumn[124] = 36; // 세액감면 계  

            pXLColumn[125] = 16; // 특별공제(교육비) 
            pXLColumn[126] = 36; // 근로소득                

            pXLColumn[127] = 16; // 특별공제(주택임차차입금) 
            pXLColumn[128] = 36; // 납세조합공제

            pXLColumn[129] = 16; // 특별공제(월세)

            pXLColumn[130] = 16; // 특별공제(장기주택차입금)
            pXLColumn[131] = 36; // 주택차입금

            pXLColumn[132] = 16; // 특별공제(기부금) 
            pXLColumn[133] = 36; // 기부 정치자금

            pXLColumn[134] = 36; // 외국 납부

            pXLColumn[135] = 16; // 계

            pXLColumn[136] = 16; // 특별공제(표준공제)
            pXLColumn[137] = 36; // 세액공제 계         

            pXLColumn[138] = 16; // 차감소득금액  
            pXLColumn[139] = 36; // 결정세액    
        }

        #endregion;

        #region ----- Array Set 2 ----
        private void SetArray2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_SUPPORT_FAMILY, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[25];
            pXLColumn = new int[25];

            pGDColumn[0]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("MANY_CHILD_DED_COUNT");  // 다자녀 인원수
            pGDColumn[1]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("RELATION_CODE");         // 관계코드         
            pGDColumn[2]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("FAMILY_NAME");           // 성명             
            pGDColumn[3]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("BASE_YN");               // 기본공제         
            pGDColumn[4]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("OLD_YN");                // 경로우대         
            pGDColumn[5]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("BIRTH_YN");              // 출산/입양양육    
            pGDColumn[6]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("DEFORM_YN");             // 장애인           
            pGDColumn[7]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHILD_YN");              // 자녀양육(6세이하)
            pGDColumn[8]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("INSURE_AMT");            // 국세청-보험료    
            pGDColumn[9]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("MEDICAL_AMT");           // 국세청-의료비    
            pGDColumn[10] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("EDU_AMT");               // 국세청-교육비    
            pGDColumn[11] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CREDIT_AMT");            // 국세청-신용카드  
            pGDColumn[12] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHECK_CREDIT_AMT");      // 국세청-직불카드  
            pGDColumn[13] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CASH_AMT");              // 국세청-현금      
            pGDColumn[14] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("DONAT_AMT");             // 국세청-기부금    
            pGDColumn[15] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("NATIONALITY_TYPE");      // 국가타입         
            pGDColumn[16] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("REPRE_NUM");             // 주민번호         
            pGDColumn[17] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("WOMAN_YN");              // 부녀자           
            pGDColumn[18] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_INSURE_AMT");        // 기타-보험료      
            pGDColumn[19] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_MEDICAL_AMT");       // 기타-의료비      
            pGDColumn[20] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_EDU_AMT");           // 기타-교육비      
            pGDColumn[21] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_CREDIT_AMT");        // 기타-신용카드    
            pGDColumn[22] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHECK_ETC_CREDIT_AMT");  // 기타-직불카드    
            pGDColumn[23] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_CASH_AMT");          // 기타-현금        
            pGDColumn[24] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_DONAT_AMT");         // 기타-기부금 

            pXLColumn[0]  = 7;   // 다자녀 인원수
            pXLColumn[1]  = 1;   // 관계코드         
            pXLColumn[2]  = 3;   // 성명             
            pXLColumn[3]  = 9;   // 기본공제         
            pXLColumn[4]  = 11;  // 경로우대         
            pXLColumn[5]  = 13;  // 출산/입양양육    
            pXLColumn[6]  = 15;  // 장애인           
            pXLColumn[7]  = 17;  // 자녀양육(6세이하)
            pXLColumn[8]  = 22;  // 국세청-보험료    
            pXLColumn[9]  = 25;  // 국세청-의료비    
            pXLColumn[10] = 28;  // 국세청-교육비    
            pXLColumn[11] = 31;  // 국세청-신용카드  
            pXLColumn[12] = 34;  // 국세청-직불카드  
            pXLColumn[13] = 37;  // 국세청-현금      
            pXLColumn[14] = 40;  // 국세청-기부금    
            pXLColumn[15] = 1;   // 국가타입         
            pXLColumn[16] = 3;   // 주민번호         
            pXLColumn[17] = 9;   // 부녀자           
            pXLColumn[18] = 22;  // 기타-보험료      
            pXLColumn[19] = 25;  // 기타-의료비      
            pXLColumn[20] = 28;  // 기타-교육비      
            pXLColumn[21] = 31;  // 기타-신용카드    
            pXLColumn[22] = 34;  // 기타-직불카드    
            pXLColumn[23] = 37;  // 기타-현금        
            pXLColumn[24] = 40;  // 기타-기부금
        }

        #endregion;

        #region ----- Array Set 3 -----

        private void SetArray3(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[5];
            pXLColumn = new int[5];

            pGDColumn[0] = pTable.Columns.IndexOf("SAVING_TYPE_NAME");
            pGDColumn[1] = pTable.Columns.IndexOf("BANK_NAME");
            pGDColumn[2] = pTable.Columns.IndexOf("ACCOUNT_NUM");
            pGDColumn[3] = pTable.Columns.IndexOf("SAVING_AMOUNT");
            pGDColumn[4] = pTable.Columns.IndexOf("SAVING_DED_AMOUNT");


            pXLColumn[0] = 1;   //SAVING_TYPE_NAME
            pXLColumn[1] = 8;   //BANK_NAME
            pXLColumn[2] = 17;  //ACCOUNT_NUM
            pXLColumn[3] = 26;  //SAVING_AMOUNT
            pXLColumn[4] = 35;  //SAVING_DED_AMOUNT
        }

        #endregion;

        #region ----- Array Set 4 -----

        private void SetArray4(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[5];
            pXLColumn = new int[5];

            pGDColumn[0] = pTable.Columns.IndexOf("BANK_NAME");
            pGDColumn[1] = pTable.Columns.IndexOf("ACCOUNT_NUM");
            pGDColumn[2] = pTable.Columns.IndexOf("SAVING_COUNT");
            pGDColumn[3] = pTable.Columns.IndexOf("SAVING_AMOUNT");
            pGDColumn[4] = pTable.Columns.IndexOf("SAVING_DED_AMOUNT");


            pXLColumn[0] = 1;   //BANK_NAME
            pXLColumn[1] = 8;   //ACCOUNT_NUM
            pXLColumn[2] = 17;  //SAVING_COUNT
            pXLColumn[3] = 26;  //SAVING_AMOUNT
            pXLColumn[4] = 35;  //SAVING_DED_AMOUNT
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
       
        #region ----- Send ORG ---- 

        private void SendORG()
        {
            //mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
        }

        #endregion;

        #region ----- XLLINE1 -----

        private int XLLine1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, object vPrintDate, object vPrintType)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            //System.DateTime vConvertDateTime = new System.DateTime();
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //----[ 1 page ]------------------------------------------------------------------------------------------------------

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 거주 구분(거주자1/거주자2)
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //거주자1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //거주자 2이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "●");
                    }                    
                }
                else
                {
                    vConvertString = string.Empty;
                    //거주자1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //거주자 2이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 내외국인 구분(내국인1/외국인9)
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //내국인1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //외국인9이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "●");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //내국인1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //외국인9이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 외국인단일세율적용
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "Y") //여1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //부2이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 3), "●");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //여1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //부2이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 3), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 출력 용도 구분
                vXLColumnIndex = 14;
                vObject = vPrintType;
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

                // 세대주 구분(세대주1/세대원2)
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //세대주1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //세대원2이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "●");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //세대주1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //세대원2이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 연말정산구분
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "계속근로") //계속근로1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //중도퇴사2이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "●");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //계속근로1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //중도퇴사2이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 법인명(상호)
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 대표자(성명)    
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 소재지(주소)
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                string sName = vConvertString;

                // 주민번호
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                string sPersonNumber = vConvertString;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 주소
                vGDColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 주(현)근무처명
                vGDColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1근무처명
                vGDColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2근무처명
                vGDColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)사업자번호
                vGDColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1사업잡번호
                vGDColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
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

                // 종(전)2사업잡번호
                vGDColumnIndex = pGDColumn[17];
                vXLColumnIndex = pXLColumn[17];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)근무기간
                vGDColumnIndex = pGDColumn[18];
                vXLColumnIndex = pXLColumn[18];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1근무기간
                vGDColumnIndex = pGDColumn[19];
                vXLColumnIndex = pXLColumn[19];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2근무기간
                vGDColumnIndex = pGDColumn[20];
                vXLColumnIndex = pXLColumn[20];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)감면기간
                vGDColumnIndex = pGDColumn[21];
                vXLColumnIndex = pXLColumn[21];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1감면기간
                vGDColumnIndex = pGDColumn[22];
                vXLColumnIndex = pXLColumn[22];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2감면기간
                vGDColumnIndex = pGDColumn[23];
                vXLColumnIndex = pXLColumn[23];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)급여 
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1급여
                vGDColumnIndex = pGDColumn[25];
                vXLColumnIndex = pXLColumn[25];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2급여
                vGDColumnIndex = pGDColumn[26];
                vXLColumnIndex = pXLColumn[26];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)상여
                vGDColumnIndex = pGDColumn[27];
                vXLColumnIndex = pXLColumn[27];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1상여
                vGDColumnIndex = pGDColumn[28];
                vXLColumnIndex = pXLColumn[28];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2상여
                vGDColumnIndex = pGDColumn[29];
                vXLColumnIndex = pXLColumn[29];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)인정상여 
                vGDColumnIndex = pGDColumn[30];
                vXLColumnIndex = pXLColumn[30];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1인정상여
                vGDColumnIndex = pGDColumn[31];
                vXLColumnIndex = pXLColumn[31];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2인정상여
                vGDColumnIndex = pGDColumn[32];
                vXLColumnIndex = pXLColumn[32];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)주식매수선택권
                vGDColumnIndex = pGDColumn[33];
                vXLColumnIndex = pXLColumn[33];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1주식매수선택권
                vGDColumnIndex = pGDColumn[34];
                vXLColumnIndex = pXLColumn[34];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2주식매수선택권
                vGDColumnIndex = pGDColumn[35];
                vXLColumnIndex = pXLColumn[35];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)우리사주조합인출금
                vGDColumnIndex = pGDColumn[36];
                vXLColumnIndex = pXLColumn[36];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1우리사주조합인출금
                vGDColumnIndex = pGDColumn[37];
                vXLColumnIndex = pXLColumn[37];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2우리사주조합인출금
                vGDColumnIndex = pGDColumn[38];
                vXLColumnIndex = pXLColumn[38];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주(현)계
                vGDColumnIndex = pGDColumn[39];
                vXLColumnIndex = pXLColumn[39];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)1계
                vGDColumnIndex = pGDColumn[40];
                vXLColumnIndex = pXLColumn[40];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 종(전)2계
                vGDColumnIndex = pGDColumn[41];
                vXLColumnIndex = pXLColumn[41];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                //--------------------------------------------------------------------------------------------------------------------
                // II 비과세 및 감면 소득 명세
                //--------------------------------------------------------------------------------------------------------------------

                // 비과세_주(현)국외근로
                vGDColumnIndex = pGDColumn[42];
                vXLColumnIndex = pXLColumn[42];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1국외근로
                vGDColumnIndex = pGDColumn[43];
                vXLColumnIndex = pXLColumn[43];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2국외근로
                vGDColumnIndex = pGDColumn[44];
                vXLColumnIndex = pXLColumn[44];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_주(현)야간근로수당
                vGDColumnIndex = pGDColumn[45];
                vXLColumnIndex = pXLColumn[45];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1야간근로수당
                vGDColumnIndex = pGDColumn[46];
                vXLColumnIndex = pXLColumn[46];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2야간근로수당
                vGDColumnIndex = pGDColumn[47];
                vXLColumnIndex = pXLColumn[47];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_주(현)출산/보육수당
                vGDColumnIndex = pGDColumn[48];
                vXLColumnIndex = pXLColumn[48];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1출산/보육수당
                vGDColumnIndex = pGDColumn[49];
                vXLColumnIndex = pXLColumn[49];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2출산/보육수당
                vGDColumnIndex = pGDColumn[50];
                vXLColumnIndex = pXLColumn[50];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_주(현)외국인근로자
                vGDColumnIndex = pGDColumn[51];
                vXLColumnIndex = pXLColumn[51];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1외국인근로자
                vGDColumnIndex = pGDColumn[52];
                vXLColumnIndex = pXLColumn[52];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2외국인근로자
                vGDColumnIndex = pGDColumn[53];
                vXLColumnIndex = pXLColumn[53];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 6;
                //-------------------------------------------------------------------

                // 비과세_주(현)비과세소득계
                vGDColumnIndex = pGDColumn[54];
                vXLColumnIndex = pXLColumn[54];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1비과세소득계
                vGDColumnIndex = pGDColumn[55];
                vXLColumnIndex = pXLColumn[55];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2비과세소득계
                vGDColumnIndex = pGDColumn[56];
                vXLColumnIndex = pXLColumn[56];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_주(현)감면소득계
                vGDColumnIndex = pGDColumn[57];
                vXLColumnIndex = pXLColumn[57];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)1감면소득계
                vGDColumnIndex = pGDColumn[58];
                vXLColumnIndex = pXLColumn[58];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 비과세_종(전)2감면소득계
                vGDColumnIndex = pGDColumn[59];
                vXLColumnIndex = pXLColumn[59];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                //--------------------------------------------------------------------------------------------------------------------
                // III 세액 명세
                //--------------------------------------------------------------------------------------------------------------------

                // 결정세액_소득세
                vGDColumnIndex = pGDColumn[60];
                vXLColumnIndex = pXLColumn[60];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 결정세액_지방소득세   
                vGDColumnIndex = pGDColumn[61];
                vXLColumnIndex = pXLColumn[61];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 결정세액_농특세
                vGDColumnIndex = pGDColumn[62];
                vXLColumnIndex = pXLColumn[62];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 결정세액_계
                vGDColumnIndex = pGDColumn[63];
                vXLColumnIndex = pXLColumn[63];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)1사업자번호 
                vGDColumnIndex = pGDColumn[64];
                vXLColumnIndex = pXLColumn[64];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)1소득세
                vGDColumnIndex = pGDColumn[65];
                vXLColumnIndex = pXLColumn[65];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
  
                // 기납부세액_종(전)1지방소득세
                vGDColumnIndex = pGDColumn[66];
                vXLColumnIndex = pXLColumn[66];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)1농특세
                vGDColumnIndex = pGDColumn[67];
                vXLColumnIndex = pXLColumn[67];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
   
                // 기납부세액_종(전)1계
                vGDColumnIndex = pGDColumn[68];
                vXLColumnIndex = pXLColumn[68];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)2사업자번호 
                vGDColumnIndex = pGDColumn[69];
                vXLColumnIndex = pXLColumn[69];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)2소득세
                vGDColumnIndex = pGDColumn[70];
                vXLColumnIndex = pXLColumn[70];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)2지방소득세
                vGDColumnIndex = pGDColumn[71];
                vXLColumnIndex = pXLColumn[71];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)2농특세
                vGDColumnIndex = pGDColumn[72];
                vXLColumnIndex = pXLColumn[72];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_종(전)2계
                vGDColumnIndex = pGDColumn[73];
                vXLColumnIndex = pXLColumn[73];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 기납부세액_주(현)소득세 
                vGDColumnIndex = pGDColumn[74];
                vXLColumnIndex = pXLColumn[74];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_주(현)지방소득세
                vGDColumnIndex = pGDColumn[75];
                vXLColumnIndex = pXLColumn[75];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                //기납부세액_주(현)농특세
                vGDColumnIndex = pGDColumn[76];
                vXLColumnIndex = pXLColumn[76];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기납부세액_주(현)계
                vGDColumnIndex = pGDColumn[77];
                vXLColumnIndex = pXLColumn[77];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 차감징수세액_소득세 
                vGDColumnIndex = pGDColumn[78];
                vXLColumnIndex = pXLColumn[78];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 차감징수세액_지방소득세
                vGDColumnIndex = pGDColumn[79];
                vXLColumnIndex = pXLColumn[79];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 차감징수세액_농특세
                vGDColumnIndex = pGDColumn[80];
                vXLColumnIndex = pXLColumn[80];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 차감징수세액_계
                vGDColumnIndex = pGDColumn[81];
                vXLColumnIndex = pXLColumn[81];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 6;
                //-------------------------------------------------------------------

                // 날짜
                vXLColumnIndex = 28;
                vObject = vPrintDate;
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
                vXLine = vXLine + 9;
                //-------------------------------------------------------------------

                //----[ 2 page ]------------------------------------------------------------------------------------------------------

                // 2page 상단에 소득자 성명 및 주민번호 출력 표시되는 부분
                string sPrintPersinInfo = sName + "(" + sPersonNumber + ")";
                mPrinting.XLSetCell(vXLine, 24, sPrintPersinInfo);

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 총급여
                vGDColumnIndex = pGDColumn[82];
                vXLColumnIndex = pXLColumn[82];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 개인연금저축소득공제
                vGDColumnIndex = pGDColumn[83];
                vXLColumnIndex = pXLColumn[83];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 근로소득공제
                vGDColumnIndex = pGDColumn[84];
                vXLColumnIndex = pXLColumn[84];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 연금저축소득공제
                vGDColumnIndex = pGDColumn[85];
                vXLColumnIndex = pXLColumn[85];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 근로소득금액
                vGDColumnIndex = pGDColumn[86];
                vXLColumnIndex = pXLColumn[86];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 소기업/소상공인 공제부금 소득공제
                vGDColumnIndex = pGDColumn[87];
                vXLColumnIndex = pXLColumn[87];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 기본(본인)
                vGDColumnIndex = pGDColumn[88];
                vXLColumnIndex = pXLColumn[88];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 청약저축
                vGDColumnIndex = pGDColumn[89];
                vXLColumnIndex = pXLColumn[89];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 기본(배우자)
                vGDColumnIndex = pGDColumn[90];
                vXLColumnIndex = pXLColumn[90];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주택청약종합저축
                vGDColumnIndex = pGDColumn[91];
                vXLColumnIndex = pXLColumn[91];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 기본(부양인원 - 인원)  
                vGDColumnIndex = pGDColumn[92];
                vXLColumnIndex = pXLColumn[92];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기본(부양인원 - 금액) 
                vGDColumnIndex = pGDColumn[93];
                vXLColumnIndex = pXLColumn[93];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 장기주택마련저축
                vGDColumnIndex = pGDColumn[94];
                vXLColumnIndex = pXLColumn[94];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 추가공제(경로수 - 인원)
                vGDColumnIndex = pGDColumn[95];
                vXLColumnIndex = pXLColumn[95];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 추가공제(경로수 - 금액)
                vGDColumnIndex = pGDColumn[96];
                vXLColumnIndex = pXLColumn[96];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 근로자주택마련저축
                vGDColumnIndex = pGDColumn[97];
                vXLColumnIndex = pXLColumn[97];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 추가공제(장애인 - 인원)
                vGDColumnIndex = pGDColumn[98];
                vXLColumnIndex = pXLColumn[98];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 추가공제(장애인 - 금액)
                vGDColumnIndex = pGDColumn[99];
                vXLColumnIndex = pXLColumn[99];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 투자조합출자등 소득공제
                vGDColumnIndex = pGDColumn[100];
                vXLColumnIndex = pXLColumn[100];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 추가공제(부녀세대)
                vGDColumnIndex = pGDColumn[101];
                vXLColumnIndex = pXLColumn[101];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 신용카드등 소득공제
                vGDColumnIndex = pGDColumn[102];
                vXLColumnIndex = pXLColumn[102];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 추가공제(자녀양육 - 인원)    
                vGDColumnIndex = pGDColumn[103];
                vXLColumnIndex = pXLColumn[103];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 추가공제(자녀양육 - 금액)
                vGDColumnIndex = pGDColumn[104];
                vXLColumnIndex = pXLColumn[104];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 우리사주출자
                vGDColumnIndex = pGDColumn[105];
                vXLColumnIndex = pXLColumn[105];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 추가공제(출산입양 - 인원) 
                vGDColumnIndex = pGDColumn[106];
                vXLColumnIndex = pXLColumn[106];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 추가공제(출산입양 - 금액)
                vGDColumnIndex = pGDColumn[107];
                vXLColumnIndex = pXLColumn[107];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 장기주식형저축
                vGDColumnIndex = pGDColumn[108];
                vXLColumnIndex = pXLColumn[108];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 고용유지중소기업소득공제
                vGDColumnIndex = pGDColumn[109];
                vXLColumnIndex = pXLColumn[109];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 다자녀공제(인원)  
                vGDColumnIndex = pGDColumn[110];
                vXLColumnIndex = pXLColumn[110];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 다자녀공제(금액)  
                vGDColumnIndex = pGDColumn[111];
                vXLColumnIndex = pXLColumn[111];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 국민연금보험료공제
                vGDColumnIndex = pGDColumn[112];
                vXLColumnIndex = pXLColumn[112];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 4;
                //-------------------------------------------------------------------
                // 그 밖의 소득공제 계
                vGDColumnIndex = pGDColumn[113];
                vXLColumnIndex = pXLColumn[113];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 종합소득 과세표준
                vGDColumnIndex = pGDColumn[114];
                vXLColumnIndex = pXLColumn[114];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 산출세액
                vGDColumnIndex = pGDColumn[115];
                vXLColumnIndex = pXLColumn[115];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 소득세법
                vGDColumnIndex = pGDColumn[116];
                vXLColumnIndex = pXLColumn[116];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 근로자퇴직연금소득공제
                vGDColumnIndex = pGDColumn[117];
                vXLColumnIndex = pXLColumn[117];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 조세특례제한법
                vGDColumnIndex = pGDColumn[118];
                vXLColumnIndex = pXLColumn[118];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 건강보험료
                vGDColumnIndex = pGDColumn[119];
                vXLColumnIndex = pXLColumn[119];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 고용보험료
                vGDColumnIndex = pGDColumn[120];
                vXLColumnIndex = pXLColumn[120];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 보장성 보험
                vGDColumnIndex = pGDColumn[121];
                vXLColumnIndex = pXLColumn[121];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 장애인 전용
                vGDColumnIndex = pGDColumn[122];
                vXLColumnIndex = pXLColumn[122];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 의료비
                vGDColumnIndex = pGDColumn[123];
                vXLColumnIndex = pXLColumn[123];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 세액감면 계
                vGDColumnIndex = pGDColumn[124];
                vXLColumnIndex = pXLColumn[124];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 교육비
                vGDColumnIndex = pGDColumn[125];
                vXLColumnIndex = pXLColumn[125];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 근로소득
                vGDColumnIndex = pGDColumn[126];
                vXLColumnIndex = pXLColumn[126];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 주택임차차입금 원리금 상환액
                vGDColumnIndex = pGDColumn[127];
                vXLColumnIndex = pXLColumn[127];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 납세조합 공제
                vGDColumnIndex = pGDColumn[128];
                vXLColumnIndex = pXLColumn[128];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 월세액
                vGDColumnIndex = pGDColumn[129];
                vXLColumnIndex = pXLColumn[129];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 장기주택저당 차입금 이자 상환액
                vGDColumnIndex = pGDColumn[130];
                vXLColumnIndex = pXLColumn[130];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주택차입금
                vGDColumnIndex = pGDColumn[131];
                vXLColumnIndex = pXLColumn[131];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 기부금
                vGDColumnIndex = pGDColumn[132];
                vXLColumnIndex = pXLColumn[132];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 기부 정치자금
                vGDColumnIndex = pGDColumn[133];
                vXLColumnIndex = pXLColumn[133];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 외국납부
                vGDColumnIndex = pGDColumn[134];
                vXLColumnIndex = pXLColumn[134];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------
                // 계
                vGDColumnIndex = pGDColumn[135];
                vXLColumnIndex = pXLColumn[135];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 표준공제
                vGDColumnIndex = pGDColumn[136];
                vXLColumnIndex = pXLColumn[136];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 세액공제 계
                vGDColumnIndex = pGDColumn[137];
                vXLColumnIndex = pXLColumn[137];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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
                // 차감소득금액
                vGDColumnIndex = pGDColumn[138];
                vXLColumnIndex = pXLColumn[138];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 결정세액
                vGDColumnIndex = pGDColumn[139];
                vXLColumnIndex = pXLColumn[139];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

        #region ----- XLLINE2 -----
        private int XLLine2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_SUPPORT_FAMILY, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //----[ 3 page ]------------------------------------------------------------------------------------------------------

                if (pGridRow == 0)
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 10;
                    //-------------------------------------------------------------------
                    // 다자녀 인원 수
                    vGDColumnIndex = pGDColumn[0];
                    vXLColumnIndex = pXLColumn[0];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
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

                    // 관계코드
                    vGDColumnIndex = pGDColumn[1];
                    vXLColumnIndex = pXLColumn[1];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 성명
                    vGDColumnIndex = pGDColumn[2];
                    vXLColumnIndex = pXLColumn[2];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기본공제
                    vGDColumnIndex = pGDColumn[3];
                    vXLColumnIndex = pXLColumn[3];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 경로우대
                    vGDColumnIndex = pGDColumn[4];
                    vXLColumnIndex = pXLColumn[4];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 출산/입양양육
                    vGDColumnIndex = pGDColumn[5];
                    vXLColumnIndex = pXLColumn[5];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 장애인
                    vGDColumnIndex = pGDColumn[6];
                    vXLColumnIndex = pXLColumn[6];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 자녀양육(6세이하)
                    vGDColumnIndex = pGDColumn[7];
                    vXLColumnIndex = pXLColumn[7];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-보험료
                    vGDColumnIndex = pGDColumn[8];
                    vXLColumnIndex = pXLColumn[8];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-의료비
                    vGDColumnIndex = pGDColumn[9];
                    vXLColumnIndex = pXLColumn[9];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-교육비
                    vGDColumnIndex = pGDColumn[10];
                    vXLColumnIndex = pXLColumn[10];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-신용카드
                    vGDColumnIndex = pGDColumn[11];
                    vXLColumnIndex = pXLColumn[11];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-직불카드
                    vGDColumnIndex = pGDColumn[12];
                    vXLColumnIndex = pXLColumn[12];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-현금
                    vGDColumnIndex = pGDColumn[13];
                    vXLColumnIndex = pXLColumn[13];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-기부금
                    vGDColumnIndex = pGDColumn[14];
                    vXLColumnIndex = pXLColumn[14];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국가타입
                    vGDColumnIndex = pGDColumn[15];
                    vXLColumnIndex = pXLColumn[15];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 주민번호
                    vGDColumnIndex = pGDColumn[16];
                    vXLColumnIndex = pXLColumn[16];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 부녀자
                    vGDColumnIndex = pGDColumn[17];
                    vXLColumnIndex = pXLColumn[17];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-보험료
                    vGDColumnIndex = pGDColumn[18];
                    vXLColumnIndex = pXLColumn[18];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-의료비
                    vGDColumnIndex = pGDColumn[19];
                    vXLColumnIndex = pXLColumn[19];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-교육비
                    vGDColumnIndex = pGDColumn[20];
                    vXLColumnIndex = pXLColumn[20];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-신용카드
                    vGDColumnIndex = pGDColumn[21];
                    vXLColumnIndex = pXLColumn[21];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-직불카드
                    vGDColumnIndex = pGDColumn[22];
                    vXLColumnIndex = pXLColumn[22];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-현금
                    vGDColumnIndex = pGDColumn[23];
                    vXLColumnIndex = pXLColumn[23];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-기부금
                    vGDColumnIndex = pGDColumn[24];
                    vXLColumnIndex = pXLColumn[24];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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
                }
                else 
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 1;
                    //-------------------------------------------------------------------

                    // 관계코드
                    vGDColumnIndex = pGDColumn[1];
                    vXLColumnIndex = pXLColumn[1];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 성명
                    vGDColumnIndex = pGDColumn[2];
                    vXLColumnIndex = pXLColumn[2];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기본공제
                    vGDColumnIndex = pGDColumn[3];
                    vXLColumnIndex = pXLColumn[3];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 경로우대
                    vGDColumnIndex = pGDColumn[4];
                    vXLColumnIndex = pXLColumn[4];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 출산/입양양육
                    vGDColumnIndex = pGDColumn[5];
                    vXLColumnIndex = pXLColumn[5];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 장애인
                    vGDColumnIndex = pGDColumn[6];
                    vXLColumnIndex = pXLColumn[6];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 자녀양육(6세이하)
                    vGDColumnIndex = pGDColumn[7];
                    vXLColumnIndex = pXLColumn[7];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-보험료
                    vGDColumnIndex = pGDColumn[8];
                    vXLColumnIndex = pXLColumn[8];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-의료비
                    vGDColumnIndex = pGDColumn[9];
                    vXLColumnIndex = pXLColumn[9];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-교육비
                    vGDColumnIndex = pGDColumn[10];
                    vXLColumnIndex = pXLColumn[10];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-신용카드
                    vGDColumnIndex = pGDColumn[11];
                    vXLColumnIndex = pXLColumn[11];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-직불카드
                    vGDColumnIndex = pGDColumn[12];
                    vXLColumnIndex = pXLColumn[12];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-현금
                    vGDColumnIndex = pGDColumn[13];
                    vXLColumnIndex = pXLColumn[13];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국세청-기부금
                    vGDColumnIndex = pGDColumn[14];
                    vXLColumnIndex = pXLColumn[14];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 국가타입
                    vGDColumnIndex = pGDColumn[15];
                    vXLColumnIndex = pXLColumn[15];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 주민번호
                    vGDColumnIndex = pGDColumn[16];
                    vXLColumnIndex = pXLColumn[16];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 부녀자
                    vGDColumnIndex = pGDColumn[17];
                    vXLColumnIndex = pXLColumn[17];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-보험료
                    vGDColumnIndex = pGDColumn[18];
                    vXLColumnIndex = pXLColumn[18];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-의료비
                    vGDColumnIndex = pGDColumn[19];
                    vXLColumnIndex = pXLColumn[19];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-교육비
                    vGDColumnIndex = pGDColumn[20];
                    vXLColumnIndex = pXLColumn[20];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-신용카드
                    vGDColumnIndex = pGDColumn[21];
                    vXLColumnIndex = pXLColumn[21];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-직불카드
                    vGDColumnIndex = pGDColumn[22];
                    vXLColumnIndex = pXLColumn[22];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-현금
                    vGDColumnIndex = pGDColumn[23];
                    vXLColumnIndex = pXLColumn[23];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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

                    // 기타-기부금
                    vGDColumnIndex = pGDColumn[24];
                    vXLColumnIndex = pXLColumn[24];
                    vObject = pGrid_SUPPORT_FAMILY.GetCellValue(pGridRow, vGDColumnIndex);
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
                }
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

        #region ----- Header Write Method -----

        private int XLHeader_PRINT_SAVING_INFO(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, int pGridRow, int pXLine, int[] pGDColumn)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");


                // 법인명(상호)
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = 8;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 사업자등록번호
                vGDColumnIndex = pGDColumn[7];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    string vVAT_NUMBER_1 = vConvertString.Substring(0, 1);
                    string vVAT_NUMBER_2 = vConvertString.Substring(1, 1);
                    string vVAT_NUMBER_3 = vConvertString.Substring(2, 1);
                    
                    string vVAT_NUMBER_4 = vConvertString.Substring(4, 1);
                    string vVAT_NUMBER_5 = vConvertString.Substring(5, 1);
                    
                    string vVAT_NUMBER_6 = vConvertString.Substring(7, 1);
                    string vVAT_NUMBER_7 = vConvertString.Substring(8, 1);
                    string vVAT_NUMBER_8 = vConvertString.Substring(9, 1);
                    string vVAT_NUMBER_9 = vConvertString.Substring(10, 1);
                    string vVAT_NUMBER_10 = vConvertString.Substring(11, 1);

                    mPrinting.XLSetCell(vXLine, 29, vVAT_NUMBER_1);
                    mPrinting.XLSetCell(vXLine, 30, vVAT_NUMBER_2);
                    mPrinting.XLSetCell(vXLine, 31, vVAT_NUMBER_3);

                    mPrinting.XLSetCell(vXLine, 34, vVAT_NUMBER_4);
                    mPrinting.XLSetCell(vXLine, 35, vVAT_NUMBER_5);

                    mPrinting.XLSetCell(vXLine, 39, vVAT_NUMBER_6);
                    mPrinting.XLSetCell(vXLine, 40, vVAT_NUMBER_7);
                    mPrinting.XLSetCell(vXLine, 41, vVAT_NUMBER_8);
                    mPrinting.XLSetCell(vXLine, 42, vVAT_NUMBER_9);
                    mPrinting.XLSetCell(vXLine, 43, vVAT_NUMBER_10);
                }
                else
                {
                    vConvertString = string.Empty;

                    mPrinting.XLSetCell(vXLine, 29, vConvertString);
                    mPrinting.XLSetCell(vXLine, 30, vConvertString);
                    mPrinting.XLSetCell(vXLine, 31, vConvertString);

                    mPrinting.XLSetCell(vXLine, 34, vConvertString);
                    mPrinting.XLSetCell(vXLine, 35, vConvertString);

                    mPrinting.XLSetCell(vXLine, 39, vConvertString);
                    mPrinting.XLSetCell(vXLine, 40, vConvertString);
                    mPrinting.XLSetCell(vXLine, 41, vConvertString);
                    mPrinting.XLSetCell(vXLine, 42, vConvertString);
                    mPrinting.XLSetCell(vXLine, 43, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 성명
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = 8;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 주민번호
                vGDColumnIndex = pGDColumn[10];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    string vREPRE_NUM_1 = vConvertString.Substring(0, 1);
                    string vREPRE_NUM_2 = vConvertString.Substring(1, 1);
                    string vREPRE_NUM_3 = vConvertString.Substring(2, 1);
                    string vREPRE_NUM_4 = vConvertString.Substring(3, 1);
                    string vREPRE_NUM_5 = vConvertString.Substring(4, 1);
                    string vREPRE_NUM_6 = vConvertString.Substring(5, 1);
                    
                    string vREPRE_NUM_7 = vConvertString.Substring(7, 1);
                    string vREPRE_NUM_8 = vConvertString.Substring(8, 1);
                    string vREPRE_NUM_9 = vConvertString.Substring(9, 1);
                    string vREPRE_NUM_10 = vConvertString.Substring(10, 1);
                    string vREPRE_NUM_11 = vConvertString.Substring(11, 1);
                    string vREPRE_NUM_12 = vConvertString.Substring(12, 1);
                    string vREPRE_NUM_13 = vConvertString.Substring(13, 1);

                    mPrinting.XLSetCell(vXLine, 29, vREPRE_NUM_1);
                    mPrinting.XLSetCell(vXLine, 30, vREPRE_NUM_2);
                    mPrinting.XLSetCell(vXLine, 31, vREPRE_NUM_3);
                    mPrinting.XLSetCell(vXLine, 32, vREPRE_NUM_4);
                    mPrinting.XLSetCell(vXLine, 33, vREPRE_NUM_5);
                    mPrinting.XLSetCell(vXLine, 34, vREPRE_NUM_6);

                    mPrinting.XLSetCell(vXLine, 37, vREPRE_NUM_7);
                    mPrinting.XLSetCell(vXLine, 38, vREPRE_NUM_8);
                    mPrinting.XLSetCell(vXLine, 39, vREPRE_NUM_9);
                    mPrinting.XLSetCell(vXLine, 40, vREPRE_NUM_10);
                    mPrinting.XLSetCell(vXLine, 41, vREPRE_NUM_11);
                    mPrinting.XLSetCell(vXLine, 42, vREPRE_NUM_12);
                    mPrinting.XLSetCell(vXLine, 43, vREPRE_NUM_13);
                }
                else
                {
                    vConvertString = string.Empty;

                    mPrinting.XLSetCell(vXLine, 29, vConvertString);
                    mPrinting.XLSetCell(vXLine, 30, vConvertString);
                    mPrinting.XLSetCell(vXLine, 31, vConvertString);
                    mPrinting.XLSetCell(vXLine, 32, vConvertString);
                    mPrinting.XLSetCell(vXLine, 33, vConvertString);
                    mPrinting.XLSetCell(vXLine, 34, vConvertString);

                    mPrinting.XLSetCell(vXLine, 37, vConvertString);
                    mPrinting.XLSetCell(vXLine, 38, vConvertString);
                    mPrinting.XLSetCell(vXLine, 39, vConvertString);
                    mPrinting.XLSetCell(vXLine, 40, vConvertString);
                    mPrinting.XLSetCell(vXLine, 41, vConvertString);
                    mPrinting.XLSetCell(vXLine, 42, vConvertString);
                    mPrinting.XLSetCell(vXLine, 43, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 주소
                vGDColumnIndex = pGDColumn[11];
                vXLColumnIndex = 8;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 개인 전화번호
                vGDColumnIndex = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TELEPHON_NO");
                vXLColumnIndex = 36;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 사업장 소재지
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = 8;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

                // 사업장 전화번호
                vGDColumnIndex = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TEL_NUMBER");
                vXLColumnIndex = 36;
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
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

        #region ----- XLLINE3 -----

        private int XLLine3(System.Data.DataTable pTable, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                // 저축TYPE명[저축구분]
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
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

                // 금융기관명
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
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

                // 계좌번호
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
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

                // 불입금액
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 공제금액
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,##0}", vConvertDecimal);
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

        #region ----- XLLINE4 -----

        private int XLLine4(System.Data.DataTable pTable, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                // 금융기관명
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
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

                // 계좌번호
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
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

                // 납입연차
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 불입금액
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,##0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 공제금액
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pTable.Rows[pGridRow][vGDColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,##0}", vConvertDecimal);
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

        //30장씩
        #region ----- Excel Main Wirte  Method ----

        public int WriteMain(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX
                           , InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_SUPPORT_FAMILY
                           , InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_PRINT_SAVING_INFO_2
                           , InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_PRINT_SAVING_INFO_3
                           , InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_PRINT_SAVING_INFO_4
                           , InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter_PRINT_SAVING_INFO_5
                           , object vPrintDate
                           , object vPrintType
                           , string pOutChoice
                           , decimal pPrintPage)
        {
            string vMessageText = string.Empty;
            mCopyLineSUM = 1;
            mPageNumber = 0;            

            int[] vGDColumn_1;
            int[] vXLColumn_1;

            int[] vGDColumn_2;
            int[] vXLColumn_2;

            int[] vGDColumn_3;
            int[] vXLColumn_3;

            int[] vGDColumn_4;
            int[] vXLColumn_4;

            int vTotalRow1 = pGrid_WITHHOLDING_TAX.RowCount;
            int vTotalRow2 = pGrid_SUPPORT_FAMILY.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            //int vSecondPrinting = 9; //1인당 3페이지이므로, 3*10=30번째에 인쇄
            int vCountPrinting = 0;

            SetArray1(pGrid_WITHHOLDING_TAX, out vGDColumn_1, out vXLColumn_1);
            SetArray2(pGrid_SUPPORT_FAMILY, out vGDColumn_2, out vXLColumn_2);
            SetArray3(pAdapter_PRINT_SAVING_INFO_2.OraSelectData, out vGDColumn_3, out vXLColumn_3);
            SetArray4(pAdapter_PRINT_SAVING_INFO_5.OraSelectData, out vGDColumn_4, out vXLColumn_4);

            bool isOpen = XLFileOpen();

            for (int vRow1 = 0; vRow1 < vTotalRow1; vRow1++)
            {
                vRowCount++;
                pGrid_WITHHOLDING_TAX.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("{0} - Printing : {1}/{2}", vPrintType, vRowCount, vTotalRow1);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                if (isOpen == true)
                {
                    vCountPrinting++;

                    mCopyLineSUM = CopyAndPaste_1(mCopyLineSUM);
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX_1) + (mPrintingLineSTART_1 - 1);

                    pGrid_WITHHOLDING_TAX.CurrentCellMoveTo(vRow1, 0);
                    pGrid_WITHHOLDING_TAX.Focus();
                    pGrid_WITHHOLDING_TAX.CurrentCellActivate(vRow1, 0);

                    vMessageText = string.Format("{0} - {1}", vMessageText, "근로소득원천징수영수증");
                    mAppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    // 근로소득원천징수영수증 page 1 - 2.
                    //int vLinePrinting_1 = vPrintingLine + 3;
                    vPrintingLine = XLLine1(pGrid_WITHHOLDING_TAX, vRow1, vPrintingLine, vGDColumn_1, vXLColumn_1, vPrintDate, vPrintType);
                    //---------------------------------------------------------------------------------------------------------------------

                    vMessageText = string.Format("{0} - {1}", vMessageText, "부양가족내역");
                    mAppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    // 부양가족내역 page 3.
                    int vPrintingLine_2 = vPrintingLine + 8;
                    for (int vRow2 = 0; vRow2 < vTotalRow2; vRow2++)
                    {
                        vPrintingLine = XLLine2(pGrid_SUPPORT_FAMILY, vRow2, vPrintingLine, vGDColumn_2, vXLColumn_2);
                    }
                    //---------------------------------------------------------------------------------------------------------------------

                    //연금/저축 등 소득공재 명세서 Page 5
                    int vCountRow_2 = 0;
                    int vCountRow_3 = 0;
                    int vCountRow_4 = 0;
                    int vCountRow_5 = 0;
                    if (pAdapter_PRINT_SAVING_INFO_2.OraSelectData.Rows != null)
                    {
                        vCountRow_2 = pAdapter_PRINT_SAVING_INFO_2.OraSelectData.Rows.Count;
                    }
                    if (pAdapter_PRINT_SAVING_INFO_3.OraSelectData.Rows != null)
                    {
                        vCountRow_3 = pAdapter_PRINT_SAVING_INFO_3.OraSelectData.Rows.Count;
                    }
                    if (pAdapter_PRINT_SAVING_INFO_4.OraSelectData.Rows != null)
                    {
                        vCountRow_4 = pAdapter_PRINT_SAVING_INFO_4.OraSelectData.Rows.Count;
                    }
                    if (pAdapter_PRINT_SAVING_INFO_5.OraSelectData.Rows != null)
                    {
                        vCountRow_5 = pAdapter_PRINT_SAVING_INFO_5.OraSelectData.Rows.Count;
                    }

                    mCopyLineSUM = CopyAndPaste_2(mCopyLineSUM);
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX_2) + (mPrintingLineSTART_2 - 1);

                    if (vCountRow_2 > 0 || vCountRow_3 > 0 || vCountRow_4 > 0 || vCountRow_5 > 0)
                    {
                        vMessageText = string.Format("{0} - {1}", vMessageText, "연금/저축 소득공제");
                        mAppInterface.OnAppMessageEvent(vMessageText);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLHeader_PRINT_SAVING_INFO(pGrid_WITHHOLDING_TAX, vRow1, vPrintingLine, vGDColumn_1);

                        vPrintingLine = vPrintingLine + 5;
                        if (vCountRow_2 > 0)
                        {
                            if (vCountRow_2 > 6)
                            {
                                vCountRow_2 = 6;
                            }
                            for (int vRow3 = 0; vRow3 < vCountRow_2; vRow3++)
                            {
                                vPrintingLine = XLLine3(pAdapter_PRINT_SAVING_INFO_2.OraSelectData, vRow3, vPrintingLine, vGDColumn_3, vXLColumn_3);
                            }

                            vCountRow_2 = 6 - vCountRow_2; //6줄에서 출력되지 않은 줄수
                            vPrintingLine = vPrintingLine + vCountRow_2; //출력되지 않은 수 만큼 더함, 다음 출력 위치를 위해
                        }

                        vPrintingLine = vPrintingLine + 5;
                        if (vCountRow_3 > 0)
                        {
                            if (vCountRow_3 > 6)
                            {
                                vCountRow_3 = 6;
                            }
                            for (int vRow4 = 0; vRow4 < vCountRow_3; vRow4++)
                            {
                                vPrintingLine = XLLine3(pAdapter_PRINT_SAVING_INFO_3.OraSelectData, vRow4, vPrintingLine, vGDColumn_3, vXLColumn_3);
                            }

                            vCountRow_3 = 6 - vCountRow_3;
                            vPrintingLine = vPrintingLine + vCountRow_3;
                        }

                        vPrintingLine = vPrintingLine + 5;
                        if (vCountRow_4 > 0)
                        {
                            if (vCountRow_4 > 6)
                            {
                                vCountRow_4 = 6;
                            }
                            for (int vRow5 = 0; vRow5 < vCountRow_4; vRow5++)
                            {
                                vPrintingLine = XLLine3(pAdapter_PRINT_SAVING_INFO_4.OraSelectData, vRow5, vPrintingLine, vGDColumn_3, vXLColumn_3);
                            }

                            vCountRow_4 = 6 - vCountRow_4;
                            vPrintingLine = vPrintingLine + vCountRow_4;
                        }

                        vPrintingLine = vPrintingLine + 5;
                        if (vCountRow_5 > 0)
                        {
                            if (vCountRow_5 > 6)
                            {
                                vCountRow_5 = 6;
                            }
                            for (int vRow6 = 0; vRow6 < vCountRow_5; vRow6++)
                            {
                                vPrintingLine = XLLine4(pAdapter_PRINT_SAVING_INFO_5.OraSelectData, vRow6, vPrintingLine, vGDColumn_4, vXLColumn_4);
                            }
                        }
                    }
                    //---------------------------------------------------------------------------------------------------------------------

                    //if (vSecondPrinting < vCountPrinting)
                    //{
                    //    if (pOutChoice == "PRINT")
                    //    {
                    //        Printing(1, vSecondPrinting);
                    //    }
                    //    else if (pOutChoice == "FILE")
                    //    {
                    //        SAVE("ADJUST_");
                    //    }

                    //    mPrinting.XLOpenFileClose();
                    //    isOpen = XLFileOpen();

                    //    vCountPrinting = 0;
                    //    vPrintingLine = 1;
                    //    mCopyLineSUM = 1;
                    //}
                    //else if (vTotalRow1 == vRowCount)
                    //{
                    //    //Printing(1, (vCountPrinting * 3)); //vSecondPrinting, (vRowCount * 3) 1인은 1쪽부터 해당 쪽수까지 한페이지로 보기 때문에 *2를 한 것임.
                    //    if (pOutChoice == "PRINT")
                    //    {
                    //        Printing(1, (vCountPrinting * 3)); //vSecondPrinting, (vRowCount * 3) 1인은 1쪽부터 해당 쪽수까지 한페이지로 보기 때문에 *2를 한 것임.
                    //    }
                    //    else if (pOutChoice == "FILE")
                    //    {
                    //        SAVE("ADJUST_");
                    //    }
                    //}

                    if (vTotalRow1 == vRowCount)
                    {
                        if (pOutChoice == "PRINT")
                        {
                            if (pPrintPage == 0)
                            {
                                Printing(1, mPageNumber);
                            }
                            else if (pPrintPage == 1)
                            {
                                Printing(1, 1);
                            }
                            else if (pPrintPage == 2)
                            {
                                Printing(2, 2);
                            }
                            else if (pPrintPage == 3)
                            {
                                Printing(3, 3);
                            }
                            else if (pPrintPage == 4)
                            {
                                if (mPageNumber == 4)
                                {
                                    Printing(4, 4);
                                }
                            }

                            vMessageText = string.Format("{0} - {1}", vMessageText, pPrintPage);
                            mAppInterface.OnAppMessageEvent(vMessageText);
                            System.Windows.Forms.Application.DoEvents();
                        }
                        else if (pOutChoice == "FILE")
                        {
                            SAVE("ADJUST_");
                        }
                    }
                }
            }

            mPrinting.XLOpenFileClose();

            return mPageNumber;
        }

        #endregion;

        #endregion;

        #region ----- Copy&Paste Sheet Method 1 ----

        //첫번째 페이지 복사
        private int CopyAndPaste_1(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX_1;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            mPrinting.XLActiveSheet("SourceTab1");

            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX_1, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber = mPageNumber + 3; //페이지 번호

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method 2 ----

        //두번째 페이지 복사
        private int CopyAndPaste_2(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX_2;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            mPrinting.XLActiveSheet("SourceTab2");

            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX_2, mCopyColumnEND);
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND);
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

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