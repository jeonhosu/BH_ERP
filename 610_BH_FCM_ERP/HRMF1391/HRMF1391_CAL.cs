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

namespace HRMF1391
{
    public partial class HRMF1391_CAL : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        DateTime mSTART_DATE;
        DateTime mEND_DATE;              // 급상여 구분.
        object mCORP_ID;
        object mDEPT_ID;
        object mFLOOR_ID;
        object mPERSON_ID; 
        string mALL_FLAG;
        object mWORK_TYPE_ID;
        object mJOB_CATEGORY_ID; 


        #endregion;

        #region ----- Constructor -----

        public HRMF1391_CAL(ISAppInterface pAppInterface, object pSTART_DATE, object pEND_DATE, 
                            object pCORP_ID , object pCORP_NAME,
                            object pDEPT_ID , object pDEPT_NAME,
                            object pFLOOR_ID, object pFLOOR_NAME,
                            object pWORK_TYPE_ID, object pWORK_TYPE_NAME ,
                            object pJOB_CATEGORY_ID, object pJOB_CATEGORY_NAME,
                           // object pALL_FLAG, 
                            object pPERSON_ID, object pNAME/*, Form pMainForm*/)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;
            //this.MdiParent = pMainForm;

            mSTART_DATE =iDate.ISGetDate(pSTART_DATE);
            mEND_DATE = iDate.ISGetDate(pEND_DATE);
            mCORP_ID = pCORP_ID;// iString.ISDecimaltoZero(pCORP_ID);
            mDEPT_ID = pDEPT_ID;// iString.ISDecimaltoZero(pDEPT_ID);
            mFLOOR_ID = pFLOOR_ID;// iString.ISDecimaltoZero(pFLOOR_ID);
            mWORK_TYPE_ID = pWORK_TYPE_ID;
            mJOB_CATEGORY_ID = pJOB_CATEGORY_ID;

            mPERSON_ID = pPERSON_ID;
           // mALL_FLAG = iString.ISNull(pALL_FLAG);
            
            V_DEPT_NAME.EditValue = pDEPT_NAME;
            V_FLOOR_NAME.EditValue = pFLOOR_NAME;
            V_NAME.EditValue = pNAME;
            V_WORK_TYPE.EditValue = pWORK_TYPE_NAME;
            V_JOB_CATEGORY.EditValue = pJOB_CATEGORY_NAME;
            V_WEEK_START_DATE.EditValue = mSTART_DATE;
            V_WEEK_END_DATE.EditValue = mEND_DATE;


        }

        #endregion;

        #region ----- Private Methods ----
          
        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void HRMF1391_CAL_Load(object sender, EventArgs e)
        {
             
        }

        private void HRMF1391_CAL_Shown(object sender, EventArgs e)
        {
            V_CORP_ID.EditValue = mCORP_ID;// iString.ISDecimaltoZero(mCORP_ID);
            V_DEPT_ID.EditValue = mDEPT_ID; // iString.ISDecimaltoZero(mDEPT_ID); 
            V_FLOOR_ID.EditValue = mFLOOR_ID; // iString.ISDecimaltoZero(mFLOOR_ID); 
            ALL_FLAG.EditValue = mALL_FLAG;
            V_PERSON_ID.EditValue = mPERSON_ID; // iString.ISDecimaltoZero(mPERSON_ID); 
            
           
        }
        
        private void btnSAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
       
        }

        // 창닫기
        private void btnCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            DialogResult = DialogResult.Cancel;
            this.Close();
        }

        private void igrPAY_PERIOD_CurrentCellValidated(object pSender, ISGridAdvExValidatedEventArgs e)
        {

        }

        #endregion

        #region ----- Adapter Event -----

        private void idaPAY_PERIOD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            
        }

        #endregion

        private void ILA_YYYYMM_W_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ILD_STD_YYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Month_Add(DateTime.Today, 3)));
        }

        private void itb_CAL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            System.Windows.Forms.Cursor.Current = Cursors.WaitCursor;
            Application.UseWaitCursor = true;
            Application.DoEvents();

            // 실행.
            string mStatus = "F";
            string mMessage = null;
            IDC_SET_MAIN_FLEX.ExecuteNonQuery();
            mStatus = iString.ISNull(IDC_SET_MAIN_FLEX.GetCommandParamValue("O_STATUS"));
            mMessage = iString.ISNull(IDC_SET_MAIN_FLEX.GetCommandParamValue("O_MESSAGE"));

            Application.UseWaitCursor = false;
            System.Windows.Forms.Cursor.Current = Cursors.WaitCursor;
            Application.DoEvents();
            if (IDC_SET_MAIN_FLEX.ExcuteError || mStatus == "F")
            { 
                if (mMessage != string.Empty)
                {
                    MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            } 
            if (mMessage != string.Empty)
            {
                MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            DialogResult = DialogResult.OK;
            this.Close(); 
        } 
    }
}