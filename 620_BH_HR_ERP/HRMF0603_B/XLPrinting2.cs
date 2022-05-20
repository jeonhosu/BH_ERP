using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace HRMF0603
{
    public class XLPrinting2
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 1;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 62; //복사되어질 행의 범위

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

        public XLPrinting2(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface, InfoSummit.Win.ControlAdv.ISMessageAdapter pMessageAdapter)
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

        private void SetArray(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[127];
            pXLColumn = new int[127];

            //--------------------------------------------------------------------------------------------------------------------
            pGDColumn[0]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RESIDENT_TYPE");             // 거주 구분(거주자1/거주자2)                           
            pGDColumn[1]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NATIONALITY_TYPE");          // 내외국인 구분(내국인1/외국인9)                       
            pGDColumn[2]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("VAT_NUMBER");                // 사업자등록번호                                       
            pGDColumn[3]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CORP_NAME");                 // 법인명(상호)                                         
            pGDColumn[4]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRESIDENT_NAME");            // 대표자(성명)                                         
            pGDColumn[5]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ORG_ADDRESS");               // 소재지(주소)                                         
            pGDColumn[6]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NAME");                      // 성명                                                 
            pGDColumn[7]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REPRE_NUM");                 // 주민번호                                             
            pGDColumn[8]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADDRESS");                   // 주소                                                 
            pGDColumn[9]   = pGrid_WITHHOLDING_TAX.GetColumnToIndex("START_RETIRE_DATE");         // 귀속연도 시작 일자                                   
            pGDColumn[10]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_NAME");               // 퇴직사유                                             
            pGDColumn[11]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LAST_RETIRE_DATE");          // 귀속연도 마지막 일자(퇴직일자)                       
            pGDColumn[12]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TAX1");               // 퇴직세액공제적용1                                    
            pGDColumn[13]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TAX2");               // 퇴직세액공제적용2                                    
            pGDColumn[14]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TAX3");               // 퇴직세액공제적용3                                    
            pGDColumn[15]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TAX4");               // 퇴직세액공제적용 합계                                
            pGDColumn[16]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME1");           // 근무처명1                                            
            pGDColumn[17]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME2");           // 근무처명2                                            
            pGDColumn[18]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME3");           // 근무처명3                                            
            pGDColumn[19]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME4");           // 근무처명 합계                                        
            pGDColumn[20]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER1");          // 사업자등록번호1                                      
            pGDColumn[21]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER2");          // 사업자등록번호2                                      
            pGDColumn[22]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER3");          // 사업자등록번호3                                      
            pGDColumn[23]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER4");          // 사업자등록번호 합계                                  
            pGDColumn[24]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TOTAL_AMOUNT1");      // 퇴직급여1                                            
            pGDColumn[25]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TOTAL_AMOUNT2");      // 퇴직급여2                                            
            pGDColumn[26]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TOTAL_AMOUNT3");      // 퇴직급여3                                            
            pGDColumn[27]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_TOTAL_AMOUNT4");      // 퇴직급여 합계                                        
            pGDColumn[28]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HONORARY_AMOUNT1");          // 명예퇴직수당(추가퇴직금)1                            
            pGDColumn[29]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HONORARY_AMOUNT2");          // 명예퇴직수당(추가퇴직금)2                            
            pGDColumn[30]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HONORARY_AMOUNT3");          // 명예퇴직수당(추가퇴직금)3                            
            pGDColumn[31]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HONORARY_AMOUNT4");          // 명예퇴직수당(추가퇴직금) 합계                        
            pGDColumn[32]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_AMOUNT1");            // 퇴직연금일시금1                                      
            pGDColumn[33]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_AMOUNT2");            // 퇴직연금일시금2                                      
            pGDColumn[34]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_AMOUNT3");            // 퇴직연금일시금3                                      
            pGDColumn[35]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_AMOUNT4");            // 퇴직연금일시금 합계                                  
            pGDColumn[36]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL1");                    // 계1                                                  
            pGDColumn[37]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL2");                    // 계2                                                  
            pGDColumn[38]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL3");                    // 계3                                                  
            pGDColumn[39]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL4");                    // 계 합계                                              
            pGDColumn[40]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NON_TAX1");                  // 비과세소득1                                          
            pGDColumn[41]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NON_TAX2");                  // 비과세소득2                                          
            pGDColumn[42]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NON_TAX3");                  // 비과세소득3                                          
            pGDColumn[43]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NON_TAX4");                  // 비과세소득 합계                                      
            pGDColumn[44]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_RECEIPTS1");           // 총수령액1                                            
            pGDColumn[45]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REPAY_TOTAL_AMOUNT1");       // 원리금 합계액1                                       
            pGDColumn[46]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_MONEY_DUE1");         // 소득자 불입액1                                       
            pGDColumn[47]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANNUITY_DED1");       // 퇴직연금 소득공제액1                                 
            pGDColumn[48]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANNUITY_LUMP_SUM1");  // 퇴직연금일시금1                                      
            pGDColumn[49]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_RECEIPTS2");           // 총수령액2                                            
            pGDColumn[50]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REPAY_TOTAL_AMOUNT2");       // 원리금 합계액2                                       
            pGDColumn[51]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_MONEY_DUE2");         // 소득자 불입액2                                       
            pGDColumn[52]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANNUITY_DED2");       // 퇴직연금 소득공제액2                                 
            pGDColumn[53]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANNUITY_LUMP_SUM2");  // 퇴직연금일시금2                                      
            pGDColumn[54]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANN_LUMP_SUM_E1");    // 퇴직연금일시금 지급예상액, 이연금액                  
            pGDColumn[55]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_LUMP_SUM1");           // 총일시금                                             
            pGDColumn[56]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RECEIVE_RETIRE_PAY1");       // 수령가능퇴직급여액                                   
            pGDColumn[57]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_RETIRE_ANN_DED1");        // 환산퇴직소득공제                                     
            pGDColumn[58]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_RETIRE_ANN_STANDARD1");   // 환산퇴직소득과세표준                                 
            pGDColumn[59]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_YEARLY_ANN_STANDARD1");   // 환산연평균 과세표준                                  
            pGDColumn[60]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_YEARLY_TAX_AMOUNT1");     // 환산 연평균 산출세액                                 
            pGDColumn[61]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANN_LUMP_SUM_E2");    // 퇴직연금일시금 지급예상액, 이연금액                  
            pGDColumn[62]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANN_LUMP_SUM_E3");    // 퇴직연금일시금 지급예상액, 이연금액                  
            pGDColumn[63]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_LUMP_SUM2");           // 총일시금                                             
            pGDColumn[64]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RECEIVE_RETIRE_PAY2");       // 수령가능퇴직급여액                                   
            pGDColumn[65]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_RETIRE_ANN_DED2");        // 환산퇴직소득공제                                     
            pGDColumn[66]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_RETIRE_ANN_STANDARD2");   // 환산퇴직소득과세표준                                 
            pGDColumn[67]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_YEARLY_ANN_STANDARD2");   // 환산연평균 과세표준                                  
            pGDColumn[68]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EX_YEARLY_TAX_AMOUNT2");     // 환산 연평균 산출세액                                 
            pGDColumn[69]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_ANN_LUMP_SUM_E4");    // 퇴직연금일시금 지급예상액, 이연금액                  
            pGDColumn[70]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_DATE_FR1");           // 입사일(정산시작일)1                                  
            pGDColumn[71]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_DATE1");              // 퇴사일1                                              
            pGDColumn[72]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_MONTH1");               // 근속월수1                                            
            pGDColumn[73]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EXCEPT_MONTH1");             // 제외월수1                                            
            pGDColumn[74]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_YEAR1");                // 근속연수1                                            
            pGDColumn[75]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ORI_JOIN_DATE2");            // 입사일2                                              
            pGDColumn[76]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_DATE2");              // 퇴사일2                                              
            pGDColumn[77]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_MONTH2");               // 근속월수2                                            
            pGDColumn[78]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EXCEPT_MONTH2");             // 제외월수2                                            
            pGDColumn[79]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_YEAR2");                // 근속연수2                                            
            pGDColumn[80]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_RETIRE_DATE_FR1");       // 입사일(정산시작일)1                                  
            pGDColumn[81]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_RETIRE_DATE1");          // 퇴사일1                                              
            pGDColumn[82]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LONG_MONTH1");           // 근속월수1                                            
            pGDColumn[83]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_EXCEPT_MONTH1");         // 제외월수1                                            
            pGDColumn[84]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_ORI_JOIN_DATE2");        // 입사일2                                              
            pGDColumn[85]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_RETIRE_DATE2");          // 퇴사일2                                              
            pGDColumn[86]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LONG_MONTH2");           // 근속월수2                                            
            pGDColumn[87]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_EXCEPT_MONTH2");         // 제외월수2  
            pGDColumn[88]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LONG_YEAR1");            // 중복월수1                              
            pGDColumn[89]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LONG_YEAR2");            // 중복월수2
            pGDColumn[90]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETIRE_AMOUNT");             // 퇴직급여액                                           
            pGDColumn[91]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HONORARY_AMOUNT");           // 명예퇴직금                                           
            pGDColumn[92]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_RETIRE_AMOUNT");       // 퇴직급여액 합계                                      
            pGDColumn[93]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DED_SUM_AMOUNT");            // 퇴직소득공제 - 계                                    
            pGDColumn[94]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_DED_SUM_AMOUNT");          // 퇴직소득공제 - 계                                    
            pGDColumn[95]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_INCOME_DED_AMOUNT");   // 퇴직소득공제 합계                                    
            pGDColumn[96]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_STD_AMOUNT");            // 퇴직소득과세표준 - 법정퇴직급여                      
            pGDColumn[97]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_TAX_STD_AMOUNT");          // 퇴직소득과세표준 - 법정이외 퇴직급여                 
            pGDColumn[98]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AVG_TAX_STD_AMOUNT");  // 연평균과세표준 합계                                  
            pGDColumn[99]  = pGrid_WITHHOLDING_TAX.GetColumnToIndex("AVG_TAX_STD_AMOUNT");        // 세액계산근거 - 연평균과세표준 - 법정퇴직급여         
            pGDColumn[100] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_AVG_TAX_STD_AMOUNT");      // 세액계산근거 - 연평균과세표준 - 법정이외 퇴직급여    
            pGDColumn[101] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_TAX_STD_AMOUNT");      // 연평균과세표준 합계                                  
            pGDColumn[102] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("AVG_COMP_TAX_AMOUNT");       // 세액계산근거 - 연평균산출세액 - 법정퇴직급여         
            pGDColumn[103] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_AVG_COMP_TAX_AMOUNT");     // 세액계산근거 - 연평균산출세액 - 법정이외 퇴직급여    
            pGDColumn[104] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AVG_COMP_TAX_AMOUNT"); // 연평균산출세액 합계                                  
            pGDColumn[105] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("COMP_TAX_AMOUNT");           // 세액계산근거 - 산출세액 - 법정퇴직급여               
            pGDColumn[106] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_COMP_TAX_AMOUNT");         // 세액계산근거 - 산출세액 - 법정이외 퇴직급여          
            pGDColumn[107] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_COMP_TAX_AMOUNT");     // 산출세액 합계                                        
            pGDColumn[108] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_AMOUNT");            // 세액계산근거 - 세액공제(외국납부) - 법정퇴직급여     
            pGDColumn[109] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_TAX_DED_AMOUNT");          // 세액계산근거 - 세액공제(외국납부) - 법정이외 퇴직급여
            pGDColumn[110] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_TAX_DED_AMOUNT");      // 세액공제 합계                                        
            pGDColumn[111] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_TAX_AMOUNT");         // 결정세액 - 퇴직소득세 - 법정퇴직급여                 
            pGDColumn[112] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("H_INCOME_TAX_AMOUNT");       // 결정세액 - 퇴직소득세 - 법정이외 퇴직급여            
            pGDColumn[113] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_INCOME_TAX_AMOUNT");   // 결정세액 합계                                        
            pGDColumn[114] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_INCOME_TAX_AMOUNT1");  // 결정세액 - 소득세 합계                               
            pGDColumn[115] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RESIDENT_TAX_AMOUNT");       // 결정세액 - 주민세 합계                               
            pGDColumn[116] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_SP_TAX_AMOUNT");       // 농어촌 특별세 합계                                   
            pGDColumn[117] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_INCOME_TAX_AMOUNT2");  // 결정세액 합계                                        
            pGDColumn[118] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_INCOME_AMOUNT");         // 종(전)근무지 기납부세액 | 소득세                     
            pGDColumn[119] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LOCAL_AMOUNT");          // 종(전)근무지 기납부세액 | 주민세                     
            pGDColumn[120] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_SP_TAX_AMOUNT");         // 종(전)근무지 기납부세액 | 농특세                     
            pGDColumn[121] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_TOTAL");                 // 종(전)근무지 기납부세액 | 합계                       
            pGDColumn[122] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MINUS_INCOME_AMOUNT");       // 차감원천징수세액 | 소득세                            
            pGDColumn[123] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MINUS_LOCAL_AMOUNT");        // 차감원천징수세액 | 주민세                            
            pGDColumn[124] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MINUS_SP_TAX_AMOUNT");       // 차감원천징수세액 | 농특세                            
            pGDColumn[125] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_MINUS_TAX");           // 차감원천징수세액 합계
            pGDColumn[126] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRINT_DATE");                // 출력날짜

            //---------------------------------------------------------------------------------------------------------------------
            pXLColumn[0]   = 36;   // 거주 구분(거주자1/거주자2)
            pXLColumn[1]   = 36;   // 내외국인 구분(내국인1/외국인9)
            pXLColumn[2]   = 11;   // 사업자등록번호                                        
            pXLColumn[3]   = 27;   // 법인명(상호)                                          
            pXLColumn[4]   = 39;   // 대표자(성명)                                          
            pXLColumn[5]   = 27;   // 소재지(주소)                                          
            pXLColumn[6]   = 11;   // 성명                                                  
            pXLColumn[7]   = 27;   // 주민번호                                              
            pXLColumn[8]   = 11;   // 주소                                                  
            pXLColumn[9]   = 11;   // 귀속연도 시작 일자                                    
            pXLColumn[10]  = 27;   // 퇴직사유                                              
            pXLColumn[11]  = 11;   // 귀속연도 마지막 일자(퇴직일자)                        
            pXLColumn[12]  = 12;   // 퇴직세액공제적용1                                     
            pXLColumn[13]  = 20;   // 퇴직세액공제적용2                                     
            pXLColumn[14]  = 28;   // 퇴직세액공제적용3                                     
            pXLColumn[15]  = 36;   // 퇴직세액공제적용 합계                                 
            pXLColumn[16]  = 12;   // 근무처명1                                             
            pXLColumn[17]  = 20;   // 근무처명2                                             
            pXLColumn[18]  = 28;   // 근무처명3                                             
            pXLColumn[19]  = 36;   // 근무처명 합계                                         
            pXLColumn[20]  = 12;   // 사업자등록번호1                                       
            pXLColumn[21]  = 20;   // 사업자등록번호2                                       
            pXLColumn[22]  = 28;   // 사업자등록번호3                                       
            pXLColumn[23]  = 36;   // 사업자등록번호 합계                                   
            pXLColumn[24]  = 12;   // 퇴직급여1                                             
            pXLColumn[25]  = 20;   // 퇴직급여2                                             
            pXLColumn[26]  = 28;   // 퇴직급여3                                             
            pXLColumn[27]  = 36;   // 퇴직급여 합계                                         
            pXLColumn[28]  = 12;   // 명예퇴직수당(추가퇴직금)1                             
            pXLColumn[29]  = 20;   // 명예퇴직수당(추가퇴직금)2                             
            pXLColumn[30]  = 28;   // 명예퇴직수당(추가퇴직금)3                             
            pXLColumn[31]  = 36;   // 명예퇴직수당(추가퇴직금) 합계                         
            pXLColumn[32]  = 12;   // 퇴직연금일시금1                                       
            pXLColumn[33]  = 20;   // 퇴직연금일시금2                                       
            pXLColumn[34]  = 28;   // 퇴직연금일시금3                                       
            pXLColumn[35]  = 36;   // 퇴직연금일시금 합계                                   
            pXLColumn[36]  = 12;   // 계1                                                   
            pXLColumn[37]  = 20;   // 계2                                                   
            pXLColumn[38]  = 28;   // 계3                                                   
            pXLColumn[39]  = 36;   // 계 합계                                               
            pXLColumn[40]  = 12;   // 비과세소득1                                           
            pXLColumn[41]  = 20;   // 비과세소득2                                           
            pXLColumn[42]  = 28;   // 비과세소득3                                           
            pXLColumn[43]  = 36;   // 비과세소득 합계                                       
            pXLColumn[44]  = 12;   // 총수령액1                                             
            pXLColumn[45]  = 19;   // 원리금 합계액1                                        
            pXLColumn[46]  = 26;   // 소득자 불입액1                                        
            pXLColumn[47]  = 33;   // 퇴직연금 소득공제액1                                  
            pXLColumn[48]  = 38;   // 퇴직연금일시금1                                       
            pXLColumn[49]  = 12;   // 총수령액2                                             
            pXLColumn[50]  = 19;   // 원리금 합계액2                                        
            pXLColumn[51]  = 26;   // 소득자 불입액2                                        
            pXLColumn[52]  = 33;   // 퇴직연금 소득공제액2                                  
            pXLColumn[53]  = 38;   // 퇴직연금일시금2                                       
            pXLColumn[54]  =  9;   // 퇴직연금일시금 지급예상액, 이연금액                   
            pXLColumn[55]  = 15;   // 총일시금                                              
            pXLColumn[56]  = 20;   // 수령가능퇴직급여액                                    
            pXLColumn[57]  = 25;   // 환산퇴직소득공제                                      
            pXLColumn[58]  = 29;   // 환산퇴직소득과세표준                                  
            pXLColumn[59]  = 34;   // 환산연평균 과세표준                                   
            pXLColumn[60]  = 39;   // 환산 연평균 산출세액                                  
            pXLColumn[61]  =  9;   // 퇴직연금일시금 지급예상액, 이연금액                   
            pXLColumn[62]  =  9;   // 퇴직연금일시금 지급예상액, 이연금액                   
            pXLColumn[63]  = 15;   // 총일시금                                              
            pXLColumn[64]  = 20;   // 수령가능퇴직급여액                                    
            pXLColumn[65]  = 25;   // 환산퇴직소득공제                                      
            pXLColumn[66]  = 29;   // 환산퇴직소득과세표준                                  
            pXLColumn[67]  = 34;   // 환산연평균 과세표준                                   
            pXLColumn[68]  = 39;   // 환산 연평균 산출세액                                  
            pXLColumn[69]  =  9;   // 퇴직연금일시금 지급예상액, 이연금액                   
            pXLColumn[70]  = 12;   // 입사일(정산시작일)1                                   
            pXLColumn[71]  = 15;   // 퇴사일1                                               
            pXLColumn[72]  = 18;   // 근속월수1                                             
            pXLColumn[73]  = 20;   // 제외월수1                                             
            pXLColumn[74]  = 22;   // 근속연수1                                             
            pXLColumn[75]  = 25;   // 입사일2                                               
            pXLColumn[76]  = 28;   // 퇴사일2                                               
            pXLColumn[77]  = 31;   // 근속월수2                                             
            pXLColumn[78]  = 33;   // 제외월수2                                             
            pXLColumn[79]  = 35;   // 근속연수2                                             
            pXLColumn[80]  = 12;   // 입사일(정산시작일)1                                   
            pXLColumn[81]  = 15;   // 퇴사일1                                               
            pXLColumn[82]  = 18;   // 근속월수1                                             
            pXLColumn[83]  = 20;   // 제외월수1  
            pXLColumn[84]  = 25;   // 입사일2                                               
            pXLColumn[85]  = 28;   // 퇴사일2                                               
            pXLColumn[86]  = 31;   // 근속월수2                                             
            pXLColumn[87]  = 33;   // 제외월수2                                             
            pXLColumn[88]  = 22;   // 중복월수1
            pXLColumn[89]  = 35;   // 중복월수2            
            pXLColumn[90]  = 12;   // 퇴직급여액                                            
            pXLColumn[91]  = 25;   // 명예퇴직금                                            
            pXLColumn[92]  = 38;   // 퇴직급여액 합계                                       
            pXLColumn[93]  = 12;   // 퇴직소득공제 - 계                                     
            pXLColumn[94]  = 25;   // 퇴직소득공제 - 계                                     
            pXLColumn[95]  = 38;   // 퇴직소득공제 합계                                     
            pXLColumn[96]  = 12;   // 퇴직소득과세표준 - 법정퇴직급여                       
            pXLColumn[97]  = 25;   // 퇴직소득과세표준 - 법정이외 퇴직급여                  
            pXLColumn[98]  = 38;   // 연평균과세표준 합계                                   
            pXLColumn[99]  = 12;   // 세액계산근거 - 연평균과세표준 - 법정퇴직급여          
            pXLColumn[100] = 25;   // 세액계산근거 - 연평균과세표준 - 법정이외 퇴직급여     
            pXLColumn[101] = 38;   // 연평균과세표준 합계                                   
            pXLColumn[102] = 12;   // 세액계산근거 - 연평균산출세액 - 법정퇴직급여          
            pXLColumn[103] = 25;   // 세액계산근거 - 연평균산출세액 - 법정이외 퇴직급여     
            pXLColumn[104] = 38;   // 연평균산출세액 합계                                   
            pXLColumn[105] = 12;   // 세액계산근거 - 산출세액 - 법정퇴직급여                
            pXLColumn[106] = 25;   // 세액계산근거 - 산출세액 - 법정이외 퇴직급여           
            pXLColumn[107] = 38;   // 산출세액 합계                                         
            pXLColumn[108] = 12;   // 세액계산근거 - 세액공제(외국납부) - 법정퇴직급여      
            pXLColumn[109] = 25;   // 세액계산근거 - 세액공제(외국납부) - 법정이외 퇴직급여 
            pXLColumn[110] = 38;   // 세액공제 합계                                         
            pXLColumn[111] = 12;   // 결정세액 - 퇴직소득세 - 법정퇴직급여                  
            pXLColumn[112] = 25;   // 결정세액 - 퇴직소득세 - 법정이외 퇴직급여             
            pXLColumn[113] = 38;   // 결정세액 합계                                         
            pXLColumn[114] = 12;   // 결정세액 - 소득세 합계                                
            pXLColumn[115] = 20;   // 결정세액 - 주민세 합계                                
            pXLColumn[116] = 27;   // 농어촌 특별세 합계                                    
            pXLColumn[117] = 35;   // 결정세액 합계                                         
            pXLColumn[118] = 12;   // 종(전)근무지 기납부세액 | 소득세                      
            pXLColumn[119] = 20;   // 종(전)근무지 기납부세액 | 주민세                      
            pXLColumn[120] = 27;   // 종(전)근무지 기납부세액 | 농특세                      
            pXLColumn[121] = 35;   // 종(전)근무지 기납부세액 | 합계                        
            pXLColumn[122] = 12;   // 차감원천징수세액 | 소득세                             
            pXLColumn[123] = 20;   // 차감원천징수세액 | 주민세                             
            pXLColumn[124] = 27;   // 차감원천징수세액 | 농특세                             
            pXLColumn[125] = 35;   // 차감원천징수세액 합계
            pXLColumn[126] = 29;   // 출력날짜
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

        #region ----- Line Write Method -----

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, object pPrintType, string pCourse)
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
                    if (vConvertString == "1") //거주자 1이면,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "●");
                    }
                    else //거주자 2이면,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 6), "●"); 
                    }                    
                }
                else
                {
                    vConvertString = string.Empty;
                    //거주자1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //거주자2이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 6), vConvertString);
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
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 6), "●");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //내국인1이면,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //외국인9이면,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 6), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // 출력 용도 구분
                vXLColumnIndex = 15;
                vObject = pPrintType;
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

                // 사업자등록번호
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
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

                // 법인명(상호)
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
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
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 성명
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

                // 주민번호
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

                // 주소
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

                // 귀속연도 시작 일자
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

                // 퇴직사유
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 귀속연도 마지막 일자(퇴직일자)
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

                // 퇴직세액공제적용1
                vGDColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직세액공제적용2
                vGDColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직세액공제적용3
                vGDColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직세액공제적용 합계
                vGDColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 근무처명1
                vGDColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
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

                // 근무처명2
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

                // 근무처명3
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

                // 근무처명 합계
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 사업자등록번호1
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

                // 사업자등록번호2
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

                // 사업자등록번호3
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

                // 사업자등록번호4
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

                // 퇴직급여1
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직급여2
                vGDColumnIndex = pGDColumn[25];
                vXLColumnIndex = pXLColumn[25];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직급여3
                vGDColumnIndex = pGDColumn[26];
                vXLColumnIndex = pXLColumn[26];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직급여 합계
                vGDColumnIndex = pGDColumn[27];
                vXLColumnIndex = pXLColumn[27];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 명예퇴직수당(추가퇴직금)1  
                vGDColumnIndex = pGDColumn[28];
                vXLColumnIndex = pXLColumn[28];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 명예퇴직수당(추가퇴직금)2
                vGDColumnIndex = pGDColumn[29];
                vXLColumnIndex = pXLColumn[29];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 명예퇴직수당(추가퇴직금)3
                vGDColumnIndex = pGDColumn[30];
                vXLColumnIndex = pXLColumn[30];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 명예퇴직수당(추가퇴직금) 합계  
                vGDColumnIndex = pGDColumn[31];
                vXLColumnIndex = pXLColumn[31];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 퇴직연금일시금1
                vGDColumnIndex = pGDColumn[32];
                vXLColumnIndex = pXLColumn[32];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금일시금2
                vGDColumnIndex = pGDColumn[33];
                vXLColumnIndex = pXLColumn[33];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금일시금3
                vGDColumnIndex = pGDColumn[34];
                vXLColumnIndex = pXLColumn[34];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금일시금 합계
                vGDColumnIndex = pGDColumn[35];
                vXLColumnIndex = pXLColumn[35];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 계1
                vGDColumnIndex = pGDColumn[36];
                vXLColumnIndex = pXLColumn[36];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계2
                vGDColumnIndex = pGDColumn[37];
                vXLColumnIndex = pXLColumn[37];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계3
                vGDColumnIndex = pGDColumn[38];
                vXLColumnIndex = pXLColumn[38];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계 합계
                vGDColumnIndex = pGDColumn[39];
                vXLColumnIndex = pXLColumn[39];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 비과세소득1
                vGDColumnIndex = pGDColumn[40];
                vXLColumnIndex = pXLColumn[40];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 비과세소득2
                vGDColumnIndex = pGDColumn[41];
                vXLColumnIndex = pXLColumn[41];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 비과세소득3
                vGDColumnIndex = pGDColumn[42];
                vXLColumnIndex = pXLColumn[42];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 비과세소득 합계
                vGDColumnIndex = pGDColumn[43];
                vXLColumnIndex = pXLColumn[43];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 총수령액1
                vGDColumnIndex = pGDColumn[44];
                vXLColumnIndex = pXLColumn[44];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 원리금 합계액1 
                vGDColumnIndex = pGDColumn[45];
                vXLColumnIndex = pXLColumn[45];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 소득자 불입액1
                vGDColumnIndex = pGDColumn[46];
                vXLColumnIndex = pXLColumn[46];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금 소득공제액1  
                vGDColumnIndex = pGDColumn[47];
                vXLColumnIndex = pXLColumn[47];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금일시금1 
                vGDColumnIndex = pGDColumn[48];
                vXLColumnIndex = pXLColumn[48];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 총수령액2
                vGDColumnIndex = pGDColumn[49];
                vXLColumnIndex = pXLColumn[49];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 원리금 합계액2
                vGDColumnIndex = pGDColumn[50];
                vXLColumnIndex = pXLColumn[50];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 소득자 불입액2
                vGDColumnIndex = pGDColumn[51];
                vXLColumnIndex = pXLColumn[51];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금 소득공제액2 
                vGDColumnIndex = pGDColumn[52];
                vXLColumnIndex = pXLColumn[52];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직연금일시금2 
                vGDColumnIndex = pGDColumn[53];
                vXLColumnIndex = pXLColumn[53];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 퇴직연금일시금 지급예상액, 이연금액    
                vGDColumnIndex = pGDColumn[54];
                vXLColumnIndex = pXLColumn[54];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 총일시금
                vGDColumnIndex = pGDColumn[55];
                vXLColumnIndex = pXLColumn[55];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 수령가능퇴직급여액  
                vGDColumnIndex = pGDColumn[56];
                vXLColumnIndex = pXLColumn[56];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산퇴직소득공제 
                vGDColumnIndex = pGDColumn[57];
                vXLColumnIndex = pXLColumn[57];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산퇴직소득과세표준 
                vGDColumnIndex = pGDColumn[58];
                vXLColumnIndex = pXLColumn[58];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산연평균 과세표준
                vGDColumnIndex = pGDColumn[59];
                vXLColumnIndex = pXLColumn[59];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산 연평균 산출세액 
                vGDColumnIndex = pGDColumn[60];
                vXLColumnIndex = pXLColumn[60];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 퇴직연금일시금 지급예상액, 이연금액    
                vGDColumnIndex = pGDColumn[61];
                vXLColumnIndex = pXLColumn[61];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 퇴직연금일시금 지급예상액, 이연금액    
                vGDColumnIndex = pGDColumn[62];
                vXLColumnIndex = pXLColumn[62];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 총일시금
                vGDColumnIndex = pGDColumn[63];
                vXLColumnIndex = pXLColumn[63];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 수령가능퇴직급여액  
                vGDColumnIndex = pGDColumn[64];
                vXLColumnIndex = pXLColumn[64];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산퇴직소득공제 
                vGDColumnIndex = pGDColumn[65];
                vXLColumnIndex = pXLColumn[65];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산퇴직소득과세표준 
                vGDColumnIndex = pGDColumn[66];
                vXLColumnIndex = pXLColumn[66];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산연평균 과세표준
                vGDColumnIndex = pGDColumn[67];
                vXLColumnIndex = pXLColumn[67];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 환산 연평균 산출세액 
                vGDColumnIndex = pGDColumn[68];
                vXLColumnIndex = pXLColumn[68];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 퇴직연금일시금 지급예상액, 이연금액    
                vGDColumnIndex = pGDColumn[69];
                vXLColumnIndex = pXLColumn[69];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 입사일(정산시작일)1   
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

                // 퇴사일1
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

                // 근속월수1
                vGDColumnIndex = pGDColumn[72];
                vXLColumnIndex = pXLColumn[72];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 제외월수1
                vGDColumnIndex = pGDColumn[73];
                vXLColumnIndex = pXLColumn[73];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 근속연수1
                vGDColumnIndex = pGDColumn[74];
                vXLColumnIndex = pXLColumn[74];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 입사일2
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

                // 퇴사일2
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

                // 근속월수2
                vGDColumnIndex = pGDColumn[77];
                vXLColumnIndex = pXLColumn[77];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 제외월수2
                vGDColumnIndex = pGDColumn[78];
                vXLColumnIndex = pXLColumn[78];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 근속연수2
                vGDColumnIndex = pGDColumn[79];
                vXLColumnIndex = pXLColumn[79];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 입사일(정산시작일)1
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

                // 퇴사일1
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

                // 근속월수1
                vGDColumnIndex = pGDColumn[82];
                vXLColumnIndex = pXLColumn[82];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 제외월수1
                vGDColumnIndex = pGDColumn[83];
                vXLColumnIndex = pXLColumn[83];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 입사일2
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

                // 퇴사일2
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

                // 근속월수2
                vGDColumnIndex = pGDColumn[86];
                vXLColumnIndex = pXLColumn[86];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 제외월수2
                vGDColumnIndex = pGDColumn[87];
                vXLColumnIndex = pXLColumn[87];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 중복월수1
                vGDColumnIndex = pGDColumn[88];
                vXLColumnIndex = pXLColumn[88];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 중복월수2            
                vGDColumnIndex = pGDColumn[89];
                vXLColumnIndex = pXLColumn[89];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 퇴직급여액
                vGDColumnIndex = pGDColumn[90];
                vXLColumnIndex = pXLColumn[90];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 명예퇴직금
                vGDColumnIndex = pGDColumn[91];
                vXLColumnIndex = pXLColumn[91];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직급여액 합계
                vGDColumnIndex = pGDColumn[92];
                vXLColumnIndex = pXLColumn[92];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 퇴직소득공제 - 계 
                vGDColumnIndex = pGDColumn[93];
                vXLColumnIndex = pXLColumn[93];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직소득공제 - 계
                vGDColumnIndex = pGDColumn[94];
                vXLColumnIndex = pXLColumn[94];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직소득공제 합계
                vGDColumnIndex = pGDColumn[95];
                vXLColumnIndex = pXLColumn[95];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 퇴직소득과세표준 - 법정퇴직급여
                vGDColumnIndex = pGDColumn[96];
                vXLColumnIndex = pXLColumn[96];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직소득과세표준 - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[97];
                vXLColumnIndex = pXLColumn[97];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연평균과세표준 합계
                vGDColumnIndex = pGDColumn[98];
                vXLColumnIndex = pXLColumn[98];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 세액계산근거 - 연평균과세표준 - 법정퇴직급여
                vGDColumnIndex = pGDColumn[99];
                vXLColumnIndex = pXLColumn[99];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 세액계산근거 - 연평균과세표준 - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[100];
                vXLColumnIndex = pXLColumn[100];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연평균과세표준 합계
                vGDColumnIndex = pGDColumn[101];
                vXLColumnIndex = pXLColumn[101];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 세액계산근거 - 연평균산출세액 - 법정퇴직급여
                vGDColumnIndex = pGDColumn[102];
                vXLColumnIndex = pXLColumn[102];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 세액계산근거 - 연평균산출세액 - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[103];
                vXLColumnIndex = pXLColumn[103];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 연평균산출세액 합계
                vGDColumnIndex = pGDColumn[104];
                vXLColumnIndex = pXLColumn[104];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 세액계산근거 - 산출세액 - 법정퇴직급여
                vGDColumnIndex = pGDColumn[105];
                vXLColumnIndex = pXLColumn[105];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 세액계산근거 - 산출세액 - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[106];
                vXLColumnIndex = pXLColumn[106];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 산출세액 합계
                vGDColumnIndex = pGDColumn[107];
                vXLColumnIndex = pXLColumn[107];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 세액계산근거 - 세액공제(외국납부) - 법정퇴직급여
                vGDColumnIndex = pGDColumn[108];
                vXLColumnIndex = pXLColumn[108];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 세액계산근거 - 세액공제(외국납부) - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[109];
                vXLColumnIndex = pXLColumn[109];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 세액공제 합계
                vGDColumnIndex = pGDColumn[110];
                vXLColumnIndex = pXLColumn[110];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 결정세액 - 퇴직소득세 - 법정퇴직급여
                vGDColumnIndex = pGDColumn[111];
                vXLColumnIndex = pXLColumn[111];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 결정세액 - 퇴직소득세 - 법정이외 퇴직급여
                vGDColumnIndex = pGDColumn[112];
                vXLColumnIndex = pXLColumn[112];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 결정세액 합계
                vGDColumnIndex = pGDColumn[113];
                vXLColumnIndex = pXLColumn[113];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 결정세액 - 소득세 합계
                vGDColumnIndex = pGDColumn[114];
                vXLColumnIndex = pXLColumn[114];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 결정세액 - 주민세 합계
                vGDColumnIndex = pGDColumn[115];
                vXLColumnIndex = pXLColumn[115];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 농어촌 특별세 합계 
                vGDColumnIndex = pGDColumn[116];
                vXLColumnIndex = pXLColumn[116];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 결정세액 합계
                vGDColumnIndex = pGDColumn[117];
                vXLColumnIndex = pXLColumn[117];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
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

                // 종(전)근무지 기납부세액 | 소득세
                vGDColumnIndex = pGDColumn[118];
                vXLColumnIndex = pXLColumn[118];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 종(전)근무지 기납부세액 | 주민세
                vGDColumnIndex = pGDColumn[119];
                vXLColumnIndex = pXLColumn[119];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 종(전)근무지 기납부세액 | 농특세
                vGDColumnIndex = pGDColumn[120];
                vXLColumnIndex = pXLColumn[120];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 종(전)근무지 기납부세액 | 합계
                vGDColumnIndex = pGDColumn[121];
                vXLColumnIndex = pXLColumn[121];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertString);
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

                // 차감원천징수세액 | 소득세
                vGDColumnIndex = pGDColumn[122];
                vXLColumnIndex = pXLColumn[122];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차감원천징수세액 | 주민세
                vGDColumnIndex = pGDColumn[123];
                vXLColumnIndex = pXLColumn[123];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차감원천징수세액 | 농특세
                vGDColumnIndex = pGDColumn[124];
                vXLColumnIndex = pXLColumn[124];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차감원천징수세액 합계
                vGDColumnIndex = pGDColumn[125];
                vXLColumnIndex = pXLColumn[125];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 5;
                //-------------------------------------------------------------------

                // 출력날짜
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

        #region ----- Excel Write WithholdingTax  Method ----

        public int WriteWithholdingTax(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_WITHHOLDING_TAX, object pPrintType)
        {
            string vMessageText = string.Empty;
            bool isOpen = XLFileOpen();
            mCopyLineSUM = 1;
            mPageNumber = 0;

            int[] vGDColumn;
            int[] vXLColumn;

            int vTotalRow = pGrid_WITHHOLDING_TAX.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            int vSecondPrinting = 9;
            int vCountPrinting = 0;

            SetArray(pGrid_WITHHOLDING_TAX, out vGDColumn, out vXLColumn);

            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;
                pGrid_WITHHOLDING_TAX.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Printing : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                if (isOpen == true)
                {
                    vCountPrinting++;

                    mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "SRC_TAB1");
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                    pGrid_WITHHOLDING_TAX.CurrentCellMoveTo(vRow, 0);
                    pGrid_WITHHOLDING_TAX.Focus();
                    pGrid_WITHHOLDING_TAX.CurrentCellActivate(vRow, 0);

                    // 퇴직소득원천징수영수증/지급조서
                    vPrintingLine = XLLine(pGrid_WITHHOLDING_TAX, vRow, vPrintingLine, vGDColumn, vXLColumn, pPrintType, "SRC_TAB1");

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
                        Printing(1, vCountPrinting);
                        //PreView(1, vCountPrinting);
                    }
                }
            }

            mPrinting.XLOpenFileClose();

            return mPageNumber;
        
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

        public void PreView(int pPageSTART, int pPageEND)
        {
            try
            {
                mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, 1);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
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
        
        #endregion;
    }
}