using System;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace EAPF0208
{
    public partial class EAPF0208 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public EAPF0208()
        {
            InitializeComponent();
        }

        public EAPF0208(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchFromDataAdapter()
        {
            idaLINE.Fill();
        }

        private bool IsAbleToNewAdded(ISDataAdapter pDataAdapter)
        {
            bool IsAble = false;

            if (pDataAdapter.CurrentRow.RowState == System.Data.DataRowState.Added)
            {
                IsAble = true;
            }

            return IsAble;
        }

        #endregion;

        #region -- Default Value Setting --

        private void LINE_DefaultValue()
        {
            idcLOCAL_DATE.ExecuteNonQuery();
            isgAPPROVAL_LINE.SetCellValue("EFFECTIVE_DATE_FR", idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE"));
            isgAPPROVAL_LINE.SetCellValue("ENABLED_FLAG", "Y");
        }

        private void APPROVER_DefaultValue()
        {
            idcLOCAL_DATE.ExecuteNonQuery();
            isgAPPROVER.SetCellValue("EFFECTIVE_DATE_FR", idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE"));
            isgAPPROVER.SetCellValue("ENABLED_FLAG", "Y");
        }

        #endregion

        #region ----- Events -----

        private void EAPF0208_Load(object sender, EventArgs e)
        {
            idaLINE.FillSchema();
            idaSTEP.FillSchema();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick_1(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchFromDataAdapter();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaLINE.IsFocused == true)
                    {
                        idaLINE.AddOver();
                        LINE_DefaultValue();
                    }
                    else if (idaSTEP.IsFocused == true)
                    {
                        idaSTEP.AddOver();
                    }
                    else if (idaAPPROVER.IsFocused == true)
                    {
                        idaAPPROVER.AddOver();
                        APPROVER_DefaultValue();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaLINE.IsFocused == true)
                    {
                        idaLINE.AddUnder();
                        LINE_DefaultValue();
                    }
                    else if (idaSTEP.IsFocused == true)
                    {
                        idaSTEP.AddUnder();
                    }
                    else if (idaAPPROVER.IsFocused == true)
                    {
                        idaAPPROVER.AddUnder();
                        APPROVER_DefaultValue();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaLINE.IsFocused == true)
                    {
                        idaLINE.Update();
                    }
                    else if (idaSTEP.IsFocused == true)
                    {
                        idaLINE.Update();
                    }
                    else if (idaAPPROVER.IsFocused == true)
                    {
                        idaLINE.Update();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLINE.IsFocused == true)
                    {
                        idaLINE.Cancel();
                    }
                    else if (idaSTEP.IsFocused == true)
                    {
                        idaSTEP.Cancel();
                    }
                    else if (idaAPPROVER.IsFocused == true)
                    {
                        idaAPPROVER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLINE.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(idaLINE);
                        if (IsAble == false)
                        {
                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10013"); //삭제할 수 없습니다!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        idaLINE.Delete();
                    }
                    else if (idaSTEP.IsFocused == true)
                    {
                        idaSTEP.Delete();
                    }
                    else if (idaAPPROVER.IsFocused == true)
                    {
                        bool IsAble = IsAbleToNewAdded(idaAPPROVER);
                        if (IsAble == false)
                        {
                            string vMessageGet = isMessageAdapter1.ReturnText("EAPP_10013"); //삭제할 수 없습니다!
                            string vMessageString = string.Format("{0}", vMessageGet);
                            MessageBoxAdv.Show(vMessageString, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        idaAPPROVER.Delete();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Print)
                {
                }
            }
        }
        #endregion;


    }
}