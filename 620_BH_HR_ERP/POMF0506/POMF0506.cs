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

namespace POMF0506
{
    public partial class POMF0506 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----
         
        private string mRadioValue = string.Empty;
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public POMF0506(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;             
        }

        #endregion;

        #region ----- Private Methods ----
        private void Header_Setting()
        {
            iedPO_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            iedPO_PERSON_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;

            iedPO_DEPT_ID.EditValue = isAppInterfaceAdv1.DEPT_ID;
            iedPO_DEPT_NAME.EditValue = isAppInterfaceAdv1.DEPT_NAME;

            iedPO_DATE.EditValue = DateTime.Today;

            isDataCommand1.ExecuteNonQuery();

            IDA_REQUEST.Refillable = true;  // ADDED, BY MJSHIN
            IDA_REQUEST.Fill();             // ADDED, BY MJSHIN

            SUPPLIER_ENABLE();              // ADDED, BY MJSHIN
            BUTTON_ENABLE();                // ADDED, BY MJSHIN
        }
        
        private void Line_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow, object vPo_Qty)
        {
            int    vIndexLastRow = Convert.ToInt32(vRow);
            decimal   vSum_Po_Qty   = Convert.ToDecimal(vPo_Qty);
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

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("MAT_MIN_QTY"));
             pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("MIN_ORDER_QTY"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow,pGrid3.GetColumnToIndex("DELIVERY_REQ_DATE")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("DELIVERY_REQ_DATE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CURRENCY_CODE")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CURRENCY_CODE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("PO_PRICE")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_PRICE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CATEGORY_DESCRIPTION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CATEGORY_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("SECTION_DESCRIPTION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("SECTION_DESCRIPTION"), vObject);

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("REQUEST_QTY"), vSum_Po_Qty);           // 요청발주량 pGrid1.SetCellValue(vRow_Cnt, 

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("PO_QTY"), vSum_Po_Qty);                // 확정발주량

            decimal vPrice = Convert.ToDecimal(Convert.ToDecimal(pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("PO_PRICE"))));

            vObject = vPrice * vSum_Po_Qty; 

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vObject);                // 금액
        }
        private void Detail_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow_Line, object vRow, object vRow_Detail)
        {
            int    vRow_Cnt  = Convert.ToInt32(vRow_Line);
            int    vRow_Cnt2 = Convert.ToInt32(vRow_Detail);
            int    i         = Convert.ToInt32(vRow);

            object vObject   = "";

            //pGrid1.CurrentCellMoveTo(vRow_Cnt, 0);

            //if (pGrid2.RowCount == 0)
            //{
            //    pGrid2.CurrentCellMoveTo(0, 0);
            //}
            //else
            //{
            //    pGrid2.CurrentCellMoveTo(pGrid2.RowCount - 1, 0);
            //}

            IDA_DETAIL.MoveLast(this.Name);
            IDA_DETAIL.AddUnder();

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REQUEST_LINE_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REQUEST_LINE_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REQUEST_HEADER_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REQUEST_HEADER_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REQUEST_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REQUEST_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("LINE_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REQUEST_LINE_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REQ_REMAIN_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_DESCRIPTION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("SUPPLIER_SHORT_NAME"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("SUPPLIER_SHORT_NAME"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CATEGORY_DESCRIPTION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CATEGORY_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("SECTION_DESCRIPTION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("SECTION_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CURRENCY_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CURRENCY_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_PRICE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_PRICE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_UOM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_SPECIFICATION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_SPECIFICATION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("MAT_MIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("MAT_MIN_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("DELIVERY_REQ_DATE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("DELIVERY_REQ_DATE"), vObject);

        }
        //======================================================================================================
        // 라인에서 디테일에 없거나 디테일의 발주량이 0 이면 삭제 하는 루틴
        //======================================================================================================
        private void Group_Del(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            bool vCheck  = false;

            decimal  vPO_Qty = 0;
            decimal  vPO_Qty_Sum = 0;
            
            //int  i = 0;
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

                        vPO_Qty = Convert.ToDecimal(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("PO_QTY")));

                        vPO_Qty_Sum = vPO_Qty_Sum + vPO_Qty;
                    }
                }

                if ((vCheck == false) || (vPO_Qty_Sum == 0))
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
        private void Group_Add2(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3)
        {
            Object vPo_Qty     = 0;

            decimal vSum_Po_Qty = 0;
            int     vLastRow    = 0;

            bool vCheck      = false;

            bool vCheck_Button = false;

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

                    vLine_id = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REQUEST_LINE_ID")));

                    vUOM1 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));
                    vUOM2 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    vCheck_Button = true;

                    break;
                }
            }

            if (vCheck_Button == false)
            {
                return;
            }

            int vIndexLastRow = vRow;

            //for (vRow = vRow ; vRow < pGrid3.RowCount; vRow++)
            for (vRow = vIndexLastRow; vRow < pGrid3.RowCount; vRow++)
            {
                if (pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vLastRow = vRow;

                    vObject2 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vUOM2    = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    vLine_id2 = Convert.ToInt32(pGrid2.GetCellValue(vRow, pGrid2.GetColumnToIndex("REQUEST_LINE_ID")));

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
                             //   이미 반영된 자재는 반영하지 않음 , 2011-08-24, BY MJSHIN //
                             //   decimal vADJUST_QTY = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ADJUST_QTY")));                            // 조정량

                             //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("REQUEST_QTY"), vSum_Po_Qty);                                                 // 요청발주
                             //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("PO_QTY"), vSum_Po_Qty + vADJUST_QTY);                                        // 확정발주

                             //   decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * (vSum_Po_Qty + vADJUST_QTY);  // 금액
                             //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                                vIndexLastRow = vRow;
                            }
                        }
                        //=================================================================================================
                        // 라인부분에 해당 자재가 없는 경우 해당 라인 추가
                        //=================================================================================================
                        //int    vRow_Cnt = 0;
                        object vObject  = "";

                        if (vCheck == false)
                        {
                            Line_Add(pGrid1, pGrid2, pGrid3, vIndexLastRow, vSum_Po_Qty);                                                                    // 라인 그리드 추가 함수 호출

                            vIndexLastRow = vRow;
                        }

                        vSum_Po_Qty = 0;

                        vPo_Qty     = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REMAIN_QTY")); ;
                        vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                        vObject1    = vObject2;
                        vUOM1       = vUOM2;

                        vLine_id = vLine_id2;

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
                 //   decimal vADJUST_QTY = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ADJUST_QTY")));                            // 조정량

                 //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("REQUEST_QTY"), vSum_Po_Qty);                                                 // 요청발주
                 //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("PO_QTY"), vSum_Po_Qty + vADJUST_QTY);                                        // 확정발주


                 //   decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * (vSum_Po_Qty + vADJUST_QTY);  // 금액
                 //   pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                }
            }
            //=================================================================================================
            // 라인부분에 해당 자재가 없는 경우 해당 라인 추가
            //=================================================================================================
            int    vRow_Cnt3 = 0;
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
                    vLine_id = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REQUEST_LINE_ID")));
                    vObject1 = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));

                    vUOM1    = Convert.ToString(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    for (int j = 0; j < pGrid1.RowCount; j++)
                    {
                        int vLine_Id4 = Convert.ToInt32(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        string vLine_UOM4 = Convert.ToString(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                        //if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4) -- 2011-08-26, 데이터 삭제여부 체크 , BY MJSHIN --
                        if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4) && (IDA_LINE.OraSelectData.Rows[j].RowState != DataRowState.Deleted))
                        {

                            pGrid1.CurrentCellMoveTo(j, 0);

                            break;
                        }
                    }

                    for (int j = 0; j < pGrid2.RowCount; j++)
                    {
                        int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("REQUEST_LINE_ID")));

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

                        vRow_Cnt3++;
                    }

                    vCheck = false;
                }
            }
        }
        //======================================================================================================
        // 디테일의 내용을 종합해서 라인에 뿌려주는 루틴 - UPDATE
        //======================================================================================================
        private void Group_Update(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            Object vPo_Qty     = 0;
            decimal    vSum_Po_Qty = 0;
            //int    vLastRow    = 0;
            //bool   vCheck      = false;

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
                            //vCheck = true;

                            decimal vADJUST_QTY = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ADJUST_QTY")));                            // 조정량

                            pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("REQUEST_QTY"), vSum_Po_Qty);                                                 // 요청발주
                            pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("PO_QTY"), vSum_Po_Qty + vADJUST_QTY);                                        // 확정발주

                            decimal vAmount = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * (vSum_Po_Qty + vADJUST_QTY);  // 금액

                            pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                        }
                    }

                    vSum_Po_Qty = 0;
                    vObject1    = vObject2;
                    vUOM1       = vUOM2;
                    vPo_Qty     = vRows[vRow][pGrid1.GetColumnToIndex("PO_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
                else
                {
                    vPo_Qty     = vRows[vRow][pGrid1.GetColumnToIndex("PO_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
            }

            //vCheck = false;

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
                    //vCheck = true;

                    decimal vADJUST_QTY = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ADJUST_QTY")));                            // 조정량

                    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("REQUEST_QTY"), vSum_Po_Qty);                                                 // 요청발주
                    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("PO_QTY"), vSum_Po_Qty + vADJUST_QTY);                                        // 확정발주

                    decimal vAmount = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * (vSum_Po_Qty + vADJUST_QTY);  // 금액

                    pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                }
            }
        }
        //======================================================================================================
        // 라인의 전체 발주금액 구하는 루틴
        //======================================================================================================
        private void Group_Total_Amount()
        {
            Decimal vAmount = 0;

            for (int i = 0; i < ISG_LINE.RowCount; i++)
            {
                vAmount += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))));
            }

            iedTOTAL_AMOUNT.EditValue = vAmount;
        }
        //======================================================================================================
        private void CopyGrid_Left_To_Right(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            int    vIndexCurrent = IDA_DETAIL.OraSelectData.Rows.IndexOf(IDA_DETAIL.CurrentRow);
            int    vLine_Id1     = Convert.ToInt32(pGrid1.GetCellValue("REQUEST_LINE_ID"));

            for (int j = 0; j < pGrid2.RowCount; j++)
            {
                int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("REQUEST_LINE_ID")));

                if (vLine_Id1 == vLine_Id2)
                {
                    pGrid2.SetCellValue(j, pGrid2.GetColumnToIndex("CHECK_SELECT"), "N");
                }
            }

            pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);
            IDA_DETAIL.Delete();
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
                        IDA_PO_LIST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    IDA_HEADER.AddOver();
                    Header_Setting();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    IDA_HEADER.AddUnder();
                    Header_Setting();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if ((iedHEADER_STATUS.EditValue.ToString() != "CPO") && (iedHEADER_STATUS.EditValue.ToString() != ""))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10002"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        return;
                    }


                    //if (isLINE_DA.VisbleCurrentRowCount == 0)
                    //{
                    //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10005"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    //    return;
                    //}

                    IDA_HEADER.Update();
                    IDA_HEADER.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
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
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.Delete();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.Delete();
                    }
                    else if (IDA_DETAIL.IsFocused)
                    {
                        IDA_DETAIL.Delete();
                    }
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

        #region ----- Form Events -----

        private void POMF0506_Load(object sender, EventArgs e)
        {
            V_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            V_DATE_TO.EditValue = DateTime.Today;

            IDA_HEADER.FillSchema();

            RD_ALL.Checked = true;
            V_DELIVERY_FLAG.EditValue = Convert.ToString("A");
        }

        private void isButton1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Group_Add2(ISG_LINE, ISG_DETAIL, ISG_TARGET);
            Group_Total_Amount();

            SUPPLIER_ENABLE(); // ADDED, BY MJSHIN
        }
        private void isButton2_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (ISG_DETAIL.GetCellValue("REQUEST_LINE_ID").ToString() != "0")
            {
                CopyGrid_Left_To_Right(ISG_DETAIL, ISG_TARGET);
                Group_Del(ISG_LINE, ISG_DETAIL);

                if (ISG_DETAIL.RowCount > 0)
                {
                    if (IDA_DETAIL.VisbleCurrentRowCount > 0)
                    {
                        Group_Update(ISG_DETAIL, ISG_LINE);
                    }
                }


                Group_Total_Amount();

                SUPPLIER_ENABLE(); // ADDED, BY MJSHIN
            }
            
        }

        private void isCURRENCY_LA_SelectedRowData(object pSender)
        {
            IDA_REQUEST.Refillable = true;
            IDA_REQUEST.Fill();
        }

        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_DETAIL.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "PO_QTY":
                    decimal vPO_Qty;
                    decimal vPO_Qty2;

                    int vObject2;
                    string vUOM2;

                    vPO_Qty = Convert.ToDecimal(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("REQ_REMAIN_QTY")));

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
                        vUOM2    = Convert.ToString(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_UOM_CODE")));
                        //=================================================================================================
                        // 기존에 데이타가 있는지 체크
                        //=================================================================================================
                        if ((vObject1 == vObject2) && (vUOM1 == vUOM2))
                        {
                            vPO_Qty2 = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("REQUEST_QTY")));

                            decimal vADJUST_QTY = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ADJUST_QTY")));                                   // 조정량

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("REQUEST_QTY"), vPO_Qty2 + vPO_Qty);                                                 // 요청발주
                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("PO_QTY"), vPO_Qty2 + vPO_Qty + vADJUST_QTY);                                        // 확정발주

                            decimal vAmount = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_PRICE"))) * (vPO_Qty2 + vPO_Qty + vADJUST_QTY);  // 금액

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

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
            IDA_REQUEST.Fill();

            IDA_HEADER.Fill();
            Group_Total_Amount();

            SUPPLIER_ENABLE();  // ADDED, BY MJSHIN
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "ADJUST_QTY":

                    ISG_LINE.SetCellValue("PO_QTY", Convert.ToDecimal(e.NewValue) + Convert.ToDecimal(ISG_LINE.GetCellValue("REQUEST_QTY")));
                    ISG_LINE.SetCellValue("ITEM_AMOUNT", (Convert.ToDecimal(e.NewValue) + Convert.ToDecimal(ISG_LINE.GetCellValue("REQUEST_QTY"))) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_PRICE")));

                    Group_Total_Amount();
                    break;

                case "ITEM_PRICE":
                    ISG_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("PO_QTY")));

                    Group_Total_Amount();
                    break;

                default:
                    break;
            }
        }

        private void iedPO_DATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (iedPO_DATE.DateTimeValue > DateTime.Today)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10001"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                iedPO_DATE.EditValue = DateTime.Today;
            }
        }

        private void isSUPPLIER_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //isSUPPLIER_LD.SetLookupParamValue("W_CLASS_CODE", "PO");

            //if (isLINE_DA.VisbleCurrentRowCount > 0)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            //    e.Cancel = true;
            //}
        }

        private void isSUPPLIER_LA_SelectedRowData(object pSender)
        {

            if (iedCURRENCY_CODE.EditValue.ToString() != "")
            {
                IDA_REQUEST.Refillable = true;
                IDA_REQUEST.Fill();
            }
            
        }

        private void isSUPPLIER_LA2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //isSUPPLIER_LD2.SetLookupParamValue("W_CLASS_CODE", "PO");
        }

        private void isSUPPLIER_LA2_SelectedRowData(object pSender)
        {
            isDataCommand2.ExecuteNonQuery();

            IDA_REQUEST.Refillable = true;
            IDA_REQUEST.Fill();
        }

        private void SUPPLIER_ENABLE()  // ADDED, BY MJSHIN
        {
            if (ISG_LINE.RowCount != 0)
            {
                iedSUPPLIER_NAME.Insertable = false;
                iedSUPPLIER_NAME.Updatable = false;
                iedSUPPLIER_NAME.Refresh();
                //iedCURRENCY_CODE.Insertable = false;  // 통화수정가능토록 변경, 2011-08-26, By MJSHIN // 
                //iedCURRENCY_CODE.Updatable = false;
                //iedCURRENCY_CODE.Refresh();
            }
            else
            {
                iedSUPPLIER_NAME.Insertable = true;
                iedSUPPLIER_NAME.Updatable = true;
                iedSUPPLIER_NAME.Refresh();
                //iedCURRENCY_CODE.Insertable = true;
                //iedCURRENCY_CODE.Updatable = true;
                //iedCURRENCY_CODE.Refresh();
            }
        }

        private void BUTTON_ENABLE()  // ADDED, BY MJSHIN
        {
            if (iedSUPPLIER_ID.EditValue == null)
            {
                BT_APPLY.Enabled = false;
                BT_EXCEPT.Enabled = false;
                BT_APPLY.Refresh();
                BT_EXCEPT.Refresh();
            }
            else
            {
                BT_APPLY.Enabled = true;
                BT_EXCEPT.Enabled = true;
                BT_APPLY.Refresh();
                BT_EXCEPT.Refresh();
            }
        }

        private void iedSUPPLIER_NAME_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            BUTTON_ENABLE();  // ADDED, BY MJSHIN
        }
        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- Convert String Methods ----

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
            catch
            {
            }

            return vString;
        }

        #endregion;

        #region ----- Export File Name Methods ----

        private string SetExportFileName(string pExportFileName)
        {
            string vExportFileName = string.Empty;

            try
            {
                vExportFileName = pExportFileName;
                vExportFileName = vExportFileName.Replace("/", "_");
                vExportFileName = vExportFileName.Replace("\\", "_");
                vExportFileName = vExportFileName.Replace("*", "_");
                vExportFileName = vExportFileName.Replace("<", "_");
                vExportFileName = vExportFileName.Replace(">", "_");
                vExportFileName = vExportFileName.Replace("|", "_");
                vExportFileName = vExportFileName.Replace("?", "_");
                vExportFileName = vExportFileName.Replace(":", "_");
                vExportFileName = vExportFileName.Replace(" ", "_");
            }
            catch
            {
            }

            return vExportFileName;
        }

        #endregion;

        #region ----- XL Print Methods ----

        //private void XLPrinting(int pChoiceXLSheet, string pRadioValue)
        //{
        //    bool isError = false;
        //    string vMessageText = string.Empty;
        //    string vSaveFileName = string.Empty;

        //    //저장 파일 이름 : 매출처_PO_No
        //    string vFirst = ConvertString(iedSUPPLIER_NAME.EditValue); //매출처
        //    string vSecond = ConvertString(iedPO_NO.EditValue);        //PO_No
        //    vSaveFileName = string.Format("{0}_{1}_{2:D2}", vFirst, vSecond, pChoiceXLSheet);
        //    vSaveFileName = SetExportFileName(vSaveFileName);

        //    int vCountRowDB = IDA_HEADER.OraSelectData.Rows.Count;

        //    if (vCountRowDB < 1)
        //    {
        //        vMessageText = string.Format("Without Data");
        //        isAppInterfaceAdv1.OnAppMessage(vMessageText);
        //        System.Windows.Forms.Application.DoEvents();
        //        return;
        //    }

        //    if (pRadioValue == "EXCEL" || pRadioValue == "PDF")
        //    {
        //        if (pRadioValue == "EXCEL")
        //        {
        //            saveFileDialog1.Title = "Excel Save";
        //            saveFileDialog1.DefaultExt = "xls";
        //            saveFileDialog1.Filter = "Excel Files *.xls|*.xls";
        //        }
        //        else if (pRadioValue == "PDF")
        //        {
        //            saveFileDialog1.Title = "PDF Save";
        //            saveFileDialog1.DefaultExt = "pdf";
        //            saveFileDialog1.Filter = "PDF Files *.pdf|*.pdf";
        //        }

        //        saveFileDialog1.FileName = vSaveFileName;
        //        System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
        //        saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
        //        if (saveFileDialog1.ShowDialog() != System.Windows.Forms.DialogResult.OK)
        //        {
        //            return;
        //        }

        //        vSaveFileName = saveFileDialog1.FileName;
        //    }

        //    System.Windows.Forms.Application.UseWaitCursor = true;
        //    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
        //    System.Windows.Forms.Application.DoEvents();

        //    int vPageNumber = 0;
        //    int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

        //    vMessageText = string.Format(" Printing Starting");
        //    isAppInterfaceAdv1.OnAppMessage(vMessageText);
        //    System.Windows.Forms.Application.DoEvents();

        //    //XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

        //    try
        //    {
        //        vMessageText = string.Empty;
        //        string vPrintingDate = string.Format("{0:D2}/{1:D2}", System.DateTime.Now.Month, System.DateTime.Now.Day);
        //        string vPrintingUser = isAppInterfaceAdv1.AppInterface.DisplayName;

        //        //-------------------------------------------------------------------------------------
        //        xlPrinting.OpenFileNameExcel = "POMF0506_001.xls";
        //        //-------------------------------------------------------------------------------------

        //        //-------------------------------------------------------------------------------------
        //        bool isOpen = xlPrinting.XLFileOpen();
        //        //-------------------------------------------------------------------------------------

        //        //-------------------------------------------------------------------------------------
        //        if (isOpen == true)
        //        {
        //            vPageNumber = xlPrinting.LineWrite(pChoiceXLSheet, IDA_HEADER, ISG_LINE, iedTOTAL_AMOUNT);

        //            ////[PRINT]
        //            ////xlPrinting.Printing(3, 4); //시작 페이지 번호, 종료 페이지 번호
        //            //xlPrinting.Printing(1, vPageNumber);

        //            ////[SAVE]
        //            //xlPrinting.Save("ORDER_"); //Excel 저장 파일명
        //            //xlPrinting.PDF("ORDER_");  //PDF   저장 파일명

        //            if (pRadioValue == "PRINT")
        //            {
        //                xlPrinting.Printing(1, vPageNumber);
        //            }
        //            else if (pRadioValue == "EXCEL")
        //            {
        //                xlPrinting.DeleteSheet();
        //                xlPrinting.SAVE(vSaveFileName); //Excel 파일명
        //            }
        //            else if (pRadioValue == "PDF")
        //            {
        //                xlPrinting.DeleteSheet();
        //                xlPrinting.PDF(vSaveFileName);  //PDF 파일명
        //            }

        //            System.Threading.Thread.Sleep(2000);
        //            //-------------------------------------------------------------------------------------
        //            xlPrinting.Dispose();
        //            //-------------------------------------------------------------------------------------
        //        }
        //        else
        //        {
        //            vMessageText = "Excel File Open Error";
        //        }
        //        //-------------------------------------------------------------------------------------
        //    }
        //    catch (System.Exception ex)
        //    {
        //        isError = true;
        //        vMessageText = ex.Message;
        //        xlPrinting.Dispose();
        //    }

        //    if (isError != true)
        //    {
        //        //-------------------------------------------------------------------------------------
        //        vMessageText = string.Format("{0} Printing End [Total Page : {1}]", vMessageText, vPageNumber);
        //        isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
        //        System.Windows.Forms.Application.DoEvents();
        //        //-------------------------------------------------------------------------------------
        //    }
        //    else
        //    {
        //        MessageBoxAdv.Show(vMessageText, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //    }

        //    xlPrinting.KillProcess_Excel();

        //    System.Windows.Forms.Application.UseWaitCursor = false;
        //    this.Cursor = System.Windows.Forms.Cursors.Default;
        //    System.Windows.Forms.Application.DoEvents();
        //}

        //private void isButton3_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(1, mRadioValue); //구매 발주(일반)
        //}

        //private void isButton4_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(2, mRadioValue); //구매 발주(발송)
        //}

        //private void isButton5_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(3, mRadioValue); //구매 발주(외자)
        //}

        private void isRadioButtonAdv_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue = vRadio.RadioCheckedString;
            }
        }

        private void POMF0506_Shown(object sender, EventArgs e)
        {
            isGroupBox7.BringToFront();
            isRadioButtonAdv1.CheckedState = ISUtil.Enum.CheckedState.Checked;
        }

        #endregion;

        private void isGridAdvEx3_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (ISG_TARGET.GetColumnToIndex("CHECK_REQUEST_CANCEL") == e.ColIndex && e.NewValue.ToString() == "Y")
            {
                DialogResult vDialogResult =  MessageBoxAdv.Show(isMessageAdapter1.ReturnText("INV_10047"), "PO Request Line Cancel", MessageBoxButtons.OKCancel, MessageBoxIcon.Information);

                if (vDialogResult == DialogResult.OK)
                {
                    idc_INV_PO_REQ_LINE_CANCEL.ExecuteNonQuery();

                    if (!idc_INV_PO_REQ_LINE_CANCEL.ExcuteError)
                    {
                        string vRESULT_STATUS = iConvert.ISNull(idc_INV_PO_REQ_LINE_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                        string vRESULT_MSG = iConvert.ISNull(idc_INV_PO_REQ_LINE_CANCEL.GetCommandParamValue("X_RESULT_MSG"));

                        if (vRESULT_STATUS == "S")
                        {
                            ISG_TARGET.CurrentCellMoveTo(e.ColIndex - 1);
                        }
                        else
                        {
                            MessageBoxAdv.Show(vRESULT_MSG, "PO Request Line Cancel", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            ISG_TARGET.SetCellValue("CHECK_REQUEST_CANCEL", "N".ToString());
                            ISG_TARGET.CurrentCellMoveTo(e.ColIndex - 1);
                        }
                    }
                    else
                    {
                        MessageBoxAdv.Show(idc_INV_PO_REQ_LINE_CANCEL.ExcuteErrorMsg, "PO Request Line Cancel", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        ISG_TARGET.SetCellValue("CHECK_REQUEST_CANCEL", "N".ToString());
                        ISG_TARGET.CurrentCellMoveTo(e.ColIndex - 1);
                    }
                }
                else
                {
                    ISG_TARGET.SetCellValue("CHECK_REQUEST_CANCEL", "N".ToString());
                    ISG_TARGET.CurrentCellMoveTo(e.ColIndex - 1);
                }
            }
            else if (ISG_TARGET.GetColumnToIndex("CHECK_REQUEST_CANCEL") == e.ColIndex && e.NewValue.ToString() == "N")
            {
                ISG_TARGET.CurrentCellMoveTo(e.ColIndex - 1);
            }
        }

        private void isGridAdvEx3_CurrentCellAcceptedChanges(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (ISG_TARGET.GetColumnToIndex("CHECK_REQUEST_CANCEL") == e.ColIndex && e.NewValue.ToString() == "Y")
            {
                if (IDA_REQUEST.OraSelectData != null)
                {
                    IDA_REQUEST.OraSelectData.AcceptChanges();
                    IDA_REQUEST.Refillable = true;
                }

                IDA_REQUEST.Fill();
            }
            else if (ISG_TARGET.GetColumnToIndex("CHECK_REQUEST_CANCEL") == e.ColIndex && e.NewValue.ToString() == "N")
            {
                IDA_REQUEST.OraSelectData.AcceptChanges();
                IDA_REQUEST.Refillable = true;
            }


        }

        #region  -- Radio Button --
        private void RD_NOT_DELIVERY_CheckChanged(object sender, EventArgs e)
        {
            if (RD_NOT_DELIVERY.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_NOT_DELIVERY.CheckedString.ToString();
            }
        }

        private void RD_DELIVERY_CheckChanged(object sender, EventArgs e)
        {
            if (RD_DELIVERY.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_DELIVERY.CheckedString.ToString();
            }
        }

        private void RD_ALL_CheckChanged(object sender, EventArgs e)
        {
            if (RD_ALL.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_ALL.CheckedString.ToString();
            }
        }
        #endregion;

        #region  -- PO LIST Double Click --
        private void ISG_PO_LIST_CellDoubleClick(object pSender)
        {
            if (IDA_HEADER.Refillable == true && IDA_LINE.Refillable == true && IDA_DETAIL.Refillable == true)
            {
                iedPO_HEADER_ID.EditValue = ISG_PO_LIST.GetCellValue("PO_HEADER_ID");

                IDA_HEADER.OraSelectData.AcceptChanges();
                IDA_HEADER.Refillable = true;


                

                IDA_HEADER.Fill();
                Group_Total_Amount();

                IDA_REQUEST.Fill();

                SUPPLIER_ENABLE();  // ADDED, BY MJSHIN

                TAB_MAIN.SelectedIndex = 0;
                
            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        #endregion;
    }
}