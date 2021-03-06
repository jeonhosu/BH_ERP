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

namespace FCMF0880
{
    public partial class FCMF0880_4 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public object Get_Save_Flag
        {
            get
            {
                return V_SAVE_FLAG.EditValue;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public FCMF0880_4(Form pMainForm, ISAppInterface pAppInterface
                        , object pTAX_DESC, object pTAX_CODE
                        , object pVAT_REPORT_NM
                        , object pVAT_DATE_FR, object pVAT_DATE_TO
                        , object pNO_DED_TYPE
                        , object pNO_DED_DESC, object pNO_DED_CODE)
        {
            InitializeComponent();
            //this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            V_TAX_CODE.EditValue = pTAX_CODE;
            V_TAX_DESC.EditValue = pTAX_DESC;

            V_VAT_REPORT_NM.EditValue = pVAT_REPORT_NM;

            V_VAT_DATE_FR.EditValue = pVAT_DATE_FR;
            V_VAT_DATE_TO.EditValue = pVAT_DATE_TO;

            V_NO_DED_TYPE.EditValue = pNO_DED_TYPE;
            V_NO_DED_DESC.EditValue = pNO_DED_DESC;
            V_NO_DED_CODE.EditValue = pNO_DED_CODE;

            V_ADJUST_TYPE.EditValue = "4";
        }

        #endregion;

        #region ----- Private Methods ----

        private void SEARCH_DB()
        {
            object vObject1 = V_TAX_DESC.EditValue;
            object vObject3 = V_VAT_REPORT_NM.EditValue;
            if (iConv.ISNull(vObject1) == string.Empty || iConv.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            IDA_ADJUST_4.Fill();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            //ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            //ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_GRID_STATUS_ROW()
        {
            if (IGR_ADJUST_4.RowCount < 1)
            {
                return;
            }
            int vSTATUS = 0;                // INSERTABLE, UPDATABLE;

            int vROW = IGR_ADJUST_4.RowIndex;
            object vNO_DED_CODE = IGR_ADJUST_4.GetCellValue("NO_DED_CODE");
            int vIDX_GL_AMOUNT = IGR_ADJUST_4.GetColumnToIndex("GL_AMOUNT");
            int vIDX_VAT_AMOUNT = IGR_ADJUST_4.GetColumnToIndex("VAT_AMOUNT");

            if (iConv.ISNull(vNO_DED_CODE) == "990")
            {
                vSTATUS = 0;
            }
            else
            {
                vSTATUS = 1;
            }

            IGR_ADJUST_4.GridAdvExColElement[vIDX_GL_AMOUNT].Insertable = vSTATUS;
            IGR_ADJUST_4.GridAdvExColElement[vIDX_GL_AMOUNT].Updatable = vSTATUS;

            IGR_ADJUST_4.GridAdvExColElement[vIDX_VAT_AMOUNT].Insertable = vSTATUS;
            IGR_ADJUST_4.GridAdvExColElement[vIDX_VAT_AMOUNT].Updatable = vSTATUS;
        }

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

        private void FCMF0880_4_Load(object sender, EventArgs e)
        {
            IDA_ADJUST_4.FillSchema();
        }
        
        private void FCMF0880_4_Shown(object sender, EventArgs e)
        {
            SEARCH_DB();
            V_SAVE_FLAG.EditValue = "NONE";
        }

        private void IGR_ADJUST_4_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {            
            int vIDX_VAT_AMT = IGR_ADJUST_4.GetColumnToIndex("VAT_AMT");
            int vIDX_CAL_TYPE = IGR_ADJUST_4.GetColumnToIndex("CAL_TYPE");
            int vIDX_TAX_SUPPLY_AMT = IGR_ADJUST_4.GetColumnToIndex("TAX_SUPPLY_AMT");
            int vIDX_NON_TAX_SUPPLY_AMT = IGR_ADJUST_4.GetColumnToIndex("NON_TAX_SUPPLY_AMT");
            int vIDX_PRE_VAT_AMT = IGR_ADJUST_4.GetColumnToIndex("PRE_VAT_AMT");

            if (e.ColIndex == vIDX_VAT_AMT || e.ColIndex == vIDX_CAL_TYPE
                || e.ColIndex == vIDX_TAX_SUPPLY_AMT || e.ColIndex == vIDX_NON_TAX_SUPPLY_AMT
                || e.ColIndex == vIDX_PRE_VAT_AMT)
            {
                decimal vVAT_AMT = iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("VAT_AMT"), 0);
                decimal vTAX_SUPPLY_AMT = iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("TAX_SUPPLY_AMT"), 0);
                decimal vNON_TAX_SUPPLY_AMT = iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("NON_TAX_SUPPLY_AMT"), 0);
                decimal vPRE_VAT_AMT = iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("PRE_VAT_AMT"), 0);
                                                
                //(14)총공통매입세액//
                if (e.ColIndex == vIDX_VAT_AMT)
                {
                    vVAT_AMT = iConv.ISDecimaltoZero(e.NewValue, 0);                    
                }
                //(A)총공급가액등//
                if (e.ColIndex == vIDX_TAX_SUPPLY_AMT)
                {
                    vTAX_SUPPLY_AMT = iConv.ISDecimaltoZero(e.NewValue, 0);
                }
                //(B)면세공급가액등//
                if (e.ColIndex == vIDX_NON_TAX_SUPPLY_AMT)
                {
                    vNON_TAX_SUPPLY_AMT = iConv.ISDecimaltoZero(e.NewValue, 0);
                }
                //(17)기불공제매입세액//
                if (e.ColIndex == vIDX_PRE_VAT_AMT)
                {
                    vPRE_VAT_AMT = iConv.ISDecimaltoZero(e.NewValue, 0);
                }

                //(15)면세사업확정비율(%)//
                decimal vNON_TAX_RATE = 0;
                if (vTAX_SUPPLY_AMT != 0)
                {
                    vNON_TAX_RATE = Math.Floor(10000 * ((vNON_TAX_SUPPLY_AMT / vTAX_SUPPLY_AMT) * 100)) / 10000;
                }
                //(16)불공제매입세액총액//
                decimal vNO_VAT_AMT = Math.Floor((vVAT_AMT * (vNON_TAX_RATE / 100)));
                //(18)가산또는공제 매입세액//
                decimal vADDITION_VAT_AMT = vNO_VAT_AMT - vPRE_VAT_AMT;

                //(안분후공급가//
                decimal vDIVISION = 0.1M;
                decimal vADJUST_SUPPLY_AMT = Math.Floor((vADDITION_VAT_AMT / vDIVISION));

                IGR_ADJUST_4.SetCellValue("NON_TAX_RATE", vNON_TAX_RATE);
                IGR_ADJUST_4.SetCellValue("NO_VAT_AMT", vNO_VAT_AMT);
                IGR_ADJUST_4.SetCellValue("ADDITION_VAT_AMT", vADDITION_VAT_AMT);
                IGR_ADJUST_4.SetCellValue("ADJUST_SUPPLY_AMT", vADJUST_SUPPLY_AMT);
            }            
        }

