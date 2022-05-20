using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace HRMF0354
{
    public partial class HRMF0354 : Office2007Form
    {
        #region ----- Variables -----

        ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0354()
        {
            InitializeComponent();
        }

        public HRMF0354(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- MDi ToolBar Button Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    DB_Search();
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
                    if (idaDAY_INTERFACE_BEFORE.IsFocused)
                    {
                        idaDAY_INTERFACE_BEFORE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0354_Shown(object sender, EventArgs e)
        {
            System.DateTime vDate = mGetDate.ISGetDate();

            WORK_DATE_FR_0.EditValue = mGetDate.ISMonth_1st(vDate);
            WORK_DATE_TO_0.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        #endregion

        #region ----- User Method -----

        private void DB_Search()
        {
            int vIndexTAB = isTAB.SelectedIndex;

            if (vIndexTAB == 0)
            {
                idaDAY_INTERFACE_AFTER.Fill();
            }
            else if (vIndexTAB == 1)
            {
                idaDAY_INTERFACE_BEFORE.Fill();
            }
        }

        #endregion;

        #region ----- Edit Event -----

        private void WORK_DATE_FR_0_EditValueChanged(object pSender)
        {
            System.DateTime vDate = WORK_DATE_FR_0.DateTimeValue;
            WORK_DATE_TO_0.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        #endregion

    }
}