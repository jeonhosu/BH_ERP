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

namespace FCMF0361
{
    public partial class FCMF0361 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0361(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private decimal ConvertNumber(object pObject)
        {
            bool vIsConvert = false;
            decimal vConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        vConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
        }

        #endregion;

        #region ----- User Method ----

        private void SearchDB()
        {
            idaFI_ASSET_CATEGORY.Fill();
        }

        private void UpdateDB()
        {
            idaFI_ASSET_CATEGORY.Update();
            SearchDB();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        SearchDB();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        idaFI_ASSET_CATEGORY.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        idaFI_ASSET_CATEGORY.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        UpdateDB();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        idaFI_ASSET_CATEGORY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaFI_ASSET_CATEGORY.IsFocused)
                    {
                        object vObject_Count = igrFI_ASSET_CATEGORY.GetCellValue("ASSET_CNT");
                        decimal vCount = ConvertNumber(vObject_Count);

                        if (vCount > 0)
                        {
                            //기준자료로 삭제할 수 없습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10307"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        System.Windows.Forms.DialogResult vChoiceValue;

                        string vMessageString1 = isMessageAdapter1.ReturnText("EAPP_10030"); //삭제 하시겠습니까?
                        vChoiceValue = MessageBoxAdv.Show(vMessageString1, "Delete", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                        if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
                        {
                            idaFI_ASSET_CATEGORY.Delete();

                            UpdateDB();
                        }
                    }
                }
            }
        }

        #endregion;

        #region ----- Lookup Event ----

        private void ilaASSET_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ASSET_TYPE", "Y");
        }

        private void ilaDPR_METHOD_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("DPR_METHOD_TYPE", "Y");
        }

        #endregion;

        #region ----- Form Event ----

        private void FCMF0361_Load(object sender, EventArgs e)
        {
            idaFI_ASSET_CATEGORY.FillSchema();
        }

        #endregion;
    }
}