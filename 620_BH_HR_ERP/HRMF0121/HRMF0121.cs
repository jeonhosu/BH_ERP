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

namespace HRMF0121
{
    public partial class HRMF0121 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0121()
        {
            InitializeComponent();
        }

        public HRMF0121(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SEARCH_DB()
        {
            IGR_WORK_CENTER.LastConfirmChanges();
            IDA_WORK_CENTER.OraSelectData.AcceptChanges();
            IDA_WORK_CENTER.Refillable = true;

            ISG_WORK_TYPE_FLOOR.LastConfirmChanges();
            IDA_WORK_TYPE_FLOOR.OraSelectData.AcceptChanges();
            IDA_WORK_TYPE_FLOOR.Refillable = true;

            String vFLOOR_CODE = iConv.ISNull(IGR_WORK_CENTER.GetCellValue("FLOOR_CODE"));
            int vCOL_IDX = IGR_WORK_CENTER.GetColumnToIndex("FLOOR_CODE");

            IDA_WORK_CENTER.Fill();

            for(int r = 0; r < IGR_WORK_CENTER.RowCount;r++)
            {
                if(iConv.ISNull(IGR_WORK_CENTER.GetCellValue(r, vCOL_IDX)) == vFLOOR_CODE)
                {
                    IGR_WORK_CENTER.CurrentCellMoveTo(r, vCOL_IDX);
                    IGR_WORK_CENTER.CurrentCellActivate(r, vCOL_IDX);
                    IGR_WORK_CENTER.Focus();
                    return;
                }
            }
            IGR_WORK_CENTER.Focus();
        }

        private void SET_INSERT()
        {
            IGR_WORK_CENTER.SetCellValue("ENABLED_FLAG", "Y");
            IGR_WORK_CENTER.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (IDA_WORK_CENTER.IsFocused)
                    {
                        IDA_WORK_CENTER.AddOver();
                        SET_INSERT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_WORK_CENTER.IsFocused)
                    {
                        IDA_WORK_CENTER.AddUnder();
                        SET_INSERT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    try
                    {
                        IDA_WORK_CENTER.Update();
                    }
                    catch
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_WORK_CENTER.IsFocused)
                    {
                        IDA_WORK_CENTER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_WORK_CENTER.IsFocused)
                    {
                        IDA_WORK_CENTER.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0121_Load(object sender, EventArgs e)
        {
            IDA_WORK_CENTER.FillSchema();
        }

        private void W_WORK_CENTER_DESC_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                SEARCH_DB();
            }
        }

        #endregion

        #region ---- Lookup Event -----

        private void ilaCOST_CENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOST_CENTER.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_DEPT_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ILD_DEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_DEPT_2LV_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ILD_DEPT_2LV.SetLookupParamValue("W_DEPT_LEVEL", 2);
            ILD_DEPT_2LV.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void IDA_WORK_CENTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {

        }

        #endregion

    }
}