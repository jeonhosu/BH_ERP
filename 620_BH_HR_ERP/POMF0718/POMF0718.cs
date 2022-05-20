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

namespace POMF0718
{
    public partial class POMF0718 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #region ----- Variables -----

        #endregion;

        #region ----- Constructor -----

        public POMF0718(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;  

        }

        #endregion;

        #region ----- Private Methods ----
        private void Header_Setting()
        {
            iedOPEN_DATE.EditValue = DateTime.Today;
            iedEXPIRED_DATE.EditValue = DateTime.Today;
            iedSHPPING_DATE.EditValue = DateTime.Today;
            iedCUSTOM_DATE.EditValue = DateTime.Today;

            iedTOTAL_QTY.EditValue = null ;
            iedTOTAL_AMOUNT.EditValue = null;
            iedTOTAL_AMOUNT2.EditValue = null;
            
        }
        
        private void Line_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow, object vPo_Qty)
        {
            int    vIndexLastRow = Convert.ToInt32(vRow);
            decimal vSum_Po_Qty = Convert.ToDecimal(vPo_Qty);
            int    vRow_Cnt      = pGrid1.RowCount; 

            object vObject       = "";

            pGrid1.CurrentCellMoveTo(pGrid1.RowCount - 1, 0);

            IDA_LINE.AddUnder();

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("LINE_NO"), 1);

            vObject = pGrid3.GetCellValue(vIndexLastRow,pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")); 
            pGrid1.SetCellValue(vRow_Cnt,pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_CODE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_DESCRIPTION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_SPECIFICATION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_SPECIFICATION"),vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_UOM_CODE"), vObject);

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("OPEN_QTY"), vSum_Po_Qty);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CURRENCY_CODE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CURRENCY_CODE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_PRICE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_PRICE"), vObject);

            // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사 => 2014.02.04 한화금액 소숫점 반올림으로 변경 
            vObject = System.Math.Round(Convert.ToDecimal(pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty, 2);
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vObject);                                   // 금액

            //if (iedCREDIT_FLAG.CheckedString == "Y")
            //{
            //    decimal vOPEN_QTY = Convert.ToDecimal(pGrid1.GetCellValue(vIndexLastRow, pGrid1.GetColumnToIndex("OPEN_QTY")));
            //    decimal vCREDIT_RATE = Convert.ToDecimal(iedCREDIT_RATE.EditValue) / 100;

            //    pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CREDIT_ITEM_QTY"), vOPEN_QTY + (vOPEN_QTY * vCREDIT_RATE));             // 과부족포함수량

            //    decimal vITEM_AMOUNT = Convert.ToDecimal(pGrid1.GetCellValue(vIndexLastRow, pGrid1.GetColumnToIndex("ITEM_AMOUNT")));
            //    pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vITEM_AMOUNT + (vITEM_AMOUNT * vCREDIT_RATE));    // 과부족포함금액
            //}
            //else
            //{
            //    pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CREDIT_ITEM_QTY"), vSum_Po_Qty);                                        // 과부족수량

            //    vObject = Convert.ToDecimal(pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;
            //    pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vObject);                                          // 과부족금액
            //}

            

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CATEGORY_DESCRIPTION"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CATEGORY_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("SECTION_DESCRIPTION"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("SECTION_DESCRIPTION"), vObject);
        }
        private void Detail_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow_Line, object vRow, object vRow_Detail)
        {
            int vRow_Cnt = Convert.ToInt32(vRow_Line);
            int vRow_Cnt2 = Convert.ToInt32(vRow_Detail);
            int i = Convert.ToInt32(vRow);

            object vObject = "";

            pGrid1.CurrentCellMoveTo(vRow_Cnt, 0);

            pGrid2.CurrentCellMoveTo(pGrid2.RowCount - 1, 0);

            IDA_DETAIL.AddUnder();

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_HEADER_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_HEADER_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_LINE_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_LINE_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_UOM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("LINE_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_LINE_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_REMAIN_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("OPEN_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_DESCRIPTION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("SUPPLIER_SHORT_NAME"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("SUPPLIER_SHORT_NAME"), vObject);
        }
        //======================================================================================================
        // 라인에서 디테일에 없거나 디테일의 발주량이 0 이면 삭제 하는 루틴
        //======================================================================================================
        private void Group_Del(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            bool vCheck  = false;

            decimal vPO_Qty = 0;
            decimal vPO_Qty_Sum = 0;
            
            int  i = 0;
            int  j = 0;

            int vIndexCurrent = IDA_LINE.OraSelectData.Rows.IndexOf(IDA_LINE.CurrentRow);
            int vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue("INVENTORY_ITEM_ID"));
            string vLine_UOM1 = Convert.ToString(pGrid1.GetCellValue("ITEM_UOM_CODE"));

            //for ( i = 0; i < pGrid1.RowCount; i++)        // 라인그리드 기준
            //{
                //pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);

                //int vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue(vIndexCurrent, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                //string vLine_UOM1 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                for ( j = 0; j < pGrid2.RowCount; j++)    // 디테일 그리드 조회
                {
                    int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    string vLine_UOM2 = Convert.ToString(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                    int vIndexCurrent2 = IDA_DETAIL.OraSelectData.Rows.IndexOf(IDA_DETAIL.CurrentRow);

                    if ((vLine_Id1 == vLine_Id2) && (vLine_UOM1 == vLine_UOM2) && (IDA_DETAIL.OraSelectData.Rows[vIndexCurrent2].RowState != DataRowState.Deleted))
                    {
                        vCheck = true;

                        vPO_Qty = Convert.ToDecimal(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("REMIND_QTY")));

                        vPO_Qty_Sum = vPO_Qty_Sum + vPO_Qty;
                    }
                }

                if ((vCheck = false) || (vPO_Qty_Sum == 0))
                {
                    pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);
                    IDA_LINE.Delete();
                }

                vPO_Qty_Sum = 0;
                vCheck      = false;

            //}
        }
        //======================================================================================================
        // Request lIne 내용을 종합해서 라인에 뿌려주는 루틴 - INSERT
        //======================================================================================================
        private void Group_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3)
        {
            Object vPo_Qty      = 0;

            decimal vSum_Po_Qty = 0;
            int    vLastRow     = 0;

            bool   vCheck       = false;
            bool   vCheck_First = false;

            //System.Data.DataRow[] vRows = isREQUEST_DA.OraSelectData.Select(null, "INVENTORY_ITEM_ID, ITEM_UOM_CODE");     //  sort

            int vObject1 = 0;
            int vObject2 = 0;

            int vLine_id = 0;
            int vLine_id2 = 0;

            string vUOM1 = "";
            string vUOM2 = "";

            int vRow = 0;

            for (vRow = 0; vRow < pGrid3.RowCount; vRow++)
            {
                if (pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vObject1 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vObject2 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));

                    //vLine_id = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("PO_LINE_ID")));

                    vUOM1 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));
                    vUOM2 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    break;
                }
            }

            int vIndexLastRow = vRow;

            //pGrid2.BeginUpdate();
            //pGrid3.BeginUpdate();

            for (vRow = vRow; vRow < pGrid3.RowCount; vRow++)
            {
                if (pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    //=================================================================================================
                    // 처음부분을 체크 해서 가격조건, 결재조건, 운송방법, 선적항, 도착항을 넣어준다.
                    //=================================================================================================
                    //if (vCheck_First == false)
                    //{
                    //    iedPRICE_TERM_ID.EditValue         = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("PRICE_TERM_ID"));
                    //    iedPRICE_TERM_NAME.EditValue       = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("PRICE_TERM_NAME"));

                    //    iedPAYMENT_TERM_ID.EditValue       = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("PAYMENT_TERM_ID"));
                    //    iedPAYMENT_TERM_NAME.EditValue     = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("PAYMENT_TERM_NAME"));

                    //    iedSHIPPING_METHOD_ID.EditValue    = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("SHIPPING_METHOD_LCODE"));
                    //    iedSHIPPING_METHOD_NAME.EditValue  = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("SHIPPING_METHOD_NAME"));

                    //    iedLOADING_PORT_ID.EditValue       = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("LOADING_PORT_ID"));
                    //    iedLOADING_PORT_NAME.EditValue     = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("LOADING_PORT_NAME"));

                    //    iedDESTINATION_PORT_ID.EditValue   = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("DESTINATION_PORT_ID"));
                    //    iedDESTINATION_PORT_NAME.EditValue = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("DESTINATION_PORT_NAME"));

                    //    vCheck_First = true;
                    //}
                    
                    vLastRow = vRow;

                    vObject2 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vUOM2    = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    //vLine_id2 = Convert.ToInt32(pGrid2.GetCellValue(vRow, pGrid2.GetColumnToIndex("PO_LINE_ID")));

                    if ((vObject1 != vObject2) || (vUOM1 != vUOM2))
                    {
                        //=================================================================================================
                        // 기존에 데이타가 있는지 체크 - 라인부분
                        //=================================================================================================
                        for (int i = 0; i < pGrid1.RowCount; i++)
                        {
                            int    vLine_Id2  = Convert.ToInt32(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                            string vLine_UOM2 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                            if ((vObject1 == vLine_Id2) && (vUOM1 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                            {
                                vCheck = true;

                               // Remarked, 2011-08-26, BY MJSHIN
                               // pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("OPEN_QTY"), vSum_Po_Qty);                                     // 확정발주

                               // decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;  // 금액
                               // pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                                vIndexLastRow = vRow;
                            }
                        }
                        //=================================================================================================
                        // 라인부분에 해당 자재가 없는 경우 해당 라인 추가
                        //=================================================================================================
                        int    vRow_Cnt = 0;
                        object vObject  = "";

                        if (vCheck == false)
                        {
                            Line_Add(pGrid1, pGrid2, pGrid3, vIndexLastRow, vSum_Po_Qty);                                                                    // 라인 그리드 추가 함수 호출

                            vIndexLastRow = vRow;

                            vCheck = false;
                        }

                        vSum_Po_Qty = 0;

                        vPo_Qty     = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REMAIN_QTY")); ;
                        vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                        vObject1    = vObject2;
                        vUOM1       = vUOM2;

                        //vLine_id = vLine_id2;

                        vCheck      = false;
                    }
                    else
                    {
                        vPo_Qty     = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REMAIN_QTY")); ;

                        vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                    }
                }

            }

            //=================================================================================================
            // 기존에 데이타가 있는지 체크 - 라인부분
            //=================================================================================================
             int    vLine_Id5  = Convert.ToInt32(pGrid3.GetCellValue(vLastRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
             string vLine_UOM5 = Convert.ToString(pGrid3.GetCellValue(vLastRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

            for (int i = 0; i < pGrid1.RowCount; i++)
            {
                int    vLine_Id2  = Convert.ToInt32(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                string vLine_UOM2 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                if ((vLine_Id5 == vLine_Id2) && (vLine_UOM5 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                {
                    vCheck = true;

                    //   이미 반영된 자재는 반영하지 않음 , 2011-08-24, BY MJSHIN //
                    //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("OPEN_QTY"), vSum_Po_Qty);                                                 // 요청발주


                    //decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;  // 금액
                    //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                }
            }
            //=================================================================================================
            // 라인부분에 해당 자재가 없는 경우 해당 라인 추가
            //=================================================================================================
            
            int    vRow_Cnt2 = 0;

            object vObject3  = "";

            if (vCheck == false)
            {
                Line_Add(pGrid1, pGrid2, pGrid3, vLastRow, vSum_Po_Qty);                                                                          // 라인 그리드 추가 함수 호출
            }

            vCheck = false;

            //=================================================================================================
            // 기존에 데이타가 있는지 체크 있으면 패스 없을 때 추가 함 - 디테일
            //=================================================================================================
            for (int i = 0; i < pGrid3.RowCount; i++)
            {
                if (pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vLine_id = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_LINE_ID")));
                    vObject1 = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));

                    vUOM1    = Convert.ToString(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    for (int j = 0; j < pGrid1.RowCount; j++)
                    {
                        int vLine_Id4 = Convert.ToInt32(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        string vLine_UOM4 = Convert.ToString(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                        if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4) && (IDA_LINE.OraSelectData.Rows[j].RowState != DataRowState.Deleted))
                        {

                            pGrid1.CurrentCellMoveTo(j, 0);

                            break;
                        }
                    }

                    for (int j = 0; j < pGrid2.RowCount; j++)
                    {
                        int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("PO_LINE_ID")));

                        if (vLine_id == vLine_Id2)
                        {
                            vCheck = true;

                            break;
                        }
                    }
                    //=================================================================================================
                    // 값 옮기기
                    //=================================================================================================
                    if (vCheck == false)
                    {

                        for (int j = 0; j < pGrid1.RowCount; j++)
                        {
                            int    vLine_Id4  = Convert.ToInt32(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                            string vLine_UOM4 = Convert.ToString(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                            if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4))
                            {
                                vRow_Cnt2 = j;

                                break;
                            }

                            vRow_Cnt2 = j;
                        }

                        Detail_Add(pGrid1, pGrid2, pGrid3, vRow_Cnt2, i, pGrid2.RowCount);       // 디테일 그리드 추가 함수 호출

                        //vRow_Cnt3++;
                    }

                    vCheck = false;
                }
            }

            //pGrid2.EndUpdate();
            //pGrid3.EndUpdate();
        }
        //======================================================================================================
        // 디테일의 내용을 종합해서 라인에 뿌려주는 루틴 - UPDATE
        //======================================================================================================
        private void Group_Update(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            Object vPo_Qty     = 0;
            decimal vSum_Po_Qty = 0;
            int    vLastRow    = 0;
            bool   vCheck      = false;

            System.Data.DataRow[] vRows = IDA_DETAIL.OraSelectData.Select(null, "INVENTORY_ITEM_ID, ITEM_UOM_CODE");     //  sort

            int    vObject1 = Convert.ToInt32(vRows[0][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
            int    vObject2 = Convert.ToInt32(vRows[0][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);

            string vUOM1    = Convert.ToString(vRows[0][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);
            string vUOM2    = Convert.ToString(vRows[0][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

            int vIndexLastRow = vRows.Length - 1;

            for (int vRow = 0; vRow < vRows.Length; vRow++)
            {
                vObject2 = Convert.ToInt32(vRows[vRow][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
                vUOM2    = Convert.ToString(vRows[vRow][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

                if ((vObject1 != vObject2) || (vUOM1 != vUOM2))
                {
                    //=================================================================================================
                    // 기존에 데이타가 있는지 체크
                    //=================================================================================================
                    int    vLine_Id1  = Convert.ToInt32(vRows[vRow - 1][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
                    string vLine_UOM1 = Convert.ToString(vRows[vRow - 1][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

                    for (int i = 0; i < pGrid2.RowCount; i++)
                    {
                        int    vLine_Id2  = Convert.ToInt32(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        string vLine_UOM2 = Convert.ToString(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                        if ((vLine_Id1 == vLine_Id2) && (vLine_UOM1 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                        {
                            vCheck = true;

                            pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("OPEN_QTY"), vSum_Po_Qty);                                                 // 요청발주

                            // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사 => 2014.02.04 한화금액 소숫점 반올림으로 변경 
                            decimal vAmount = System.Math.Round(Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty, 2);  // 금액

                            pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);


                            //if (iedCREDIT_FLAG.CheckedString == "Y")
                            //{
                            //    decimal vOPEN_QTY = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("OPEN_QTY")));
                            //    decimal vCREDIT_RATE = Convert.ToDecimal(iedCREDIT_RATE.EditValue) / 100;

                            //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_QTY"), vOPEN_QTY + (vOPEN_QTY * vCREDIT_RATE));             // 과부족포함수량

                            //    decimal vITEM_AMOUNT = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT")));
                            //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vITEM_AMOUNT + (vITEM_AMOUNT * vCREDIT_RATE));    // 과부족포함금액
                            //}
                            //else
                            //{
                            //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_QTY"), vSum_Po_Qty);                                        // 과부족수량

                            //    decimal vObject = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;
                            //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vObject);                                          // 과부족금액
                            //}

                        }
                    }

                    vSum_Po_Qty = 0;
                    vObject1    = vObject2;
                    vUOM1       = vUOM2;
                    vPo_Qty = vRows[vRow][pGrid1.GetColumnToIndex("OPEN_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
                else
                {
                    vPo_Qty = vRows[vRow][pGrid1.GetColumnToIndex("OPEN_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
            }

            vCheck = false;

            //=================================================================================================
            // 기존에 데이타가 있는지 체크
            //=================================================================================================
            int    vLine_Id_Last1  = Convert.ToInt32(vRows[vIndexLastRow][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
            string vLine_UOM_Last1 = Convert.ToString(vRows[vIndexLastRow][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

            for (int i = 0; i < pGrid2.RowCount; i++)
            {
                int    vLine_Id_Last2  = Convert.ToInt32(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                string vLine_UOM_Last2 = Convert.ToString(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                if ((vLine_Id_Last1 == vLine_Id_Last2) && (vLine_UOM_Last1 == vLine_UOM_Last2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                {
                    vCheck = true;

                    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("OPEN_QTY"), vSum_Po_Qty);                                                 // 요청발주

                    // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사 => 2014.02.04 한화금액 소숫점 반올림으로 변경 
                    decimal vAmount = System.Math.Round(Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty, 2);  // 금액

                    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                    //if (iedCREDIT_FLAG.CheckedString == "Y")
                    //{
                    //    decimal vOPEN_QTY = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("OPEN_QTY")));
                    //    decimal vCREDIT_RATE = Convert.ToDecimal(iedCREDIT_RATE.EditValue) / 100;

                    //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_QTY"), vOPEN_QTY + (vOPEN_QTY * vCREDIT_RATE));             // 과부족포함수량

                    //    decimal vITEM_AMOUNT = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT")));
                    //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vITEM_AMOUNT + (vITEM_AMOUNT * vCREDIT_RATE));    // 과부족포함금액
                    //}
                    //else
                    //{
                    //    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("CREDIT_ITEM_QTY"), vSum_Po_Qty);                                        // 과부족수량

                    //    decimal vObject = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;
                    //    pGrid2.SetCellValue(i, pGrid1.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vObject);                                          // 과부족금액
                    //}
                }
            }
        }
        //======================================================================================================
        // 라인의 전체 발주금액 구하는 루틴
        //======================================================================================================
        private void Group_Total_Amount()
        {
            decimal vAmount = 0;
            decimal vAmount2 = 0;
            decimal vQTY = 0;

            for (int i = 0; i < ISG_LINE.RowCount; i++)
            {
                vAmount  += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))));
                vAmount2 += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("CREDIT_ITEM_AMOUNT"))));
                vQTY     += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("OPEN_QTY"))));
            }

            iedTOTAL_AMOUNT.EditValue = vAmount;
            iedTOTAL_AMOUNT2.EditValue = vAmount2;
            iedTOTAL_QTY.EditValue = vQTY;
        }
        //======================================================================================================
        private void CopyGrid_Left_To_Right(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            int vIndexCurrent = IDA_DETAIL.OraSelectData.Rows.IndexOf(IDA_DETAIL.CurrentRow);
            int vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue("PO_LINE_ID"));

            for (int j = 0; j < pGrid2.RowCount; j++)
            {
                int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("PO_LINE_ID")));

                if (vLine_Id1 == vLine_Id2)
                {
                    pGrid2.SetCellValue(j, pGrid2.GetColumnToIndex("CHECK_SELECT"), "N");
                }
            }

            pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);
            IDA_DETAIL.Delete();
        }

        //======================================================================================================
        // 라인의 환율 및 한화금액 구하는 루틴
        //======================================================================================================
        private void Item_Krw_Amount()
        {
            if (Convert.ToDecimal(iedBANKING_HEADER_ID.EditValue) > 0)
            {
                return;
            }

            idcEXCHANGE_RATE_LINE.ExecuteNonQuery();

            for (int i = 0; i < ISG_LINE.RowCount; i++)
            {
                ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("EXCHANGE_RATE"), iedEXCHANGE_RATE.EditValue);

                // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사
                // 2014.02.04 한화금액 소숫점 반올림으로 변경 
                //ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_KRW_AMOUNT"), System.Math.Truncate(Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))) * Convert.ToDecimal(iedEXCHANGE_RATE.EditValue)));
                ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_KRW_AMOUNT"), System.Math.Round(Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))) * Convert.ToDecimal(iedEXCHANGE_RATE.EditValue)));
            }
        }

        private void Line_Setting()
        {
            isgLINE.SetCellValue("LC_NO", ISG_BANKING_LIST.GetCellValue("BANKING_NO"));
            isgLINE.SetCellValue("CHARGE_DATE", DateTime.Today);
            //isgLINE.SetCellValue("CURRENCY_CODE", ISG_BANKING_LIST.GetCellValue("CURRENCY_CODE"));
            isgLINE.SetCellValue("CURRENCY_CODE", "KRW");
            isgLINE.SetCellValue("EXCHANGE_RATE", 1);
            
            //idcEXCHANGE_RATE.ExecuteNonQuery();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaLC_BL_CO.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 2)
                    {
                        idaADJUST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.AddOver();
                        Header_Setting();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaCHARGE.AddOver();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.AddUnder();
                        Header_Setting();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaCHARGE.AddUnder();
                        Line_Setting();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        //if ((iedHEADER_STATUS_CODE.EditValue.ToString() != "CBK") && (iedHEADER_STATUS_CODE.EditValue.ToString() != ""))
                        //{
                        //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("SDM_10037"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        //    return;
                        //}

                        //DataRow row = isHEADER_DA.CurrentRow;
                        //isPO_DA.OraSelectData.AcceptChanges();
                        //isPO_DA.Refillable = true;

                        //if (isLINE_DA.OraSelectData.Rows.Count == 0)
                         

                        DataRow row = IDA_HEADER.CurrentRow;
                        IDA_PO_LIST.OraSelectData.AcceptChanges();
                        IDA_PO_LIST.Refillable = true;

                        iedCUSTOM_NO.EditValue = iedBL_NO.EditValue;

                        IDA_HEADER.Update();
                        IDA_HEADER.Fill();

                        IDA_PO_LIST.Fill();


                        //isButton3.Enabled = false;
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaCHARGE.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        if (IDA_HEADER.IsFocused)
                        {
                            IDA_HEADER.Cancel();
                        }
                        else if (IDA_LINE.IsFocused)
                        {
                            IDA_LINE.Cancel();
                        }
                        else if (IDA_DETAIL.IsFocused)
                        {
                            IDA_DETAIL.Cancel();
                        }
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaCHARGE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        if (IDA_HEADER.IsFocused)
                        {
                            IDA_HEADER.Delete();
                        }
                        else if (IDA_LINE.IsFocused)
                        {
                            if ((ISG_LINE.GetCellValue("LINE_STATUS_CODE").ToString() != "CBK") && (ISG_LINE.GetCellValue("LINE_STATUS_CODE").ToString() != "PBK"))
                            {
                                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                                return;
                            };


                            IDA_LINE.Delete();
                        }
                        else if (IDA_DETAIL.IsFocused)
                        {
                            IDA_DETAIL.Delete();
                        }
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        idaCHARGE.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    int vIndexTAB = TAB_MAIN.SelectedIndex;

                    if (vIndexTAB == 1)
                    {
                        if (idaLC_BL_CO.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", ISG_BANKING_LIST.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if ( Convert.ToInt32( iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID")) ) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));                                
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("PRINT");
                            }
                        }
                        else if (idaCHARGE.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isgLINE.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("PRINT");
                            }
                        }                        
                    }
                    else if (vIndexTAB == 2)
                    {
                        idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                        idcSLIP_ID.ExecuteNonQuery();

                        if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                        {
                            idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_HEADER.Fill();

                            idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_LINE_PRINT.Fill();

                            XLPrinting1("PRINT");
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    int vIndexTAB = TAB_MAIN.SelectedIndex;

                    if (vIndexTAB == 1)
                    {
                        if (idaLC_BL_CO.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", ISG_BANKING_LIST.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("FILE");
                            }
                        }
                        else if (idaCHARGE.IsFocused)
                        {
                            idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isgLINE.GetCellValue("SLIP_NUM"));
                            idcSLIP_ID.ExecuteNonQuery();

                            if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                            {
                                idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_HEADER.Fill();

                                idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                                idaSLIP_LINE_PRINT.Fill();

                                XLPrinting1("FILE");
                            }
                        }
                    }
                    else if (vIndexTAB == 2)
                    {
                        idcSLIP_ID.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                        idcSLIP_ID.ExecuteNonQuery();

                        if (Convert.ToInt32(iConvert.ISNull(idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"))) > 0)
                        {
                            idaSLIP_HEADER.SetSelectParamValue("W_HEADER_INTERFACE_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_HEADER.Fill();

                            idaSLIP_LINE_PRINT.SetSelectParamValue("W_HEADER_IF_ID", idcSLIP_ID.GetCommandParamValue("O_HEADER_ID"));
                            idaSLIP_LINE_PRINT.Fill();

                            XLPrinting1("FILE");
                        }
                    }
                }
            }
        }


//        #endregion;

        private void POMF0718_Load(object sender, EventArgs e)
        {
            iedDATE_FR_S.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedDATE_TO_S.EditValue = DateTime.Today;

            iedDELIVERY_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedDELIVERY_DATE_TO.EditValue = DateTime.Today;

            iedSLIP_DATE.EditValue = DateTime.Today;
            iedSLIP_DATE_C.EditValue = DateTime.Today;
            iedEXPECT_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, 1);

            IDA_HEADER.FillSchema();
            idaLC_BL_CO.FillSchema();
            idaCHARGE.FillSchema();
            idaADJUST.FillSchema();
            idaTRX.FillSchema();

            // Radod Button Initialize //
            //V_SHIPMENT_FLAG.EditValue = Convert.ToString("A");
            //RD_ALL.Checked = true;
        }

        private void isButton1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Group_Add(ISG_LINE, ISG_DETAIL, ISG_TARGET);
            Group_Total_Amount();
            Item_Krw_Amount();
        }
        private void isButton2_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            CopyGrid_Left_To_Right(ISG_DETAIL, ISG_TARGET);
            Group_Del(ISG_LINE, ISG_DETAIL);

            if (IDA_DETAIL.VisbleCurrentRowCount > 0)
            {
                Group_Update(ISG_DETAIL, ISG_LINE);
            }

            Group_Total_Amount();
            Item_Krw_Amount();
        }

        private void isCURRENCY_LA_SelectedRowData(object pSender)
        {
            IDA_PO_LIST.Fill();
        }

        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_DETAIL.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "OPEN_QTY":
                    decimal vPO_Qty;
                    decimal vPO_Qty2;

                    int vObject2;
                    string vUOM2;

                    vPO_Qty = Convert.ToDecimal(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("PO_REMAIN_QTY")));

                    if (vPO_Qty < Convert.ToDecimal(e.NewValue))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10004"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        e.Cancel = true;

                        return;
                    }

                    int vObject1 = Convert.ToInt32(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    string vUOM1 = Convert.ToString(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("ITEM_UOM_CODE")));

                    vPO_Qty = Convert.ToDecimal(e.NewValue) - Convert.ToDecimal(e.OldValue);

                    for (int i = 0; i < ISG_LINE.RowCount; i++)
                    {
                        vObject2 = Convert.ToInt32(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        vUOM2 = Convert.ToString(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_UOM_CODE")));
                        //=================================================================================================
                        // 기존에 데이타가 있는지 체크
                        //=================================================================================================
                        if ((vObject1 == vObject2) && (vUOM1 == vUOM2))
                        {
                            vPO_Qty2 = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("OPEN_QTY")));

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("OPEN_QTY"), vPO_Qty2 + vPO_Qty );                                        // 확정발주

                            // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사
                            // 2014.02.04 한화금액 소숫점 반올림으로 변경 
                            decimal vAmount = System.Math.Round(Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_PRICE"))) * (vPO_Qty2 + vPO_Qty), 2);  // 금액

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                            //ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_KRW_AMOUNT"), System.Math.Truncate(vAmount * Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("EXCHANGE_RATE")))));
                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_KRW_AMOUNT"), System.Math.Round(vAmount * Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("EXCHANGE_RATE")))));


                            //if (iedCREDIT_FLAG.CheckedString == "Y")
                            //{
                            //    decimal vOPEN_QTY = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("OPEN_QTY")));
                            //    decimal vCREDIT_RATE = Convert.ToDecimal(iedCREDIT_RATE.EditValue) / 100;

                            //    ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("CREDIT_ITEM_QTY"), vOPEN_QTY + (vOPEN_QTY * vCREDIT_RATE));             // 과부족포함수량

                            //    decimal vITEM_AMOUNT = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT")));
                            //    ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vITEM_AMOUNT + (vITEM_AMOUNT * vCREDIT_RATE));    // 과부족포함금액
                            //}
                            //else
                            //{
                            //    ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("CREDIT_ITEM_QTY"), vPO_Qty2);                                        // 과부족수량

                            //    decimal vObject = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_PRICE"))) * vPO_Qty2;
                            //    ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("CREDIT_ITEM_AMOUNT"), vObject);                                          // 과부족금액
                            //}
                            Group_Total_Amount();

                            break;
                        }
                    }


                    break;
                default:
                    break;
            }
        }

        private void isHEADER_DA_ExcuteKeySearch(object pSender)
        {
            IDA_PO_LIST.Fill();

            IDA_HEADER.Fill();
            Group_Total_Amount();

            //isButton3.Enabled = true;
        }

        private void isSUPPLIER_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSUPPLIER_LD.SetLookupParamValue("W_CLASS_CODE", "PO");

            if (IDA_LINE.VisbleCurrentRowCount > 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                e.Cancel = true;
            }
        }
        
//        #region  -- Radio Button --
        //private void RD_NOT_SHIPMENT_CheckChanged(object sender, EventArgs e)
        //{
        //    if (RD_NOT_SHIPMENT.Checked == true)
        //    {
        //        V_SHIPMENT_FLAG.EditValue = RD_NOT_SHIPMENT.CheckedString.ToString();
        //    }
        //}

        //private void RD_SHIPMENT_CheckChanged(object sender, EventArgs e)
        //{
        //    if (RD_SHIPMENT.Checked == true)
        //    {
        //        V_SHIPMENT_FLAG.EditValue = RD_SHIPMENT.CheckedString.ToString();
        //    }
        //}

        //private void RD_ALL_CheckChanged(object sender, EventArgs e)
        //{
        //    if (RD_ALL.Checked == true)
        //    {
        //        V_SHIPMENT_FLAG.EditValue = RD_ALL.CheckedString.ToString();
        //    }
        //}
        
        private void ISG_BANKING_LIST_CellDoubleClick(object pSender)
        {
            if (IDA_HEADER.Refillable == true && IDA_LINE.Refillable == true && IDA_DETAIL.Refillable == true)
            {
                iedBANKING_HEADER_ID.EditValue = ISG_BANKING_LIST.GetCellValue("BANKING_HEADER_ID");

                IDA_HEADER.OraSelectData.AcceptChanges();
                IDA_HEADER.Refillable = true;

                IDA_HEADER.Fill();
                Group_Total_Amount();

                IDA_PO_LIST.Fill();

                //isButton3.Enabled = true;

                TAB_MAIN.SelectedIndex = 0;
            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void ilaLC_NO_SelectedRowData(object pSender)
        {
            IDA_PO_LIST.Fill();
        }

        private void ilagCHARGE_TYPE_SelectedRowData(object pSender)
        {            
            if (isgLINE.GetCellValue("CHARGE_CLASS_LCODE").ToString() == "BL")
            {
                isgLINE.SetCellValue("BL_NO", ISG_BANKING_LIST.GetCellValue("BL_NO"));
            }
            else if (isgLINE.GetCellValue("CHARGE_CLASS_LCODE").ToString() == "CUSTOM")
            {
                isgLINE.SetCellValue("CUSTOM_NO", ISG_BANKING_LIST.GetCellValue("CUSTOM_NO"));
            }
        }

        private void ISG_BANKING_LIST_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            idaCHARGE.Fill();
        }

        private void isgLINE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (isgLINE.GetCellValue("CHARGE_CODE") == "VAT")
            {
                return;
            }

            switch (isgLINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "CHARGE_DATE":
                case "CURRENCY_CODE":                    
                    if (isgLINE.GetCellValue("CURRENCY_CODE") != "KRW")
                    {
                        idcEXCHANGE_RATE.ExecuteNonQuery();
                    }
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT")) * Convert.ToDecimal(isgLINE.GetCellValue("EXCHANGE_RATE")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                case "CHARGE_AMOUNT":
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(isgLINE.GetCellValue("EXCHANGE_RATE")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                case "EXCHANGE_RATE":
                    isgLINE.SetCellValue("CHARGE_AMOUNT_OWN", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT")));
                    isgLINE.SetCellValue("TAX_AMOUNT", System.Math.Truncate(Convert.ToDecimal(isgLINE.GetCellValue("CHARGE_AMOUNT_OWN")) / 10));
                    break;

                default:
                    break;
            }

            
        }
       
        private void ISG_LINE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            switch (ISG_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                // 2012.07.30 통화금액 소숫점 3자리 반올림, 한화금액 소숫점 절사
                // 2014.02.04 한화금액 소숫점 반올림으로 변경 
                case "EXCHANGE_RATE":
                    //ISG_LINE.SetCellValue("ITEM_KRW_AMOUNT", System.Math.Truncate(Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT"))));
                    ISG_LINE.SetCellValue("ITEM_KRW_AMOUNT", System.Math.Round(Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT"))));
                    break;
                case "ITEM_PRICE":
                    ISG_LINE.SetCellValue("ITEM_AMOUNT", System.Math.Round(Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("OPEN_QTY")), 2));
                    //ISG_LINE.SetCellValue("ITEM_KRW_AMOUNT", System.Math.Truncate(Convert.ToDecimal(ISG_LINE.GetCellValue("EXCHANGE_RATE")) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT"))));
                    ISG_LINE.SetCellValue("ITEM_KRW_AMOUNT", System.Math.Round(Convert.ToDecimal(ISG_LINE.GetCellValue("EXCHANGE_RATE")) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT"))));
                    break;

                default:
                    break;
            }
        }

        private void iedSHPPING_DATE_EditValueChanged(object pSender)
        {
            Item_Krw_Amount();
        }

        private void ilagCURRENCY_SelectedRowData(object pSender)
        {
            idcEXCHANGE_RATE.ExecuteNonQuery();
        }

        private void ibtSLIP_SEND_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string X_RESULT_STATUS;
            string X_RESULT_MSG;

            isDataTransaction1.BeginTran();

            idcSEND.ExecuteNonQuery();

            X_RESULT_STATUS = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_STATUS"));
            X_RESULT_MSG = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_MSG"));

            if (idcSEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaLC_BL_CO.Fill();
            idaCHARGE.Fill();
        }

        private void ibtSLIP_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isDataTransaction1.BeginTran();

            idcCANCEL.ExecuteNonQuery();

            string X_RESULT_STATUS = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_STATUS"));
            string X_RESULT_MSG = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_MSG"));

            if (idcCANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaLC_BL_CO.Fill();
            idaCHARGE.Fill();
        }

        private void ibtLC_ADJUST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_ADJUST.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcLC_ADJUST.SetCommandParamValue("P_DELIVERY_DATE", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("DELIVERY_DATE")));
                    idcLC_ADJUST.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcLC_ADJUST.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_ADJUST.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_ADJUST.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_ADJUST.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();        
        }

        private void ibtLC_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcTRX_CONFIRM.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcTRX_CONFIRM.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcTRX_CONFIRM.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcTRX_CONFIRM.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcTRX_CONFIRM.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcTRX_CONFIRM.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();        
        }

        private void ibtLC_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcTRX_CANCEL.SetCommandParamValue("P_PERIOD_NAME", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("PERIOD_NAME")));
                    idcTRX_CANCEL.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                    idcTRX_CANCEL.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcTRX_CANCEL.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcTRX_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcTRX_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();    
        }

        private void ibtSLIP_SEND_C_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_SEND.SetCommandParamValue("P_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_SEND.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_SEND.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_SEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();    
        }

        private void ibtSLIP_CANCEL_C_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcLC_CANCEL.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx2.GetCellValue("SLIP_NUM"));
                    idcLC_CANCEL.SetCommandParamValue("W_LC_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("LC_NO")));
                    idcLC_CANCEL.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcLC_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcLC_CANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaADJUST.OraSelectData.AcceptChanges();
            idaADJUST.Refillable = true;

            idaADJUST.Fill();    
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            vMessageText = string.Format("Printing Start");
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vCountRowTable = idaSLIP_HEADER.OraSelectData.Rows.Count;

            if (vCountRowTable > 0)
            {
                //-------------------------------------------------------------------------------------
                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                try
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "POMF0718_001.xls";
                    xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인
                    xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                    xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                    xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    bool isOpen = xlPrinting.XLFileOpen();
                    //-------------------------------------------------------------------------------------

                    if (isOpen == true)
                    {
                        //-------------------------------------------------------------------------------------
                        xlPrinting.HeaderWrite(idaSLIP_HEADER);

                        object vObject_DEPT_ID = idaSLIP_HEADER.OraSelectData.Rows[0][idaSLIP_HEADER.OraSelectData.Columns.IndexOf("DEPT_ID")];
                        idaDOC_APPROVAL_LINE.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                        idaDOC_APPROVAL_LINE.Fill();

                        vPageNumber = xlPrinting.LineWrite(idaSLIP_LINE_PRINT, idaDOC_APPROVAL_LINE.OraSelectData);

                        if (pOutChoice == "PRINT")
                        {
                            xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                        }
                        else if (pOutChoice == "FILE")
                        {
                            xlPrinting.Save("FL_");
                        }
                        //-------------------------------------------------------------------------------------
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    xlPrinting.Dispose();
                }
                //-------------------------------------------------------------------------------------
            }

            vPageTotal = vPageTotal + vPageNumber;

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Printing End [Total Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;
        
    }


}