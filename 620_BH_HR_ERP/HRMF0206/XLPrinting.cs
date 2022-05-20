using System;
using ISCommonUtil;

namespace HRMF0206
{
    /// <summary>
    /// XLPrint Class를 이용해 Report물 제어 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        private InfoSummit.Win.ControlAdv.ISGridAdvEx mGridAdvEx;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar1;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar2;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridColumns = new int[0] { };

        private int mPositionPrintLineSTART = 1; //내용 출력시 엑셀 시작 행 위치 지정
        private int[] mIndexXLWriteColumn = new int[0] { }; //엑셀에 출력할 열 위치 지정

        private int mMaxIncrement = 45; //실제 출력되는 행의 시작부터 끝 행의 범위
        private int mSumPrintingLineCopy = 1; //엑셀의 선택된 쉬트에 복사되어질 시작 행 위치 및 누적 행 값
        private int mMaxIncrementCopy = 67; //반복 복사되어질 행의 최대 범위

        private int mXLColumnAreaSTART = 1; //복사되어질 쉬트의 폭, 시작열
        private int mXLColumnAreaEND = 45;  //복사되어질 쉬트의 폭, 종료열

        #endregion;

        #region ----- Property -----

        /// <summary>
        /// 모든 Error Message 출력
        /// </summary>
        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        /// <summary>
        /// Message 출력할 Grid
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISGridAdvEx MessageGridEx
        {
            set
            {
                mGridAdvEx = value;
            }
        }

        /// <summary>
        /// 전체 Data 진행 ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar1
        {
            set
            {
                mProgressBar1 = value;
            }
        }

        /// <summary>
        /// Page당 Data 진행 ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar2
        {
            set
            {
                mProgressBar2 = value;
            }
        }

