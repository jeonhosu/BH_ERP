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

namespace PPMF0701
{
    public partial class PPMF0701 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public PPMF0701(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void idaHEADER_ExcuteQuery()
        {
            idaHEADER.Fill();
        }

        private void Header_Setting()
        {
            iedISSUE_TYPE.EditValue = "MANUAL";
            iedISSUE_DATE.EditValue = DateTime.Today;
            iedISSUE_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            iedDISPLAY_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;
            iedWORKCENTER_CODE.Focus();
        }

        private void Line_Setting()
        {
            
        }

        #endregion;

        #region ----- Events -----

        private void PPMF0701_Load(object sender, EventArgs e)
        {
            idaHEADER.FillSchema();
            idaLINE.FillSchema();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    idaHEADER.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.AddOver();
                        Header_Setting();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaLINE.AddOver();
                        Line_Setting();
                    }

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.AddUnder();
                        Header_Setting();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaLINE.AddUnder();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaHEADER.Update();
                    if (idaHEADER.CurrentRow.RowState == DataRowState.Unchanged)
                    {
                        idaHEADER.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.Cancel();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaLINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaHEADER.IsFocused == true)
                    {
                        idaHEADER.Delete();
                    }
                    else if (idaLINE.IsFocused == true)
                    {
                        idaLINE.Delete();
                    }
                }
            }
        }

        private void idaHEADER_ExcuteKeySearch(object pSender)
        {            
            idaHEADER_ExcuteQuery();
        }

        #endregion;                                
    }
}