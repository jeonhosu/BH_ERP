using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace CSTF0605
{
    public partial class CSTF0605 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public CSTF0605(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
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

                    if (TAB_MAIN.SelectedTab.TabIndex == 1)
                    {
                        IDA_MODEL_SUM.Fill();
                        //MODEL_SUM();
                    }
                    else if (TAB_MAIN.SelectedTab.TabIndex == 2)
                    {
                        IDA_JOB_OPERATION.Fill();
                        //JOB_SUM();
                    }
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

        
        private void CSTF0605_Load(object sender, EventArgs e)
        {
            IDC_COST_PERIOD.ExecuteNonQuery();  // 최종 OPEN년월을 PERIOD DEFAULT VALUE로 설정 //
        }

        #region
        //// 모델별 수량/금액 SUM //
        //private void MODEL_SUM()
        //{
        //    decimal V_QTY = 0;
        //    decimal V_AMT = 0;

        //    foreach (DataRow row in IDA_JOB.SelectRows)
        //    {
        //        V_QTY = V_QTY + iConvert.ISDecimaltoZero(row["END_QTY"]);
        //        V_AMT = V_AMT + iConvert.ISDecimaltoZero(row["END_COST"]);
        //    }

        //    S_MODEL_QTY.EditValue = iConvert.ISDecimaltoZero(V_QTY);
        //    S_MODEL_COST.EditValue = iConvert.ISDecimaltoZero(V_AMT);
        //}
        //// JOB별 수량/금액 SUM //
        //private void JOB_SUM()
        //{
        //    decimal V_QTY = 0;
        //    decimal V_AMT = 0;

        //    foreach (DataRow row in IDA_JOB_OPERATION.SelectRows)
        //    {
        //        V_QTY = V_QTY + iConvert.ISDecimaltoZero(row["END_QTY"]);
        //        V_AMT = V_AMT + iConvert.ISDecimaltoZero(row["END_COST"]);
        //    }

        //    S_JOB_QTY.EditValue = iConvert.ISDecimaltoZero(V_QTY);
        //    S_JOB_COST.EditValue = iConvert.ISDecimaltoZero(V_AMT);
        //}

        #endregion

        private void isEditAdv91_Load(object sender, EventArgs e)
        {

        }

        private void isEditAdv107_Load(object sender, EventArgs e)
        {

        }

        private void isEditAdv191_Load(object sender, EventArgs e)
        {

        }

    }
}