        /// <summary>
        /// Ope할 Excel File 이름
        /// </summary>
        public string OpenFileNameExcel
        {
            set
            {
                mXLOpenFileName = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public XLPrinting()
        {
            mPrinting = new XL.XLPrint();
        }

        #endregion;

        #region ----- Interior Use Methods ----

        #region ----- MessageGrid Methods ----

        private void MessageGrid(string pMessage)
        {
            int vCountRow = mGridAdvEx.RowCount;
            vCountRow = vCountRow + 1;
            mGridAdvEx.RowCount = vCountRow;

            int vCurrentRow = vCountRow - 1;

            mGridAdvEx.SetCellValue(vCurrentRow, 0, pMessage);

            mGridAdvEx.CurrentCellMoveTo(vCurrentRow, 0);
            mGridAdvEx.Focus();
            mGridAdvEx.CurrentCellActivate(vCurrentRow, 0);
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

        #endregion;

        #region ----- XLPrint Define Methods ----

        #region ----- Dispose -----

        public void Dispose()
        {
            mPrinting.XLOpenFileClose();
            mPrinting.XLClose();
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

        #region ----- Line Clear All Methods ----

        private void XlAllLineClear(XL.XLPrint pPrinting)
        {
            int vXLColumn1 = 2;  //No[OPERATION_SEQ_NO]
            int vXLColumn2 = 4;  //공정명[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //공정 진행시 작업 조건[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //선그리기, 시작 열
            int vXLDrawLineColumnEND = 45;  //선그리기, 종료 열

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            //pPrinting.XLActiveSheet(2);
            pPrinting.XLActiveSheet("SourceTab1");

            for (int vXLine = mPositionPrintLineSTART; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //공정명[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //공정 진행시 작업 조건[OPERATION_COMMENT]

                if (vXLine < mMaxIncrementCopy)
                {
                    pPrinting.XL_LineClear(vXLine, vXLDrawLineColumnSTART, vXLDrawLineColumnEND);
                }
            }
        }

        #endregion;

        #region ----- Line Clear Methods ----

        //XlLineClear(mPrinting, vPrintingLine);
        private void XlLineClear(XL.XLPrint pPrinting, int pPrintingLine)
        {
            int vXLColumn1 = 2;  //No[OPERATION_SEQ_NO]
            int vXLColumn2 = 4;  //공정명[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //공정 진행시 작업 조건[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //선그리기, 시작 열
            int vXLDrawLineColumnEND = 45;  //선그리기, 종료 열

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            for (int vXLine = pPrintingLine; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //공정명[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //공정 진행시 작업 조건[OPERATION_COMMENT]

                if (vXLine < mMaxIncrementCopy)
                {
                    pPrinting.XL_LineClear(vXLine, vXLDrawLineColumnSTART, vXLDrawLineColumnEND);
                }
            }
        }

        #endregion;

        #region ----- Define Print Column Methods ----

        private void XLDefinePrintColumn(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            try
            {
                //Grid의 [Edit] 상의 [DataColumn] 열에 있는 열 이름을 지정 하면 된다.
                string[] vGridDataColumns = new string[]
                {
                    "NAME",
                    "PERSON_NUM",
                    "DEPT_NAME",
                    "POST_NAME",
                    "JOB_CLASS_NAME",
                    "SUPPLY_DATE",
                    "BANK_NAME",
                    "BANK_ACCOUNTS",
                    "REAL_AMOUNT"
                };

                int vIndexColumn = 0;
                mIndexGridColumns = new int[vGridDataColumns.Length];

                foreach (string vName in vGridDataColumns)
                {
                    mIndexGridColumns[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //엑셀에 출력될 열 위치 지정
                int[] vXLColumns = new int[]
                {
                    28,
                    28,
                    28,
                    29,
                    29,
                    29,
                    30,
                    30,
                    60
                };
                mIndexXLWriteColumn = new int[vXLColumns.Length];
                for (int vCol = 0; vCol < vXLColumns.Length; vCol++)
                {
                    mIndexXLWriteColumn[vCol] = vXLColumns[vCol];
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print HeaderColumns Methods ----

        private void XLHeaderColumns(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, int pXLine)
        {
            int vXLine = pXLine - 1; //mPositionPrintLineSTART - 1, 출력될 내용의 행 위치에서 한행 위에 있으므로 1을 뺀다.
            int vCountColumn = mIndexGridColumns.Length;

            object vObject = null;
            int vGetIndexGridColumn = 0;

            try
            {
                if (mIndexGridColumns.Length < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridColumns[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].TL1_KR;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
                            break;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Content Write Methods ----

        private object ConvertDateTime(object pObject)
        {
            object vObject = null;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is System.DateTime;
                    if (IsConvert == true)
                    {
                        System.DateTime vDateTime = (System.DateTime)pObject;
                        //string vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd HH:mm:ss", null);
                        string vTextDateTimeLong = vDateTime.ToString("yyyy년 MM월 dd일", null);
                        string vTextDateTimeShort = vDateTime.ToShortDateString();
                        vObject = vTextDateTimeLong;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vObject;
        }

        #region ----- New Page iF Methods ----

        private int NewPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTotalRow, int pSumWriteLine)
        {
            int vPrintingRowSTART = 0;
            int vPrintingRowEND = 0;

            try
            {
                vPrintingRowSTART = pSumWriteLine;
                pSumWriteLine = pSumWriteLine + mMaxIncrement;
                vPrintingRowEND = pSumWriteLine;

                //XLContentWrite(mPrinting, pGrid, pTotalRow, mPositionPrintLineSTART, mIndexXLWriteColumn, vPrintingRowSTART, vPrintingRowEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return pSumWriteLine;
        }

        #endregion;

        #region ----- Report Title -----

        private void ReportTitle()
        {
            //======================================================================================
            // 제목 및 기본사항 항목명 출력 부분
            //======================================================================================
            //제목
            mPrinting.XLSetCell(5, 13, "인   사   기   록   표");
            //기본사항
            mPrinting.XLSetCell(10, 3, "기   본   사   항");
            //성명
            mPrinting.XLSetCell(12, 11, "성      명");
            //직군
            mPrinting.XLSetCell(12, 22, "직  구  분");
            //급여구분
            mPrinting.XLSetCell(12, 33, "사  업  장");
            //부서
            mPrinting.XLSetCell(14, 11, "부      서");
            //직책
            mPrinting.XLSetCell(14, 22, "직      책");
            //주민등록번호
            mPrinting.XLSetCell(14, 33, "주민등록번호");
            //사번
            mPrinting.XLSetCell(16, 11, "사원  번호");
            //직위
            mPrinting.XLSetCell(16, 22, "직      위");
            //퇴사일자
            mPrinting.XLSetCell(16, 33, "작  업  장");
            //입사일자
            mPrinting.XLSetCell(18, 11, "입사  일자");
            //직무
            mPrinting.XLSetCell(18, 22, "퇴사  일자");
            //계좌
            mPrinting.XLSetCell(18, 33, "계좌  번호");
            //전화번호
            mPrinting.XLSetCell(20, 11, "이  메  일");
            //이메일
            mPrinting.XLSetCell(20, 22, "전화  번호");
            //노조가입
            mPrinting.XLSetCell(20, 33, "휴대  전화");
            //======================================================================================
            // 책정임금 항목명
            //======================================================================================
            //책정임금
            mPrinting.XLSetCell(44, 25, "책정임금");
            //적용기간
            mPrinting.XLSetCell(44, 27, "적용기간");
            //기본급
            //mPrinting.XLSetCell(44, 33, "기본급"); //실제 데이터 인쇄하는 부분에서 처리함//
            //======================================================================================
            // 학력사항 항목명
            //======================================================================================
            //학력사항
            mPrinting.XLSetCell(23, 3, "학력사항");
            //년월
            mPrinting.XLSetCell(23, 5, "졸업년월");
            //출신교
            mPrinting.XLSetCell(23, 10, "출 신 교");
            //학력
            mPrinting.XLSetCell(23, 16, "학 력");
            //전공
            mPrinting.XLSetCell(23, 19, "전 공");
            //======================================================================================
            // 가족사항 항목명
            //======================================================================================
            //가족사항
            mPrinting.XLSetCell(23, 25, "가족사항");
            //관계
            mPrinting.XLSetCell(23, 27, "관 계");
            //성명
            mPrinting.XLSetCell(23, 30, "성 명");
            //생년월일
            mPrinting.XLSetCell(23, 34, "생년월일");
            //학력
            mPrinting.XLSetCell(23, 38, "학 력");
            //근무처
            mPrinting.XLSetCell(23, 41, "근 무 처");
            //======================================================================================
            // 자격사항 항목명
            //======================================================================================
            //자격/면허
            mPrinting.XLSetCell(32, 3, "자격/면허");
            //자격증명
            mPrinting.XLSetCell(32, 5, "자격증명");
            //등급
            mPrinting.XLSetCell(32, 12, "등급");
            //취득일
            mPrinting.XLSetCell(32, 17, "취득일");
            //======================================================================================
            // 경력사항 항목명
            //======================================================================================
            //경력사항
            mPrinting.XLSetCell(32, 25, "경력사항");
            //근무기간
            mPrinting.XLSetCell(32, 27, "근무기간");
            //근무처
            mPrinting.XLSetCell(32, 33, "근무처");
            //직급
            mPrinting.XLSetCell(32, 38, "직급");
            //담당업무
            mPrinting.XLSetCell(32, 41, "담당업무");
            //======================================================================================
            // 어학사항 항목명
            //======================================================================================
            //어학
            mPrinting.XLSetCell(38, 3, "어 학");
            //어학구분
            mPrinting.XLSetCell(38, 5, "어학구분");
            //종류
            mPrinting.XLSetCell(38, 11, "종 류");
            //등급
            mPrinting.XLSetCell(38, 17, "등급");
            //점수
            mPrinting.XLSetCell(38, 20, "점 수");
            //======================================================================================
            // 표창/징계사항 항목명
            //======================================================================================
            //표창/징계
            mPrinting.XLSetCell(38, 25, "표창/징계");
            //상벌일자
            mPrinting.XLSetCell(38, 27, "상벌일자");
            //상벌구분
            mPrinting.XLSetCell(38, 33, "상벌구분");
            //종류
            mPrinting.XLSetCell(38, 37, "종류");
            //내용
            mPrinting.XLSetCell(38, 41, "내용");
            //======================================================================================
            // 교육사항 항목명
            //======================================================================================
            //교육
            mPrinting.XLSetCell(44, 3, "교 육");
            //교육구분
            mPrinting.XLSetCell(44, 5, "교육구분");
            //기간
            mPrinting.XLSetCell(44, 11, "기 간");
            //교육명
            mPrinting.XLSetCell(44, 18, "교육명");
            //======================================================================================
            // 발령사항 항목명
            //======================================================================================
            //발령이력
            mPrinting.XLSetCell(50, 3, "발 령 이 력");
            //발령일자
            mPrinting.XLSetCell(50, 5, "발령일자");
            //발령
            mPrinting.XLSetCell(50, 12, "발 령");
            //부서
            mPrinting.XLSetCell(50, 18, "부 서");
            //직책
            mPrinting.XLSetCell(50, 23, "직 책");
            //직급
            mPrinting.XLSetCell(50, 27, "직 급");
            //직위
            mPrinting.XLSetCell(50, 31, "직 위");
            //호봉
            mPrinting.XLSetCell(50, 35, "호 봉");
            //비고
            mPrinting.XLSetCell(50, 39, "비 고");
            //======================================================================================
            // 신체/병력사항 항목명
            //======================================================================================
            //병력
            mPrinting.XLSetCell(28, 3, "병력");
            //장애
            mPrinting.XLSetCell(28, 16, "장애");
            //신체
            mPrinting.XLSetCell(29, 3, "신체");
            //병역
            mPrinting.XLSetCell(29, 16, "병역");
            //주소
            mPrinting.XLSetCell(30, 3, "주소");
            //======================================================================================
            // 용지 하단의 출력 정보 항목명
            //======================================================================================
            //출력자
            mPrinting.XLSetCell(65, 27, "출력자 : ");
            //출력일자
            mPrinting.XLSetCell(65, 37, "출력일자 : ");
        }

        #endregion;

        private void XLContentWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, int pTotalRow, int pCnt, string pPrintDateTime, string pUserName)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                if (pCnt == 1)
                {   
                    // 기본 정보1
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("NAME");                 // 성명
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("JOB_CATEGORY_NAME");    // 직구분
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("OPERATING_UNIT_NAME");  // 사업장
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DEPT_NAME");            // 부서    
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("ABIL_NAME");            // 직책    
                    int vIndexDataColumn6 = pGrid.GetColumnToIndex("REPRE_NUM");            // 주민번호
                    int vIndexDataColumn7 = pGrid.GetColumnToIndex("PERSON_NUM");           // 사번    
                    int vIndexDataColumn8 = pGrid.GetColumnToIndex("POST_NAME");            // 직위    
                    int vIndexDataColumn9 = pGrid.GetColumnToIndex("FLOOR_NAME");           // 작업장
                    int vIndexDataColumn10 = pGrid.GetColumnToIndex("JOIN_DATE");           // 입사일자
                    int vIndexDataColumn11 = pGrid.GetColumnToIndex("RETIRE_DATE");         // 퇴사일자
                    int vIndexDataColumn12 = pGrid.GetColumnToIndex("EMAIL");               // 이메일
                    int vIndexDataColumn13 = pGrid.GetColumnToIndex("TELEPHON_NO");         // 전화번호
                    int vIndexDataColumn14 = pGrid.GetColumnToIndex("HP_PHONE_NO");         // 휴대전화
                    int vIndexDataColumn15 = pGrid.GetColumnToIndex("PRSN_ADDR1");          // 주소1
                    int vIndexDataColumn16 = pGrid.GetColumnToIndex("PRSN_ADDR2");          // 주소2
                    

                    //성명
                    mPrinting.XLSetCell(12, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //직군
                    mPrinting.XLSetCell(12, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //사업장
                    mPrinting.XLSetCell(12, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));

                    //부서
                    mPrinting.XLSetCell(14, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //직책
                    mPrinting.XLSetCell(14, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                    //주민번호
                    mPrinting.XLSetCell(14, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn6));

                    //사번
                    mPrinting.XLSetCell(16, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn7));
                    //직위
                    mPrinting.XLSetCell(16, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn8));
                    //작업장
                    mPrinting.XLSetCell(16, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn9));

                    //입사일자
                    object vJoinDate = pGrid.GetCellValue(pIndexRow, vIndexDataColumn10);
                    string vDate = string.Empty;
                    if (iConv.ISNull(vJoinDate) == string.Empty)
                    {
                        vDate = string.Empty;
                    }
                    else if (iDate.ISDate(vJoinDate) == true)
                    {
                        vDate = iDate.ISGetDate(vJoinDate).ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        vDate = string.Empty;
                    }
                    mPrinting.XLSetCell(18, 16, vDate);


                    //DateTime dJoinDate = Convert.ToDateTime(pGrid.GetCellValue(pIndexRow, vIndexDataColumn10));
                    //object vJoinDate = dJoinDate.ToString("yyyy-MM-dd", null).Replace("0001-01-01", null);
                    //mPrinting.XLSetCell(18, 16, vJoinDate);

                    //퇴사일자
                    object vRetireDate = pGrid.GetCellValue(pIndexRow, vIndexDataColumn11);
                    vDate = string.Empty;
                    if (iConv.ISNull(vRetireDate) == string.Empty)
                    {
                        vDate = string.Empty;
                    }
                    else if (iDate.ISDate(vRetireDate) == true)
                    {
                        vDate = iDate.ISGetDate(vRetireDate).ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        vDate = string.Empty;
                    }
                    mPrinting.XLSetCell(18, 27, vDate);


                    //DateTime dRetireDate = Convert.ToDateTime(pGrid.GetCellValue(pIndexRow, vIndexDataColumn11));
                    //object vRetireDate1 = dRetireDate.ToString("yyyy", null);
                    //object vRetireDate2 = dRetireDate.ToString("yyyy-MM-dd", null).Replace("0001-01-01", null);
                    //if (vRetireDate1.ToString() == "0001")
                    //{
                    //    mPrinting.XLSetCell(18, 27, "");
                    //}
                    //else
                    //{
                    //    mPrinting.XLSetCell(18, 27, vRetireDate2);
                    //}

                    //이메일
                    mPrinting.XLSetCell(20, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn12));
                    //전화번호
                    mPrinting.XLSetCell(20, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn13));
                    //휴대전화
                    mPrinting.XLSetCell(20, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn14));

                    //주소
                    object vAddress = string.Format("{0} {1}", pGrid.GetCellValue(pIndexRow, vIndexDataColumn15), pGrid.GetCellValue(pIndexRow, vIndexDataColumn16));
                    mPrinting.XLSetCell(30, 5, vAddress);
                    
                }
                else if (pCnt == 2)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("BANK_NAME");      // 은행명  
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("BANK_ACCOUNTS");  // 계좌번호
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("PAYMENT_DATE");   // 적용기간
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("BASE_AMOUNT");    // 지급금액 
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("PAY_TYPE");       // 급여구분
                    object vPAY_TYPE = pGrid.GetCellValue(pIndexRow, vIndexDataColumn5);
                    if (iConv.ISNull(vPAY_TYPE) == "3")
                    {
                        mPrinting.XLSetCell(44, 33, "연봉");
                    }
                    else
                    {
                        mPrinting.XLSetCell(44, 33, "기본급");
                    }

                    //적용기간
                    mPrinting.XLSetCell(45 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //기본급
                    mPrinting.XLSetCell(45 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));


                    if (pIndexRow < 1)
                    {
                        //은행명
                        mPrinting.XLSetCell(18, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                        //계좌번호
                        mPrinting.XLSetCell(19, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    }
                }
                else if (pCnt == 3)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("SCHOLARSHIP_TYPE_NAME"); // 학력         
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("GRADUATION_YYYYMM");     // 졸업일자
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("SCHOOL_NAME");           // 출신교
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("SPECIAL_STUDY_NAME");    // 전공                

                    //학력
                    mPrinting.XLSetCell(24 + pIndexRow, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //졸업일자
                    mPrinting.XLSetCell(24 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //출신교
                    mPrinting.XLSetCell(24 + pIndexRow, 10, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //전공 
                    mPrinting.XLSetCell(24 + pIndexRow, 19, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 4)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("FAMILY_NAME");    // 성명    
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("RELATION_NAME");  // 관계    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("BIRTHDAY");       // 생년월일
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("COMPANY_NAME");   // 회사명 
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("END_SCH_NAME");   // 학력

                    //성명 
                    mPrinting.XLSetCell(24 + pIndexRow, 30, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //관계
                    mPrinting.XLSetCell(24 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //생년월일 
                    mPrinting.XLSetCell(24 + pIndexRow, 34, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //회사명
                    mPrinting.XLSetCell(24 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //학력
                    mPrinting.XLSetCell(24 + pIndexRow, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                }
                else if (pCnt == 5)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("LICENSE_NAME");         // 자격증명
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("LICENSE_GRADE_NAME");   // 자격등급
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("LICENSE_DATE");         // 취득일자

                    //자격증명
                    mPrinting.XLSetCell(33 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //자격등급
                    mPrinting.XLSetCell(33 + pIndexRow, 12, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //취득일자
                    mPrinting.XLSetCell(33 + pIndexRow, 17, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                }
                else if (pCnt == 6)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("COMPANY_NAME");   // 근무처  
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("POST_NAME");      // 직급    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("JOB_NAME");       // 담당업무
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("CAREER_WORK_PERIOD");     // 입사일 ~ 퇴사일

                    //근무처
                    mPrinting.XLSetCell(33 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //직급
                    mPrinting.XLSetCell(33 + pIndexRow, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //담당업무
                    mPrinting.XLSetCell(33 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //근무기간
                    mPrinting.XLSetCell(33 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 7)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("LANGUAGE_NAME");  // 어학구분
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("EXAM_NAME");      // 어학종류
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("EXAM_LEVEL");     // 등급    
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("SCORE");          // 점수    

                    //어학구분
                    mPrinting.XLSetCell(39 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //어학종류
                    mPrinting.XLSetCell(39 + pIndexRow, 11, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //등급
                    mPrinting.XLSetCell(39 + pIndexRow, 17, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //점수
                    mPrinting.XLSetCell(39 + pIndexRow, 20, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 8)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("RP_TYPE_NAME");    // 상벌구분
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("RP_NAME");         // 상벌사항
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("RP_DATE");         // 상벌일자
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("RP_DESCRIPTION");  // 상벌내용

                    //상벌구분
                    mPrinting.XLSetCell(39 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //상벌종류
                    mPrinting.XLSetCell(39 + pIndexRow, 37, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //상벌일자
                    mPrinting.XLSetCell(39 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //상벌내용
                    mPrinting.XLSetCell(39 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 9)  // 교육사항 //
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("EDUCATION_PERIOD");// 교육기간
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("EDU_ORG");         // 교육구분
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("EDU_CURRICULUM");  // 교육과목

                    //교육기간
                    mPrinting.XLSetCell(45 + pIndexRow, 11, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //교육구분
                    mPrinting.XLSetCell(45 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //교육과목
                    mPrinting.XLSetCell(45 + pIndexRow, 18, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                }
                else if (pCnt == 10)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("CHARGE_DATE");    // 발령일자
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("CHARGE_NAME");    // 발령    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("DESCRIPTION");    // 비고    
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DEPT_NAME");      // 부서    
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("POST_NAME");      // 직위    
                    int vIndexDataColumn6 = pGrid.GetColumnToIndex("ABIL_NAME");      // 직책    
                    int vIndexDataColumn7 = pGrid.GetColumnToIndex("PAY_GRADE_NAME"); // 직급    

                    //발령일자
                    mPrinting.XLSetCell(51 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //발령
                    mPrinting.XLSetCell(51 + pIndexRow, 12, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //비고
                    mPrinting.XLSetCell(51 + pIndexRow, 39, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //부서
                    mPrinting.XLSetCell(51 + pIndexRow, 18, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //직위
                    mPrinting.XLSetCell(51 + pIndexRow, 31, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                    //직책
                    mPrinting.XLSetCell(51 + pIndexRow, 23, pGrid.GetCellValue(pIndexRow, vIndexDataColumn6));
                    //직급
                    mPrinting.XLSetCell(51 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn7));
                }
                else if (pCnt == 11)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("ARMY_KIND_NAME");     // 군별
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("ARMY_GRADE_NAME");    // 계급 
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("ARMY_END_TYPE_NAME"); // 전역구분
                    //int vIndexDataColumn4 = pGrid.GetColumnToIndex("DESCRIPTION");      // 병력

                    // 병역항목 - 군별, 계급, 전역구분
                    object vArmyInfo = pGrid.GetCellValue(pIndexRow, vIndexDataColumn1).ToString() + ", "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn2).ToString() + ", "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn3).ToString();

                    mPrinting.XLSetCell(29 + pIndexRow, 19, vArmyInfo);

                    //병력
                    //mPrinting.XLSetCell(28 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 12)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("HEIGHT");         // 키    
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("WEIGHT");         // 몸무게
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("BLOOD_NAME");     // 혈액형
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DISABLED_NAME");  // 장애
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("DESCRIPTION");    // 병력
                    
                    // 신체항목 - 키, 몸무게, 혈액형
                    object vBodyInfo = pGrid.GetCellValue(pIndexRow, vIndexDataColumn1).ToString() + "cm, "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn2).ToString() + "kg, "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn3).ToString();

                    mPrinting.XLSetCell(29 + pIndexRow, 5, vBodyInfo);

                    //장애
                    mPrinting.XLSetCell(28 + pIndexRow, 19, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //병력
                    mPrinting.XLSetCell(28 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Excel Open and Close ----

        public void XLOpenClose()
        {
            mPrinting.XLOpenFileClose();

            XLFileOpen();
        }
        #endregion;

        #region ----- Excel Wirte Methods ----

        public void XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pRow, int pTerritory, string pPrintDateTime, string pUserName, string pImageName, int pCnt)
        {
            string vMessageText = string.Empty;

            //int vPageNumber = 0;
            int vTotalRow = pGrid.RowCount; // Grid의 총 행수

            try
            {               
                if (pCnt == 1)
                {
                    for (int vRow = 0; vRow <= pRow; vRow++)
                    {
                        //vPageNumber++;

                        //[Content_Printing]
                        XLContentWrite(pGrid, vRow, pRow, pCnt, pPrintDateTime, pUserName);
                    }
                }
 
                if (pCnt != 1)
                {
                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        //vPageNumber++;

                        //[Content_Printing]
                        XLContentWrite(pGrid, vRow, vTotalRow, pCnt, pPrintDateTime, pUserName);
                    }
                }

                if (pCnt == 12) // 12번째 마지막 Grid일 경우,
                {
                    //----------------------------------------[ 증명사진 출력 부분 ]------------------------------------------
                    if (pRow != 0)
                    {
                        int vIndexImage = mPrinting.CountBarCodeImage;
                        int vCountImage = mPrinting.CountBarCodeImage;
                        for (int vRow = 0; vRow < vCountImage; vRow++)
                        {
                            mPrinting.XLDeleteBarCode(vIndexImage);
                            vIndexImage--;
                        }

                        mPrinting.CountBarCodeImage = 0;
                    }

                    System.Drawing.SizeF vSize = new System.Drawing.SizeF(95.2283F, 110.99701F);
                    System.Drawing.PointF vPoint = new System.Drawing.PointF(25F, 125F);
                    mPrinting.XLBarCode(pImageName, vSize, vPoint);
                    //--------------------------------------------------------------------------------------------------------

                    //인사내역 문서에 항목명을 출력해주는 함수 호출
                    ReportTitle();

                    //문서 하단에 출력 정보 표시
                    mPrinting.XLSetCell(65, 31, pUserName);
                    mPrinting.XLSetCell(65, 41, pPrintDateTime);

                    //[Sheet2]내용을 [Sheet1]에 붙여넣기
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);

                    //-------------------------------------------------------------------------------------------------------
                    // 페이지 내용 삭제 부분
                    // (SourceTab1에 데이터 출력 -> Destination에 복사 -> SourceTab1 데이터 삭제 후, 다음 데이터 출력 
                    //-------------------------------------------------------------------------------------------------------
                    mPrinting.XLActiveSheet("SourceTab1");
                    int vStartRow = mPositionPrintLineSTART; //시작 행 위치 부터
                    int vStartCol = mXLColumnAreaSTART;  // +1
                    int vEndRow = mMaxIncrementCopy; // -2
                    int vEndCol = mXLColumnAreaEND;  // -1
                    mPrinting.XLSetCell(vStartRow, vStartCol, vEndRow, vEndCol, null);                  
                }
            }
            catch
            {
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }
        }

        #endregion;

        #region ----- Excel Copy&Paste Methods ----

        //[Sheet2]내용을 [Sheet1]에 붙여넣기
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vPrintHeaderColumnSTART = mXLColumnAreaSTART; //복사되어질 쉬트의 폭, 시작열
            int vPrintHeaderColumnEND = mXLColumnAreaEND;     //복사되어질 쉬트의 폭, 종료열

            int vCopySumPrintingLine = 0;
            vCopySumPrintingLine = pCopySumPrintingLine;

            try
            {
                int vCopyPrintingRowSTART = vCopySumPrintingLine;
                vCopySumPrintingLine = vCopySumPrintingLine + mMaxIncrementCopy;
                int vCopyPrintingRowEnd = vCopySumPrintingLine;

                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호

                mPrinting.XLActiveSheet("Destination"); //mPrinting.XLActiveSheet(1);
                object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
                mPrinting.XLCopyRange(vRangeSource, vRangeDestination);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vCopySumPrintingLine;
            //mPrinting.XLPrintPreview();
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            try
            {
                mPrinting.XLPrinting(pPageSTART, pPageEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        public void PreView()
        {
            try
            {
                mPrinting.XLPrintPreview();
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Save Methods ----

        public void Save(string pSaveFileName)
        {
            try
            {
                System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

                int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
                vMaxNumber = vMaxNumber + 1;
                string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

                vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
                mPrinting.XLSave(vSaveFileName);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

    }
}
#endregion;