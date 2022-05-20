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

namespace EAPF0203
{
    public partial class EAPF0203 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public EAPF0203()
        {
            InitializeComponent();
        }

        public EAPF0203(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();

            this.MdiParent = pMainForm;

            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchFromDataAdapter()
        {
            isDataAdapter1.Fill();
        }

        #endregion;

        #region -- Default Value Setting --
        private void GRID_DefaultValue()
        {
            idcLOCAL_DATE.ExecuteNonQuery();
            isGridAdvEx1.SetCellValue("EFFECTIVE_DATE_FR", idcLOCAL_DATE.GetCommandParamValue("X_LOCAL_DATE"));
            isGridAdvEx1.SetCellValue("ENABLED_FLAG", "Y");
        }

        #endregion

        #region ----- Events -----

        private void EAPF0203_Load(object sender, EventArgs e)
        {
            isDataAdapter1.FillSchema();
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchFromDataAdapter();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    isDataAdapter1.AddOver();
                    GRID_DefaultValue();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    isDataAdapter1.AddUnder();
                    GRID_DefaultValue();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Update)
                {

                    object vUserId = isAppInterfaceAdv1.AppInterface.UserId;

                    if (isDataAdapter1.IsFocused == true)
                    {
                        isDataAdapter1.Update();
                    }
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    isDataAdapter1.Cancel();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Delete)
                {
                    isDataAdapter1.Delete();
                }
                else if (e.AppMainButtonType == InfoSummit.Win.ControlAdv.ISUtil.Enum.AppMainButtonType.Print)
                {
                    //GridView(isGridAdvEx2, isDataAdapter2);
                }
            }
        }

        private void GridView(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter)
        {
            if (pAdapter != null)
            {
                pGrid.RowCount = pAdapter.OraSelectData.Rows.Count;
                pGrid.ColCount = pAdapter.OraSelectData.Columns.Count;

                foreach (System.Data.DataRow vRow in pAdapter.OraSelectData.Rows)
                {
                    foreach (System.Data.DataColumn vCol in pAdapter.OraSelectData.Columns)
                    {
                        int vRowIndex = vRow.Table.Rows.IndexOf(vRow);
                        int vColIndex = vRow.Table.Columns.IndexOf(vCol);

                        pGrid.SetCellValue(vRowIndex, vColIndex, vRow[vCol]);
                    }
                }
            }
        }

        #endregion;

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=해당 자료"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            } 
        }

    }
}