        private void BTN_ADD_UNDER_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_ADJUST_4.AddUnder();

            IGR_ADJUST_4.Focus();
        }

        private void BTN_UPDATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_ADJUST_4.Update();
        }

        private void BTN_DELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_ADJUST_4.Delete();
        }
        
        private void BTN_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_ADJUST_4.Cancel();
        }

        private void BTN_CLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaPOP_VAT_REPORT_MNG_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            
        }

        #endregion

        #region ----- Grid Event -----
        
        private void igrSUM_NO_DEDUCTION_CurrentCellValidated(object pSender, ISGridAdvExValidatedEventArgs e)
        {
            if (IGR_ADJUST_4.RowCount < 1)
            {
                return;
            }

            decimal vAMOUNT = 0;
            int vIDX_GL_AMOUNT = IGR_ADJUST_4.GetColumnToIndex("GL_AMOUNT");
            int vIDX_VAT_AMOUNT = IGR_ADJUST_4.GetColumnToIndex("VAT_AMOUNT");

            Decimal vGL_RATE = iConv.ISDecimaltoZero(10);
            Decimal vVAT_RATE = iConv.ISDecimaltoZero(0.1);

            if (e.ColIndex == vIDX_GL_AMOUNT)
            {
                if (iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("VAT_AMOUNT"), 0) == 0)
                {
                    vAMOUNT = vVAT_RATE * iConv.ISDecimaltoZero(e.CellValue, 0);
                    IGR_ADJUST_4.SetCellValue("VAT_AMOUNT", vAMOUNT);
                }
            }
            else if (e.ColIndex == vIDX_VAT_AMOUNT)
            {
                if (iConv.ISDecimaltoZero(IGR_ADJUST_4.GetCellValue("GL_AMOUNT"), 0) == 0)
                {
                    vAMOUNT = vGL_RATE * iConv.ISDecimaltoZero(e.CellValue, 0);
                    IGR_ADJUST_4.SetCellValue("GL_AMOUNT", vAMOUNT);
                }
            }
        }

        private void igrZERO_TAX_SPEC_CurrentCellAcceptedChanges(object pSender, ISGridAdvExChangedEventArgs e)
        {
            InfoSummit.Win.ControlAdv.ISGridAdvEx vGrid = pSender as InfoSummit.Win.ControlAdv.ISGridAdvEx;

            int vIndexColunm = vGrid.GetColumnToIndex("PUBLISH_DATE");

            if (e.ColIndex == vIndexColunm)
            {
                object vObject = vGrid.GetCellValue("PUBLISH_DATE");
                vGrid.SetCellValue("SHIPPING_DATE", vObject);
            }
        }

        #endregion

        #region ----- Adapter Event -----

        private void IDA_ADJUST_4_UpdateCompleted(object pSender)
        {
            V_SAVE_FLAG.EditValue = "SAVE";

            this.Close();
        }

        #endregion

    }
}