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

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX_1 = 183;  // 1page : 61, 2page : 122, 3page : 183 - ����Ǿ��� ���� ����
        private int mIncrementCopyMAX_2 = 61;   // 5page

        private int mCopyColumnSTART = 1;    //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 43;     //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

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
            pGDColumn[0] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RESIDENT_TYPE");        // ���� ����(������1/������2)    
            pGDColumn[1] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NATIONALITY_TYPE");     // ���ܱ��� ����(������1/�ܱ���9)
            pGDColumn[2] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FOREIGN_TAX_YN");       // �ܱ��δ��ϼ�������
            pGDColumn[3] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSEHOLD_TYPE");       // ������ ����(������1/�����2)              
            pGDColumn[4] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_KEEP_TYPE");       // �������걸��

            pGDColumn[5] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CORP_NAME");            // ���θ�(��ȣ)                  
            pGDColumn[6] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRESIDENT_NAME");       // ��ǥ��(����)                  
            pGDColumn[7] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("VAT_NUMBER");           // ����ڵ�Ϲ�ȣ              
            pGDColumn[8] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ORG_ADDRESS");          // ������(�ּ�)

            pGDColumn[9] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NAME");                 // ����
            pGDColumn[10] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REPRE_NUM");           // �ֹι�ȣ
            pGDColumn[11] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PERSON_ADDRESS");      // �ּ�  

            //--------------------------------------------------------------------------------------------------------------------
            // I �ٹ�ó�� �ҵ� ��
            //--------------------------------------------------------------------------------------------------------------------                      
            pGDColumn[12] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_CORP_NAME");      // ��(��)�ٹ�ó��
            pGDColumn[13] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NAME1");    // ��(��)1�ٹ�ó�� 
            pGDColumn[14] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NAME2");    // ��(��)2�ٹ�ó��

            pGDColumn[15] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORK_VAT_NUMBER");     // ��(��)����ڹ�ȣ 
            pGDColumn[16] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NUM1");     // ��(��)1������ȣ
            pGDColumn[17] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW_COMPANY_NUM2");     // ��(��)2������ȣ 

            pGDColumn[18] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE");         // ��(��)�ٹ��Ⱓ
            pGDColumn[19] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE1");        // ��(��)1�ٹ��Ⱓ
            pGDColumn[20] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADJUST_DATE2");        // ��(��)2�ٹ��Ⱓ

            pGDColumn[21] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE");         // ��(��)����Ⱓ 
            pGDColumn[22] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE1");        // ��(��)1����Ⱓ
            pGDColumn[23] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_DATE2");        // ��(��)2����Ⱓ

            pGDColumn[24] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_PAY_TOT_AMT");     // ��(��)�޿� 
            pGDColumn[25] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PAY_TOTAL_AMT1");      // ��(��)1�޿�
            pGDColumn[26] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PAY_TOTAL_AMT2");      // ��(��)2�޿�

            pGDColumn[27] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_BONUS_TOT_AMT");   // ��(��)��   
            pGDColumn[28] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BONUS_TOTAL_AMT1");    // ��(��)1�� 
            pGDColumn[29] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BONUS_TOTAL_AMT2");    // ��(��)2��

            pGDColumn[30] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_ADD_BONUS_AMT");   // ��(��)������   
            pGDColumn[31] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADD_BONUS_AMT1");      // ��(��)1������
            pGDColumn[32] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ADD_BONUS_AMT2");      // ��(��)2������

            pGDColumn[33] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_STOCK_BENE_AMT");  // ��(��)�ֽĸż����ñ�
            pGDColumn[34] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STOCK_BENE_AMT1");     // ��(��)1�ֽĸż����ñ�
            pGDColumn[35] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STOCK_BENE_AMT2");     // ��(��)2�ֽĸż����ñ�

            pGDColumn[36] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT");       // ��(��)�츮�������������
            pGDColumn[37] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT1");      // ��(��)1�츮�������������
            pGDColumn[38] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OWNERSHIP_AMT2");      // ��(��)2�츮�������������

            pGDColumn[39] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NOW_TOTAL_AMOUNT");    // ��(��)��     
            pGDColumn[40] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AMOUNT1");       // ��(��)1��   
            pGDColumn[41] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TOTAL_AMOUNT2");       // ��(��)2��  

            //--------------------------------------------------------------------------------------------------------------------
            // II ����� �� ���� �ҵ� ��
            //--------------------------------------------------------------------------------------------------------------------
            pGDColumn[42] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_OUTSIDE_AMT");  // �����_��(��)���ܱٷ�
            pGDColumn[43] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OUTSIDE_AMT1");     // �����_��(��)1���ܱٷ�
            pGDColumn[44] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OUTSIDE_AMT2");     // �����_��(��)2���ܱٷ�

            pGDColumn[45] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_OT_AMT");       // �����_��(��)�߰��ٷμ��� 
            pGDColumn[46] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OT_AMT1");          // �����_��(��)1�߰��ٷμ���
            pGDColumn[47] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_OT_AMT2");          // �����_��(��)2�߰��ٷμ���

            pGDColumn[48] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_BIRTH_AMT");    // �����_��(��)���/��������
            pGDColumn[49] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_BIRTH_AMT1");       // �����_��(��)1���/��������
            pGDColumn[50] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_BIRTH_AMT2");       // �����_��(��)2���/��������

            pGDColumn[51] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_FOREIGNER_AMT");// �����_��(��)�ܱ��αٷ���
            pGDColumn[52] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_FOREIGNER_AMT1");   // �����_��(��)1�ܱ��αٷ���
            pGDColumn[53] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_FOREIGNER_AMT2");   // �����_��(��)2�ܱ��αٷ���

            pGDColumn[54] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NONTAX_TOTAL_AMOUNT"); // �����_��(��)������ҵ��
            pGDColumn[55] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_TOTAL_AMOUNT1");    // �����_��(��)1������ҵ��
            pGDColumn[56] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NT_TOTAL_AMOUNT2");    // �����_��(��)2������ҵ��

            pGDColumn[57] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT"); // �����_��(��)����ҵ��
            pGDColumn[58] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT1");// �����_��(��)1����ҵ��
            pGDColumn[59] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("REDUCE_TOTAL_AMOUNT2");// �����_��(��)2����ҵ��

            //--------------------------------------------------------------------------------------------------------------------
            // III ���� ��
            //--------------------------------------------------------------------------------------------------------------------
            pGDColumn[60] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_IN_TAX_AMT");      // ��������_�ҵ漼               
            pGDColumn[61] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_LOCAL_TAX_AMT");   // ��������_����ҵ漼               
            pGDColumn[62] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_SP_TAX_AMT");      // ��������_��Ư��               
            pGDColumn[63] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("FIX_TAX_AMOUNT");      // ��������_��   

            pGDColumn[64] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_COMPANY_NUM1");    // �ⳳ�μ���_��(��)1����ڹ�ȣ  
            pGDColumn[65] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_IN_TAX_AMT1");     // �ⳳ�μ���_��(��)1�ҵ漼      
            pGDColumn[66] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_LOCAL_TAX_AMT1");  // �ⳳ�μ���_��(��)1����ҵ漼      
            pGDColumn[67] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_SP_TAX_AMT1");     // �ⳳ�μ���_��(��)1��Ư��      
            pGDColumn[68] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW1_TOTAL_TAX_AMT1");  // �ⳳ�μ���_��(��)1��      

            pGDColumn[69] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_COMPANY_NUM2");    // �ⳳ�μ���_��(��)2����ڹ�ȣ  
            pGDColumn[70] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_IN_TAX_AMT2");     // �ⳳ�μ���_��(��)2�ҵ漼      
            pGDColumn[71] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_LOCAL_TAX_AMT2");  // �ⳳ�μ���_��(��)2����ҵ漼      
            pGDColumn[72] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_SP_TAX_AMT2");     // �ⳳ�μ���_��(��)2��Ư��      
            pGDColumn[73] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PW2_TOTAL_TAX_AMT2");  // �ⳳ�μ���_��(��)2��        

            pGDColumn[74] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_IN_TAX_AMT");      // �ⳳ�μ���_��(��)�ҵ漼       
            pGDColumn[75] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_LOCAL_TAX_AMT");   // �ⳳ�μ���_��(��)����ҵ漼       
            pGDColumn[76] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_SP_TAX_AMT");      // �ⳳ�μ���_��(��)��Ư��       
            pGDColumn[77] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PRE_TAX_AMOUNT");      // �ⳳ�μ���_��(��)��

            pGDColumn[78] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_IN_TAX_AMT");     // ����¡������_�ҵ漼           
            pGDColumn[79] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_LOCAL_TAX_AMT");  // ����¡������_����ҵ漼         
            pGDColumn[80] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_SP_TAX_AMT");     // ����¡������_��Ư��           
            pGDColumn[81] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_TAX_AMOUNT");     // ����¡������_��

            //----[ 2 page ]------------------------------------------------------------------------------------------------------
            pGDColumn[82] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_TOT_AMT");           // �ѱ޿�
            pGDColumn[83] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PERS_ANNU_BANK_AMT");       // ���ο�������ҵ����
              
            pGDColumn[84] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_DED_AMT");           // �ٷμҵ����
            pGDColumn[85] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ANNU_BANK_AMT");            // ��������ҵ����
         
            pGDColumn[86] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INCOME_AMT");               // �ٷμҵ�ݾ�
            pGDColumn[87] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SMALL_CORPOR_DED_AMT");     // �ұ��/�һ���� �����α� �ҵ����
         
            pGDColumn[88] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("PER_DED_AMT");              // �⺻(����)
            pGDColumn[89] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_APP_SAVE_AMT");       // û������
           
            pGDColumn[90] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SPOUSE_DED_AMT");           // �⺻(�����)
            pGDColumn[91] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_APP_DEPOSIT_AMT");    // ����û����������
         
            pGDColumn[92] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUPP_DED_COUNT");           // �⺻(�ξ��ο� - �ο�)            
            pGDColumn[93] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUPP_DED_AMT");             // �⺻(�ξ��ο� - �ݾ�)
            pGDColumn[94] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_SAVE_AMT");           // ������ø�������
             
            pGDColumn[95] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OLD_DED_COUNT");            // �߰�����(��μ� - �ο�)          
            pGDColumn[96] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("OLD_DED_AMT");              // �߰�����(��μ� - �ݾ�)
            pGDColumn[97] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WORKER_HOUSE_SAVE_AMT");    // �ٷ������ø�������
          
            pGDColumn[98] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_DED_COUNT");         // �߰�����(����� - �ο�)          
            pGDColumn[99] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_DED_AMT");           // �߰�����(����� - �ݾ�)
            pGDColumn[100] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("INVES_AMT");               // �����������ڵ� �ҵ����
          
            pGDColumn[101] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("WOMAN_DED_AMT");           // �߰�����(�γ༼��)
            pGDColumn[102] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CREDIT_AMT");              // �ſ�ī��� �ҵ����
   
            pGDColumn[103] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CHILD_DED_COUNT");         // �߰�����(�ڳ���� - �ο�)        
            pGDColumn[104] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("CHILD_DED_AMT");           // �߰�����(�ڳ���� - �ݾ�)
            pGDColumn[105] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EMPL_STOCK_AMT");          // �츮��������
        
            pGDColumn[106] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BIRTH_DED_COUNT");         // �߰�����(����Ծ� - �ο�)        
            pGDColumn[107] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("BIRTH_DED_AMT");           // �߰�����(����Ծ� - �ݾ�)
            pGDColumn[108] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_STOCK_SAVING_AMT");   // ����ֽ�������

            pGDColumn[109] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HIRE_KEEP_EMPLOY_AMT");    // ��������߼ұ���ҵ����

            pGDColumn[110] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MANY_CHILD_DED_COUNT");    // ���ڳ����(�ο�)                 
            pGDColumn[111] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MANY_CHILD_DED_AMT");      // ���ڳ����(�ݾ�) 
                
            pGDColumn[112] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("NATI_ANNU_AMT");           // ���ο��ݺ�������               

            pGDColumn[113] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("ETC_DED_SUM");             // �׹��Ǽҵ���� ��

            pGDColumn[114] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_STD_AMT");             // ���հ���ǥ��

            pGDColumn[115] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("COMP_TAX_AMT");            // ���⼼��

            pGDColumn[116] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_IN_LAW_AMT");     // �ҵ漼��
                  
            pGDColumn[117] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("RETR_ANNU_AMT");           // �������ݼҵ����                 
            pGDColumn[118] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_SP_LAW_AMT");     // ����Ư�����ѹ�

            pGDColumn[119] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MEDIC_INSUR_AMT");         // �ǰ������                       
            pGDColumn[120] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HIRE_INSUR_AMT");          // ��뺸���                       
            pGDColumn[121] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("GUAR_INSUR_AMT");          // ���强����                       
            pGDColumn[122] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DEFORM_INSUR_AMT");        // ��������� 
                      
            pGDColumn[123] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("MEDIC_AMT");               // Ư������(�Ƿ��) 
            pGDColumn[124] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_REDU_SUM");            // ���װ��� ��  
  
            pGDColumn[125] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("EDUCATION_AMT");           // Ư������(������) 
            pGDColumn[126] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_INCOME_AMT");      // �ٷμҵ�                

            pGDColumn[127] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_INTER_AMT");         // Ư������(�����������Ա�) 
            pGDColumn[128] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_TAXGROUP_AMT");    // �������հ���

            pGDColumn[129] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("HOUSE_MONTHLY_AMT");       // Ư������(����)
                   
            pGDColumn[130] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("LONG_HOUSE_PROF_AMT");     // Ư������(����������Ա�)
            pGDColumn[131] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_HOUSE_DEBT_AMT");  // �������Ա�

            pGDColumn[132] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("DONAT_AMT");               // Ư������(��α�) 
            pGDColumn[133] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_DONAT_POLI_AMT");  // ��� ��ġ�ڱ�

            pGDColumn[134] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_OUTSIDE_PAY_AMT"); // �ܱ� ����

            pGDColumn[135] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SP_DED_SUM");              // Ư������(��)

            pGDColumn[136] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("STAND_DED_AMT");           // Ư������(ǥ�ذ���)
            pGDColumn[137] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("TAX_DED_SUM");             // ���װ��� ��         
                  
            pGDColumn[138] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SUBT_DED_AMT");            // �����ҵ�ݾ�                      
            pGDColumn[139] = pGrid_WITHHOLDING_TAX.GetColumnToIndex("SET_TAX_SUM");             // ��������                         

            //----[ 1 page ]------------------------------------------------------------------------------------------------------
            pXLColumn[0] = 37;  // ���� ����(������1/������2)    
            pXLColumn[1] = 37;  // ���ܱ��� ����(������1/�ܱ���9)
            pXLColumn[2] = 39;  // �ܱ��δ��ϼ�������            
            pXLColumn[3] = 37;  // ������ ����(������1/�����2)  
            pXLColumn[4] = 37;  // �������걸��                  

            pXLColumn[5] = 11;  // ���θ�(��ȣ)                  
            pXLColumn[6] = 30;  // ��ǥ��(����)                  
            pXLColumn[7] = 11;  // ����ڵ�Ϲ�ȣ                
            pXLColumn[8] = 11;  // ������(�ּ�)                  

            pXLColumn[9] = 11;  // ����                          
            pXLColumn[10] = 30;  // �ֹι�ȣ                      
            pXLColumn[11] = 11;  // �ּ�                          

            //--------------------------------------------------------------------------------------------------------------------
            // I �ٹ�ó�� �ҵ� ��
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[12] = 11;  // ��(��)�ٹ�ó��                
            pXLColumn[13] = 17;  // ��(��)1�ٹ�ó��               
            pXLColumn[14] = 23;  // ��(��)2�ٹ�ó��               

            pXLColumn[15] = 11;  // ��(��)����ڹ�ȣ              
            pXLColumn[16] = 17;  // ��(��)1������ȣ             
            pXLColumn[17] = 23;  // ��(��)2������ȣ             

            pXLColumn[18] = 11;  // ��(��)�ٹ��Ⱓ                
            pXLColumn[19] = 17;  // ��(��)1�ٹ��Ⱓ               
            pXLColumn[20] = 23;  // ��(��)2�ٹ��Ⱓ               

            pXLColumn[21] = 11;  // ��(��)����Ⱓ                
            pXLColumn[22] = 17;  // ��(��)1����Ⱓ               
            pXLColumn[23] = 23;  // ��(��)2����Ⱓ               

            pXLColumn[24] = 11;  // ��(��)�޿�                    
            pXLColumn[25] = 17;  // ��(��)1�޿�                   
            pXLColumn[26] = 23;  // ��(��)2�޿�                   

            pXLColumn[27] = 11;  // ��(��)��                    
            pXLColumn[28] = 17;  // ��(��)1��                   
            pXLColumn[29] = 23;  // ��(��)2��                   

            pXLColumn[30] = 11;  // ��(��)������                
            pXLColumn[31] = 17;  // ��(��)1������               
            pXLColumn[32] = 23;  // ��(��)2������               

            pXLColumn[33] = 11;  // ��(��)�ֽĸż����ñ�          
            pXLColumn[34] = 17;  // ��(��)1�ֽĸż����ñ�         
            pXLColumn[35] = 23;  // ��(��)2�ֽĸż����ñ�         

            pXLColumn[36] = 11;  // ��(��)�츮�������������      
            pXLColumn[37] = 17;  // ��(��)1�츮�������������     
            pXLColumn[38] = 23;  // ��(��)2�츮�������������     

            pXLColumn[39] = 11;  // ��(��)��                      
            pXLColumn[40] = 17;  // ��(��)1��                     
            pXLColumn[41] = 23;  // ��(��)2��                     

            //--------------------------------------------------------------------------------------------------------------------
            // II ����� �� ���� �ҵ� ��
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[42] = 11;  // �����_��(��)���ܱٷ�       
            pXLColumn[43] = 17;  // �����_��(��)1���ܱٷ�      
            pXLColumn[44] = 23;  // �����_��(��)2���ܱٷ�      

            pXLColumn[45] = 11;  // �����_��(��)�߰��ٷμ���   
            pXLColumn[46] = 17;  // �����_��(��)1�߰��ٷμ���  
            pXLColumn[47] = 23;  // �����_��(��)2�߰��ٷμ���  

            pXLColumn[48] = 11;  // �����_��(��)���/��������  
            pXLColumn[49] = 17;  // �����_��(��)1���/�������� 
            pXLColumn[50] = 23;  // �����_��(��)2���/�������� 

            pXLColumn[51] = 11;  // �����_��(��)�ܱ��αٷ���   
            pXLColumn[52] = 17;  // �����_��(��)1�ܱ��αٷ���  
            pXLColumn[53] = 23;  // �����_��(��)2�ܱ��αٷ���  

            pXLColumn[54] = 11;  // �����_��(��)������ҵ��   
            pXLColumn[55] = 17;  // �����_��(��)1������ҵ��  
            pXLColumn[56] = 23;  // �����_��(��)2������ҵ��  

            pXLColumn[57] = 11;  // �����_��(��)����ҵ��     
            pXLColumn[58] = 17;  // �����_��(��)1����ҵ��    
            pXLColumn[59] = 23;  // �����_��(��)2����ҵ��    

            //--------------------------------------------------------------------------------------------------------------------
            // III ���� ��
            //--------------------------------------------------------------------------------------------------------------------
            pXLColumn[60] = 19;  // ��������_�ҵ漼              
            pXLColumn[61] = 25;  // ��������_����ҵ漼          
            pXLColumn[62] = 31;  // ��������_��Ư��              
            pXLColumn[63] = 36;  // ��������_��                  

            pXLColumn[64] = 14;  // �ⳳ�μ���_��(��)1����ڹ�ȣ 
            pXLColumn[65] = 19;  // �ⳳ�μ���_��(��)1�ҵ漼     
            pXLColumn[66] = 25;  // �ⳳ�μ���_��(��)1����ҵ漼 
            pXLColumn[67] = 31;  // �ⳳ�μ���_��(��)1��Ư��     
            pXLColumn[68] = 36;  // �ⳳ�μ���_��(��)1��         

            pXLColumn[69] = 14;  // �ⳳ�μ���_��(��)2����ڹ�ȣ 
            pXLColumn[70] = 19;  // �ⳳ�μ���_��(��)2�ҵ漼     
            pXLColumn[71] = 25;  // �ⳳ�μ���_��(��)2����ҵ漼 
            pXLColumn[72] = 31;  // �ⳳ�μ���_��(��)2��Ư��                  
            pXLColumn[73] = 36;  // �ⳳ�μ���_��(��)2��         

            pXLColumn[74] = 19;  // �ⳳ�μ���_��(��)�ҵ漼      
            pXLColumn[75] = 25;  // �ⳳ�μ���_��(��)����ҵ漼  
            pXLColumn[76] = 31;  // �ⳳ�μ���_��(��)��Ư��      
            pXLColumn[77] = 36;  // �ⳳ�μ���_��(��)��          

            pXLColumn[78] = 19;  // ����¡������_�ҵ漼          
            pXLColumn[79] = 25;  // ����¡������_����ҵ漼      
            pXLColumn[80] = 31;  // ����¡������_��Ư��          
            pXLColumn[81] = 36;  // ����¡������_��  

            //----[ 2 page ]------------------------------------------------------------------------------------------------------
            pXLColumn[82] = 16; // �ѱ޿�
            pXLColumn[83] = 36; // ���ο�������ҵ����

            pXLColumn[84] = 16; // �ٷμҵ����
            pXLColumn[85] = 36; // ��������ҵ����

            pXLColumn[86] = 16; // �ٷμҵ�ݾ�
            pXLColumn[87] = 36; // �ұ��/�һ���� �����α� �ҵ����

            pXLColumn[88] = 16; // �⺻(����)
            pXLColumn[89] = 36; // û������

            pXLColumn[90] = 16; // �⺻(�����)
            pXLColumn[91] = 36; // ����û����������

            pXLColumn[92] = 10; // �⺻(�ξ��ο� - �ο�)            
            pXLColumn[93] = 16; // �⺻(�ξ��ο� - �ݾ�)
            pXLColumn[94] = 36; // ������ø�������

            pXLColumn[95] = 10; // �߰�����(��μ� - �ο�)          
            pXLColumn[96] = 16; // �߰�����(��μ� - �ݾ�)
            pXLColumn[97] = 36; // �ٷ������ø�������

            pXLColumn[98] = 10; // �߰�����(����� - �ο�)          
            pXLColumn[99] = 16; // �߰�����(����� - �ݾ�)
            pXLColumn[100] = 36; // �����������ڵ� �ҵ����

            pXLColumn[101] = 16; // �߰�����(�γ༼��)
            pXLColumn[102] = 36; // �ſ�ī��� �ҵ����

            pXLColumn[103] = 10; // �߰�����(�ڳ���� - �ο�)        
            pXLColumn[104] = 16; // �߰�����(�ڳ���� - �ݾ�)
            pXLColumn[105] = 36; // �츮��������

            pXLColumn[106] = 11; // �߰�����(����Ծ� - �ο�)        
            pXLColumn[107] = 16; // �߰�����(����Ծ� - �ݾ�)
            pXLColumn[108] = 36; // ����ֽ�������

            pXLColumn[109] = 36; // ��������߼ұ���ҵ����

            pXLColumn[110] = 9; // ���ڳ����(�ο�)                 
            pXLColumn[111] = 16; // ���ڳ����(�ݾ�) 

            pXLColumn[112] = 16; // ���ο��ݺ�������               

            pXLColumn[113] = 36; // �׹��Ǽҵ���� ��

            pXLColumn[114] = 36; // ���հ���ǥ��

            pXLColumn[115] = 36; // ���⼼��

            pXLColumn[116] = 36; // �ҵ漼��

            pXLColumn[117] = 16; // �������ݼҵ����                 
            pXLColumn[118] = 36; // ����Ư�����ѹ�

            pXLColumn[119] = 16; // �ǰ������                       
            pXLColumn[120] = 16; // ��뺸���                       
            pXLColumn[121] = 16; // ���强����                       
            pXLColumn[122] = 16; // ��������� 

            pXLColumn[123] = 16; // Ư������(�Ƿ��) 
            pXLColumn[124] = 36; // ���װ��� ��  

            pXLColumn[125] = 16; // Ư������(������) 
            pXLColumn[126] = 36; // �ٷμҵ�                

            pXLColumn[127] = 16; // Ư������(�����������Ա�) 
            pXLColumn[128] = 36; // �������հ���

            pXLColumn[129] = 16; // Ư������(����)

            pXLColumn[130] = 16; // Ư������(����������Ա�)
            pXLColumn[131] = 36; // �������Ա�

            pXLColumn[132] = 16; // Ư������(��α�) 
            pXLColumn[133] = 36; // ��� ��ġ�ڱ�

            pXLColumn[134] = 36; // �ܱ� ����

            pXLColumn[135] = 16; // ��

            pXLColumn[136] = 16; // Ư������(ǥ�ذ���)
            pXLColumn[137] = 36; // ���װ��� ��         

            pXLColumn[138] = 16; // �����ҵ�ݾ�  
            pXLColumn[139] = 36; // ��������    
        }

        #endregion;

        #region ----- Array Set 2 ----
        private void SetArray2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_SUPPORT_FAMILY, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[25];
            pXLColumn = new int[25];

            pGDColumn[0]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("MANY_CHILD_DED_COUNT");  // ���ڳ� �ο���
            pGDColumn[1]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("RELATION_CODE");         // �����ڵ�         
            pGDColumn[2]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("FAMILY_NAME");           // ����             
            pGDColumn[3]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("BASE_YN");               // �⺻����         
            pGDColumn[4]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("OLD_YN");                // ��ο��         
            pGDColumn[5]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("BIRTH_YN");              // ���/�Ծ����    
            pGDColumn[6]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("DEFORM_YN");             // �����           
            pGDColumn[7]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHILD_YN");              // �ڳ����(6������)
            pGDColumn[8]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("INSURE_AMT");            // ����û-�����    
            pGDColumn[9]  = pGrid_SUPPORT_FAMILY.GetColumnToIndex("MEDICAL_AMT");           // ����û-�Ƿ��    
            pGDColumn[10] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("EDU_AMT");               // ����û-������    
            pGDColumn[11] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CREDIT_AMT");            // ����û-�ſ�ī��  
            pGDColumn[12] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHECK_CREDIT_AMT");      // ����û-����ī��  
            pGDColumn[13] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CASH_AMT");              // ����û-����      
            pGDColumn[14] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("DONAT_AMT");             // ����û-��α�    
            pGDColumn[15] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("NATIONALITY_TYPE");      // ����Ÿ��         
            pGDColumn[16] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("REPRE_NUM");             // �ֹι�ȣ         
            pGDColumn[17] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("WOMAN_YN");              // �γ���           
            pGDColumn[18] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_INSURE_AMT");        // ��Ÿ-�����      
            pGDColumn[19] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_MEDICAL_AMT");       // ��Ÿ-�Ƿ��      
            pGDColumn[20] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_EDU_AMT");           // ��Ÿ-������      
            pGDColumn[21] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_CREDIT_AMT");        // ��Ÿ-�ſ�ī��    
            pGDColumn[22] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("CHECK_ETC_CREDIT_AMT");  // ��Ÿ-����ī��    
            pGDColumn[23] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_CASH_AMT");          // ��Ÿ-����        
            pGDColumn[24] = pGrid_SUPPORT_FAMILY.GetColumnToIndex("ETC_DONAT_AMT");         // ��Ÿ-��α� 

            pXLColumn[0]  = 7;   // ���ڳ� �ο���
            pXLColumn[1]  = 1;   // �����ڵ�         
            pXLColumn[2]  = 3;   // ����             
            pXLColumn[3]  = 9;   // �⺻����         
            pXLColumn[4]  = 11;  // ��ο��         
            pXLColumn[5]  = 13;  // ���/�Ծ����    
            pXLColumn[6]  = 15;  // �����           
            pXLColumn[7]  = 17;  // �ڳ����(6������)
            pXLColumn[8]  = 22;  // ����û-�����    
            pXLColumn[9]  = 25;  // ����û-�Ƿ��    
            pXLColumn[10] = 28;  // ����û-������    
            pXLColumn[11] = 31;  // ����û-�ſ�ī��  
            pXLColumn[12] = 34;  // ����û-����ī��  
            pXLColumn[13] = 37;  // ����û-����      
            pXLColumn[14] = 40;  // ����û-��α�    
            pXLColumn[15] = 1;   // ����Ÿ��         
            pXLColumn[16] = 3;   // �ֹι�ȣ         
            pXLColumn[17] = 9;   // �γ���           
            pXLColumn[18] = 22;  // ��Ÿ-�����      
            pXLColumn[19] = 25;  // ��Ÿ-�Ƿ��      
            pXLColumn[20] = 28;  // ��Ÿ-������      
            pXLColumn[21] = 31;  // ��Ÿ-�ſ�ī��    
            pXLColumn[22] = 34;  // ��Ÿ-����ī��    
            pXLColumn[23] = 37;  // ��Ÿ-����        
            pXLColumn[24] = 40;  // ��Ÿ-��α�
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
            int vXLine = pXLine; // ������ ������ ǥ�õǴ� �� ��ȣ

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

                // ���� ����(������1/������2)
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //������1�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "��");
                    }
                    else //������ 2�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "��");
                    }                    
                }
                else
                {
                    vConvertString = string.Empty;
                    //������1�̸�,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //������ 2�̸�,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // ���ܱ��� ����(������1/�ܱ���9)
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //������1�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "��");
                    }
                    else //�ܱ���9�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "��");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //������1�̸�,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //�ܱ���9�̸�,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // �ܱ��δ��ϼ�������
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "Y") //��1�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "��");
                    }
                    else //��2�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 3), "��");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //��1�̸�,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //��2�̸�,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 3), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // ��� �뵵 ����
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

                // ������ ����(������1/�����2)
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "1") //������1�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "��");
                    }
                    else //�����2�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "��");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //������1�̸�,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //�����2�̸�,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // �������걸��
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid_WITHHOLDING_TAX.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    if (vConvertString == "��ӱٷ�") //��ӱٷ�1�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, "��");
                    }
                    else //�ߵ����2�̸�,
                    {
                        mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), "��");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    //��ӱٷ�1�̸�,
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    //�ߵ����2�̸�,
                    mPrinting.XLSetCell(vXLine, (vXLColumnIndex + 5), vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                // ���θ�(��ȣ)
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

                // ��ǥ��(����)    
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

                // ����ڵ�Ϲ�ȣ
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

                // ������(�ּ�)
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

                // ����
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

                // �ֹι�ȣ
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

                // �ּ�
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

                // ��(��)�ٹ�ó��
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

                // ��(��)1�ٹ�ó��
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

                // ��(��)2�ٹ�ó��
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

                // ��(��)����ڹ�ȣ
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

                // ��(��)1������ȣ
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

                // ��(��)2������ȣ
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

                // ��(��)�ٹ��Ⱓ
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

                // ��(��)1�ٹ��Ⱓ
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

                // ��(��)2�ٹ��Ⱓ
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

                // ��(��)����Ⱓ
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

                // ��(��)1����Ⱓ
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

                // ��(��)2����Ⱓ
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

                // ��(��)�޿� 
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

                // ��(��)1�޿�
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

                // ��(��)2�޿�
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

                // ��(��)��
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

                // ��(��)1��
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

                // ��(��)2��
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

                // ��(��)������ 
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

                // ��(��)1������
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

                // ��(��)2������
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

                // ��(��)�ֽĸż����ñ�
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

                // ��(��)1�ֽĸż����ñ�
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

                // ��(��)2�ֽĸż����ñ�
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

                // ��(��)�츮�������������
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

                // ��(��)1�츮�������������
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

                // ��(��)2�츮�������������
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

                // ��(��)��
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

                // ��(��)1��
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

                // ��(��)2��
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
                // II ����� �� ���� �ҵ� ��
                //--------------------------------------------------------------------------------------------------------------------

                // �����_��(��)���ܱٷ�
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

                // �����_��(��)1���ܱٷ�
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

                // �����_��(��)2���ܱٷ�
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

                // �����_��(��)�߰��ٷμ���
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

                // �����_��(��)1�߰��ٷμ���
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

                // �����_��(��)2�߰��ٷμ���
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

                // �����_��(��)���/��������
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

                // �����_��(��)1���/��������
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

                // �����_��(��)2���/��������
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

                // �����_��(��)�ܱ��αٷ���
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

                // �����_��(��)1�ܱ��αٷ���
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

                // �����_��(��)2�ܱ��αٷ���
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

                // �����_��(��)������ҵ��
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

                // �����_��(��)1������ҵ��
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

                // �����_��(��)2������ҵ��
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

                // �����_��(��)����ҵ��
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

                // �����_��(��)1����ҵ��
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

                // �����_��(��)2����ҵ��
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
                // III ���� ��
                //--------------------------------------------------------------------------------------------------------------------

                // ��������_�ҵ漼
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

                // ��������_����ҵ漼   
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

                // ��������_��Ư��
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

                // ��������_��
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

                // �ⳳ�μ���_��(��)1����ڹ�ȣ 
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

                // �ⳳ�μ���_��(��)1�ҵ漼
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
  
                // �ⳳ�μ���_��(��)1����ҵ漼
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

                // �ⳳ�μ���_��(��)1��Ư��
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
   
                // �ⳳ�μ���_��(��)1��
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

                // �ⳳ�μ���_��(��)2����ڹ�ȣ 
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

                // �ⳳ�μ���_��(��)2�ҵ漼
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

                // �ⳳ�μ���_��(��)2����ҵ漼
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

                // �ⳳ�μ���_��(��)2��Ư��
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

                // �ⳳ�μ���_��(��)2��
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

                // �ⳳ�μ���_��(��)�ҵ漼 
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

                // �ⳳ�μ���_��(��)����ҵ漼
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

                //�ⳳ�μ���_��(��)��Ư��
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

                // �ⳳ�μ���_��(��)��
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

                // ����¡������_�ҵ漼 
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

                // ����¡������_����ҵ漼
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

                // ����¡������_��Ư��
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

                // ����¡������_��
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

                // ��¥
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

                // 2page ��ܿ� �ҵ��� ���� �� �ֹι�ȣ ��� ǥ�õǴ� �κ�
                string sPrintPersinInfo = sName + "(" + sPersonNumber + ")";
                mPrinting.XLSetCell(vXLine, 24, sPrintPersinInfo);

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // �ѱ޿�
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

                // ���ο�������ҵ����
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
                // �ٷμҵ����
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

                // ��������ҵ����
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
                // �ٷμҵ�ݾ�
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

                // �ұ��/�һ���� �����α� �ҵ����
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
                // �⺻(����)
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

                // û������
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
                // �⺻(�����)
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

                // ����û����������
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
                // �⺻(�ξ��ο� - �ο�)  
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

                // �⺻(�ξ��ο� - �ݾ�) 
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

                // ������ø�������
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
                // �߰�����(��μ� - �ο�)
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

                // �߰�����(��μ� - �ݾ�)
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

                // �ٷ������ø�������
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
                // �߰�����(����� - �ο�)
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

                // �߰�����(����� - �ݾ�)
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

                // �����������ڵ� �ҵ����
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
                // �߰�����(�γ༼��)
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

                // �ſ�ī��� �ҵ����
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
                // �߰�����(�ڳ���� - �ο�)    
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

                // �߰�����(�ڳ���� - �ݾ�)
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

                // �츮��������
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
                // �߰�����(����Ծ� - �ο�) 
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

                // �߰�����(����Ծ� - �ݾ�)
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

                // ����ֽ�������
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
                // ��������߼ұ���ҵ����
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
                // ���ڳ����(�ο�)  
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

                // ���ڳ����(�ݾ�)  
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
                // ���ο��ݺ�������
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
                // �� ���� �ҵ���� ��
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
                // ���ռҵ� ����ǥ��
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
                // ���⼼��
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
                // �ҵ漼��
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
                // �ٷ����������ݼҵ����
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

                // ����Ư�����ѹ�
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
                // �ǰ������
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
                // ��뺸���
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
                // ���强 ����
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
                // ����� ����
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
                // �Ƿ��
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

                // ���װ��� ��
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
                // ������
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
                // �ٷμҵ�
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
                // �����������Ա� ������ ��ȯ��
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
                // �������� ����
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
                // ������
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
                // ����������� ���Ա� ���� ��ȯ��
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

                // �������Ա�
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
                // ��α�
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

                // ��� ��ġ�ڱ�
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
                // �ܱ�����
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
                // ��
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
                // ǥ�ذ���
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

                // ���װ��� ��
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
                // �����ҵ�ݾ�
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

                // ��������
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
            int vXLine = pXLine; // ������ ������ ǥ�õǴ� �� ��ȣ

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
                    // ���ڳ� �ο� ��
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

                    // �����ڵ�
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

                    // ����
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

                    // �⺻����
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

                    // ��ο��
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

                    // ���/�Ծ����
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

                    // �����
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

                    // �ڳ����(6������)
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

                    // ����û-�����
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

                    // ����û-�Ƿ��
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

                    // ����û-������
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

                    // ����û-�ſ�ī��
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

                    // ����û-����ī��
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

                    // ����û-����
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

                    // ����û-��α�
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

                    // ����Ÿ��
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

                    // �ֹι�ȣ
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

                    // �γ���
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

                    // ��Ÿ-�����
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

                    // ��Ÿ-�Ƿ��
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

                    // ��Ÿ-������
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

                    // ��Ÿ-�ſ�ī��
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

                    // ��Ÿ-����ī��
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

                    // ��Ÿ-����
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

                    // ��Ÿ-��α�
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

                    // �����ڵ�
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

                    // ����
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

                    // �⺻����
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

                    // ��ο��
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

                    // ���/�Ծ����
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

                    // �����
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

                    // �ڳ����(6������)
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

                    // ����û-�����
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

                    // ����û-�Ƿ��
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

                    // ����û-������
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

                    // ����û-�ſ�ī��
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

                    // ����û-����ī��
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

                    // ����û-����
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

                    // ����û-��α�
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

                    // ����Ÿ��
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

                    // �ֹι�ȣ
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

                    // �γ���
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

                    // ��Ÿ-�����
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

                    // ��Ÿ-�Ƿ��
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

                    // ��Ÿ-������
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

                    // ��Ÿ-�ſ�ī��
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

                    // ��Ÿ-����ī��
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

                    // ��Ÿ-����
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

                    // ��Ÿ-��α�
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
            int vXLine = pXLine; // ������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");


                // ���θ�(��ȣ)
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

                // ����ڵ�Ϲ�ȣ
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

                // ����
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

                // �ֹι�ȣ
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

                // �ּ�
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

                // ���� ��ȭ��ȣ
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

                // ����� ������
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

                // ����� ��ȭ��ȣ
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
            int vXLine = pXLine; // ������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                // ����TYPE��[���౸��]
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

                // ���������
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

                // ���¹�ȣ
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

                // ���Աݾ�
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

                // �����ݾ�
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
            int vXLine = pXLine; // ������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                // ���������
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

                // ���¹�ȣ
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

                // ���Կ���
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

                // ���Աݾ�
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

                // �����ݾ�
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

        //30�徿
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

            //int vSecondPrinting = 9; //1�δ� 3�������̹Ƿ�, 3*10=30��°�� �μ�
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

                    vMessageText = string.Format("{0} - {1}", vMessageText, "�ٷμҵ��õ¡��������");
                    mAppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    // �ٷμҵ��õ¡�������� page 1 - 2.
                    //int vLinePrinting_1 = vPrintingLine + 3;
                    vPrintingLine = XLLine1(pGrid_WITHHOLDING_TAX, vRow1, vPrintingLine, vGDColumn_1, vXLColumn_1, vPrintDate, vPrintType);
                    //---------------------------------------------------------------------------------------------------------------------

                    vMessageText = string.Format("{0} - {1}", vMessageText, "�ξ簡������");
                    mAppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    // �ξ簡������ page 3.
                    int vPrintingLine_2 = vPrintingLine + 8;
                    for (int vRow2 = 0; vRow2 < vTotalRow2; vRow2++)
                    {
                        vPrintingLine = XLLine2(pGrid_SUPPORT_FAMILY, vRow2, vPrintingLine, vGDColumn_2, vXLColumn_2);
                    }
                    //---------------------------------------------------------------------------------------------------------------------

                    //����/���� �� �ҵ���� ���� Page 5
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
                        vMessageText = string.Format("{0} - {1}", vMessageText, "����/���� �ҵ����");
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

                            vCountRow_2 = 6 - vCountRow_2; //6�ٿ��� ��µ��� ���� �ټ�
                            vPrintingLine = vPrintingLine + vCountRow_2; //��µ��� ���� �� ��ŭ ����, ���� ��� ��ġ�� ����
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
                    //    //Printing(1, (vCountPrinting * 3)); //vSecondPrinting, (vRowCount * 3) 1���� 1�ʺ��� �ش� �ʼ����� ���������� ���� ������ *2�� �� ����.
                    //    if (pOutChoice == "PRINT")
                    //    {
                    //        Printing(1, (vCountPrinting * 3)); //vSecondPrinting, (vRowCount * 3) 1���� 1�ʺ��� �ش� �ʼ����� ���������� ���� ������ *2�� �� ����.
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

        //ù��° ������ ����
        private int CopyAndPaste_1(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX_1;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            mPrinting.XLActiveSheet("SourceTab1");

            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX_1, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber = mPageNumber + 3; //������ ��ȣ

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method 2 ----

        //�ι�° ������ ����
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

            mPageNumber++; //������ ��ȣ

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