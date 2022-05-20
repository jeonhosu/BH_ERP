using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Threading;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace PPMF1005
{
    public partial class PPMF1005 : Office2007Form
    {
        #region ----- Variables -----

        ISCommonUtil.ISFunction.ISConvert iConvert = new ISCommonUtil.ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public PPMF1005()
        {
            InitializeComponent();
        }

        public PPMF1005(Form pMainForm, ISAppInterface pAppInterface)
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
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        ida_WIP_VCO_ENTRY_SELECT.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        ida_WIP_VCO_ENTRY_SELECT.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        ida_WIP_VCO_ENTRY_SELECT.Update();
                        ida_WIP_VCO_JOB_ENTRY_SELECT.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        ida_WIP_VCO_ENTRY_SELECT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (ida_WIP_VCO_ENTRY_SELECT.IsFocused)
                    {
                        ida_WIP_VCO_ENTRY_SELECT.Delete();
                    }
                }
            }
        }

        #endregion;

        private void PPMF1005_Load(object sender, EventArgs e)
        {
            ida_WIP_VCO_ENTRY_SELECT.FillSchema();
        }

        private void ida_WIP_VCO_ENTRY_SELECT_ExcuteKeySearch(object pSender)
        {
            ida_WIP_VCO_ENTRY_SELECT.Fill();
        }

        private void icb_ALL_SELECTION_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (e.CheckedState == ISUtil.Enum.CheckedState.Checked)
            {
                for (int i = 0; i < igr_WIP_MCO_JOB_ENTRY_SELECT.RowCount; i++)
                {
                    igr_WIP_MCO_JOB_ENTRY_SELECT.SetCellValue(i, 0, "Y".ToString());
                }
            }
            else if (e.CheckedState == ISUtil.Enum.CheckedState.Unchecked)
            {
                for (int i = 0; i < igr_WIP_MCO_JOB_ENTRY_SELECT.RowCount; i++)
                {
                    igr_WIP_MCO_JOB_ENTRY_SELECT.SetCellValue(i, 0, "N".ToString());
                }
            }
        }

        private void ibt_VCO_JOB_APPLY_ButtonClick(object pSender, EventArgs pEventArgs)
        {           
            // 변경적용//
            DialogResult vDialogResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("WIP_10272"), "Version Change Order", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

            if (vDialogResult == DialogResult.OK)
            {
                // 1. 버전변경 대상JOB 이전 저장 데이터 삭제
                idc_WIP_VCO_JOB_ENTRY_DELETE.ExecuteNonQuery();
                string vRESULT_STATUS = iConvert.ISNull(idc_WIP_VCO_JOB_ENTRY_DELETE.GetCommandParamValue("X_RESULT_STATUS"));
                string vRESULT_MSG = iConvert.ISNull(idc_WIP_VCO_JOB_ENTRY_DELETE.GetCommandParamValue("X_RESULT_MSG"));
                string vRESULT_MSG_CODE = "";

                if (vRESULT_STATUS == "F")
                {
                    MessageBoxAdv.Show(vRESULT_MSG, "Version Change Order", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    ida_WIP_VCO_JOB_ENTRY_SELECT.OraDataTable().AcceptChanges();
                    ida_WIP_VCO_JOB_ENTRY_SELECT.Refillable = true;
                }
                else if (vRESULT_STATUS == "S")
                {
                    // 2. 버전변경 대상JOB 사용자 선택라인 저장
                    ida_WIP_VCO_JOB_ENTRY_SELECT.Update();

                    // 3. 버전변경 대상JOB 불러오기
                    ida_WIP_VCO_JOB_APPLY_SELECT.Fill();

                    // 4. 버전변경 대상JOB 적용처리
                    igb_PROGRESS.Visible = true;
                    Thread.Sleep(300);
                    Application.DoEvents();

                    foreach (DataRow row in ida_WIP_VCO_JOB_APPLY_SELECT.OraDataTable().Rows)
                    {
                        // 첫행 작업 시 변경 수주 정보 생성 처리
                        if (iConvert.ISNull(row["ROW_NUM"]) == "1")
                        {
                            idc_WIP_VCO_JOB_PRE_EXECUTE.SetCommandParamValue("P_VCO_JOB_ENTRY_ID", row["VCO_JOB_ENTRY_ID"]);
                            idc_WIP_VCO_JOB_PRE_EXECUTE.ExecuteNonQuery();

                            vRESULT_STATUS = iConvert.ISNull(idc_WIP_VCO_JOB_PRE_EXECUTE.GetCommandParamValue("X_RESULT_STATUS"));
                            vRESULT_MSG = iConvert.ISNull(idc_WIP_VCO_JOB_PRE_EXECUTE.GetCommandParamValue("X_RESULT_MSG"));
                            vRESULT_MSG_CODE = iConvert.ISNull(idc_WIP_VCO_JOB_PRE_EXECUTE.GetCommandParamValue("X_RESULT_MSG_CODE"));

                            if (vRESULT_STATUS == "F")
                            {
                                igb_PROGRESS.Visible = false;
                                ida_WIP_VCO_ENTRY_SELECT.OraDataTable().AcceptChanges();
                                ida_WIP_VCO_ENTRY_SELECT.Refillable = true;
                                // 대상JOB 처리후 적용여부에 따른 JOB내용 Refresh
                                ida_WIP_VCO_JOB_ENTRY_SELECT.Fill();
                                MessageBoxAdv.Show(vRESULT_MSG, "Version Change Order Error!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                                return;
                            }

                        }
                        ipt_TARGET_JOB.PromptText = "JOB NO => " + iConvert.ISNull(row["JOB_NO"]) + " ...";
                        ipt_PROGRESS_STEP.PromptText = iConvert.ISNull(row["ROW_NUM"]) + "/" + iConvert.ISNull(row["JOB_TARGET_COUNT"]);
                        Application.DoEvents();

                        // 해당 대상JOB 별로 버전변경 처리
                        idt_WIP_VCO_JOB_APPLY_EXECUTE.BeginTran();
                        idc_WIP_VCO_JOB_APPLY_EXECUTE.SetCommandParamValue("P_VCO_JOB_ENTRY_ID", row["VCO_JOB_ENTRY_ID"]);
                        idc_WIP_VCO_JOB_APPLY_EXECUTE.ExecuteNonQuery();

                        vRESULT_STATUS = iConvert.ISNull(idc_WIP_VCO_JOB_APPLY_EXECUTE.GetCommandParamValue("X_RESULT_STATUS"));
                        vRESULT_MSG = iConvert.ISNull(idc_WIP_VCO_JOB_APPLY_EXECUTE.GetCommandParamValue("X_RESULT_MSG"));
                        vRESULT_MSG_CODE = iConvert.ISNull(idc_WIP_VCO_JOB_APPLY_EXECUTE.GetCommandParamValue("X_RESULT_MSG_CODE"));

                        if (vRESULT_STATUS == "S")
                        {
                            // 해당 대상JOB 버전변경 정상처리
                            idt_WIP_VCO_JOB_APPLY_EXECUTE.Commit();
                            idc_WIP_VCO_JOB_POST_EXECUTE.SetCommandParamValue("P_JOB_APPLY_FLAG", "Y".ToString());
                            idc_WIP_VCO_JOB_POST_EXECUTE.SetCommandParamValue("P_VCO_FAIL_MSG", DBNull.Value);
                        }
                        else
                        {
                            // 해당 대상JOB 버전변경 오류발생 
                            idt_WIP_VCO_JOB_APPLY_EXECUTE.RollBack();
                            idc_WIP_VCO_JOB_POST_EXECUTE.SetCommandParamValue("P_JOB_APPLY_FLAG", "N".ToString());
                            idc_WIP_VCO_JOB_POST_EXECUTE.SetCommandParamValue("P_VCO_FAIL_MSG", vRESULT_MSG_CODE + " : " + vRESULT_MSG);
                        }

                        // 해당 대상JOB 적용여부 & 오류내용 저장
                        idc_WIP_VCO_JOB_POST_EXECUTE.SetCommandParamValue("P_VCO_JOB_ENTRY_ID", row["VCO_JOB_ENTRY_ID"]);
                        idc_WIP_VCO_JOB_POST_EXECUTE.ExecuteNonQuery();

                        ipb_PROGRESS_BAR.BarFillPercent = ((float)Convert.ToDouble(row["ROW_NUM"]) / (float)Convert.ToDouble(row["JOB_TARGET_COUNT"])) * 100;
                    }

                    Thread.Sleep(1000);
                    igb_PROGRESS.Visible = false;
                }

                // 대상JOB 모두처리 후 해당 VCO 적용여부 저장
                idc_WIP_VCO_APPLY_EXECUTE.ExecuteNonQuery();
                if (ida_WIP_VCO_ENTRY_SELECT.OraDataTable() != null)
                {
                    ida_WIP_VCO_ENTRY_SELECT.OraDataTable().AcceptChanges();
                    ida_WIP_VCO_ENTRY_SELECT.Refillable = true;
                }

                // 대상JOB 처리후 적용여부에 따른 JOB내용 Refresh
                ida_WIP_VCO_JOB_ENTRY_SELECT.Fill();
            }
        }

        private void ila_WIP_VCO_AFTER_ITEM_SelectedRowData(object pSender)
        {
            ied_AFTER_ORDER_LINE_ID.EditValue = null;
            ied_AFTER_ORDER_HEADER_ID.EditValue = null;
            ied_SALES_ORDER_NO.EditValue = "";
            ied_CUST_SITE_NAME.EditValue = "";
        }        
    }
}