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

namespace GBLF0101
{
    public partial class GBLF0101 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public GBLF0101(Form pMainForm, ISAppInterface pAppInterface)
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
                    //if (TAB_FG.SelectedTab.TabIndex == 1)      //제품 마감수불부(종합)
                    //{
                        IDA_GBL_MASTER_TABLE.Fill();
                    //}
                    //else if (TAB_FG.SelectedTab.TabIndex == 2) //제품 마감수불부(종합)_세부
                    //{
                    //    IDA_DETAIL_SHEET.Fill();
                    //}
                    //else if (TAB_FG.SelectedTab.TabIndex == 3) //제품 마감수불부(JOB)_세부
                    //{
                    //    IDA_JOB_SHEET.Fill();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    IDA_GBL_MASTER_TABLE.AddOver();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    IDA_GBL_MASTER_TABLE.AddUnder();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    IDA_GBL_MASTER_TABLE.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    IDA_GBL_MASTER_TABLE.Cancel();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        
        private void GBLF0101_Load(object sender, EventArgs e)
        {
            //IDC_PERIOD_FR.ExecuteNonQuery();
            //IDC_PERIOD_TO.ExecuteNonQuery();

            //IDA_PERIOD_STATUS.Fill();
        }

        // PERIOD LOOKUP 선택시 동작 //
        private void ILA_PERIOD_SelectedRowData(object pSender)
        {
            //IDA_PERIOD_STATUS.Fill();
            //IDA_PERIOD_STATUS.Fill();
            //IDA_ENTIRE_SHEET.Fill();
        }



    }
}