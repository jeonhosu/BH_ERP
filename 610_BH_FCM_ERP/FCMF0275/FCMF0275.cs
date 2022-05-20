using System;
using System.Text;
using System.Windows.Forms;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;

using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0275
{
    public partial class FCMF0275 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0275(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Convert String Method -----

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
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;

        #region ----- Search DB Method ----

        private void SearchDB_Tab_0()
        {
            idaLIST_ACCOUNT.Fill();
        }

        private void SearchDB_Tab_1()
        {
            idaLIST_CURRENCY.Fill();
        }

        #endregion;

        #region ----- INSERT Method ----

        private void DefaultInsert_ACCOUNT_CONTENT()
        {
            igrACCOUNT_CONTENT.SetCellValue("ACCOUNT_CODE", "1110302"); //제예금(외화예금)

            object vObject_BANK_ACCOUNT_CODE = igrLIST_ACCOUNT.GetCellValue("BANK_ACCOUNT_CODE");
            igrACCOUNT_CONTENT.SetCellValue("ACCOUNT_CURRENCY_CD", vObject_BANK_ACCOUNT_CODE); //계좌코드
        }

        private void DefaultInsert_CURRENCY_CONTENT()
        {
            igrCURRENCY_CONTENT.SetCellValue("ACCOUNT_CODE", "1110200"); //외화

            object vObject_CURRENCY_CODE = igrLIST_CURRENCY.GetCellValue("CURRENCY_CODE");
            igrCURRENCY_CONTENT.SetCellValue("ACCOUNT_CURRENCY_CD", vObject_CURRENCY_CODE); //계좌코드
        }

        #endregion;

        #region ----- UPDATE Method ----

        private bool Update_iF_ACCOUNT_CONTENT(int vIndexColumn)
        {
            bool IsAble = true;
            object vObject_LAST_YN = igrACCOUNT_CONTENT.GetCellValue("LAST_YN");
            string vYN = ConvertString(vObject_LAST_YN);

            if (vYN == "0")
            {
                IsAble = false;

                //후발 자료가 있어 삭제 또는 수정 작업을 할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10443"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                igrACCOUNT_CONTENT.CurrentCellMoveTo(vIndexColumn);
                igrACCOUNT_CONTENT.Focus();

                idaACCOUNT_CONTENT.Cancel();

                igrACCOUNT_CONTENT.CurrentCellMoveTo(vIndexColumn);
                igrACCOUNT_CONTENT.Focus();
            }

            return IsAble;
        }

        private bool Update_iF_CURRENCY_CONTENT(int vIndexColumn)
        {
            bool IsAble = true;
            object vObject_LAST_YN = igrCURRENCY_CONTENT.GetCellValue("LAST_YN");
            string vYN = ConvertString(vObject_LAST_YN);

            if (vYN == "0")
            {
                IsAble = false;

                //후발 자료가 있어 삭제 또는 수정 작업을 할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10443"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                igrCURRENCY_CONTENT.CurrentCellMoveTo(vIndexColumn);
                igrCURRENCY_CONTENT.Focus();

                idaCURRENCY_CONTENT.Cancel();

                igrCURRENCY_CONTENT.CurrentCellMoveTo(vIndexColumn);
                igrCURRENCY_CONTENT.Focus();
            }

            return IsAble;
        }

        #endregion;

        #region ----- DELETE Method ----

        private bool Delete_iF_ACCOUNT_CONTENT()
        {
            bool IsAble = true;
            object vObject_LAST_YN = igrACCOUNT_CONTENT.GetCellValue("LAST_YN");
            string vYN = ConvertString(vObject_LAST_YN);

            if (vYN == "0")
            {
                IsAble = false;

                //후발 자료가 있어 삭제 또는 수정 작업을 할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10443"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

            return IsAble;
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTab = isTAB.SelectedIndex;

                    if (vIndexTab == 0)
                    {
                        SearchDB_Tab_0();
                    }
                    else if (vIndexTab == 1)
                    {
                        SearchDB_Tab_1();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaACCOUNT_CONTENT.IsFocused == true)
                    {
                        idaACCOUNT_CONTENT.AddOver();
                        DefaultInsert_ACCOUNT_CONTENT();
                    }
                    else if (idaCURRENCY_CONTENT.IsFocused == true)
                    {
                        idaCURRENCY_CONTENT.AddOver();
                        DefaultInsert_CURRENCY_CONTENT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaACCOUNT_CONTENT.IsFocused == true)
                    {
                        idaACCOUNT_CONTENT.AddUnder();
                        DefaultInsert_ACCOUNT_CONTENT();
                    }
                    else if (idaCURRENCY_CONTENT.IsFocused == true)
                    {
                        idaCURRENCY_CONTENT.AddUnder();
                        DefaultInsert_CURRENCY_CONTENT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaACCOUNT_CONTENT.IsFocused == true)
                    {
                        idaACCOUNT_CONTENT.Update();

                        idaACCOUNT_CONTENT.Fill();
                    }
                    else if (idaCURRENCY_CONTENT.IsFocused == true)
                    {
                        idaCURRENCY_CONTENT.Update();

                        idaCURRENCY_CONTENT.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaACCOUNT_CONTENT.IsFocused == true)
                    {
                        idaACCOUNT_CONTENT.Cancel();
                    }
                    else if (idaCURRENCY_CONTENT.IsFocused == true)
                    {
                        idaCURRENCY_CONTENT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaACCOUNT_CONTENT.IsFocused == true)
                    {
                        bool IsAble = Delete_iF_ACCOUNT_CONTENT();
                        if (IsAble == false)
                        {
                            return;
                        }

                        idaACCOUNT_CONTENT.Delete();
                    }
                    else if (idaCURRENCY_CONTENT.IsFocused == true)
                    {
                        bool IsAble = Delete_iF_ACCOUNT_CONTENT();
                        if (IsAble == false)
                        {
                            return;
                        }

                        idaCURRENCY_CONTENT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0275_Load(object sender, EventArgs e)
        {
            System.DateTime vDate = System.DateTime.Today.AddMonths(-2);
            PERIOD_FROM.EditValue = iDate.ISYearMonth(vDate);
            PERIOD_TO.EditValue = iDate.ISYearMonth(DateTime.Today);
        }
        
        private void FCMF0275_Shown(object sender, EventArgs e)
        {
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaLIST_ACCOUNT_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            try
            {
                idaACCOUNT_CONTENT.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void idaLIST_CURRENCY_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            try
            {
                idaCURRENCY_CONTENT.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion

        #region ----- Grid Event -----

        //입력시 바로 발생
        private void igrACCOUNT_CONTENT_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            int vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("OCCUR_DATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("BASE_RATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("CONTENTS");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("FOREIGN_DEPOSIT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("DEPOSIT_CHANGE_AMT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("FOREIGN_WITHDRAW");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("WITHDRAW_CHANGE_AMT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("EVALUATION_RATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrACCOUNT_CONTENT.GetColumnToIndex("REMARKS");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_ACCOUNT_CONTENT(vIndexColumn);
            }
        }

        private void igrCURRENCY_CONTENT_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            int vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("OCCUR_DATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("BASE_RATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("CONTENTS");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("FOREIGN_DEPOSIT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("DEPOSIT_CHANGE_AMT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("FOREIGN_WITHDRAW");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("WITHDRAW_CHANGE_AMT");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("EVALUATION_RATE");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }

            vIndexColumn = igrCURRENCY_CONTENT.GetColumnToIndex("REMARKS");
            if (e.ColIndex == vIndexColumn)
            {
                bool IsAble = Update_iF_CURRENCY_CONTENT(vIndexColumn);
            }
        }

        #endregion
    }
}