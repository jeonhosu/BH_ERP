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

namespace HRMF0201
{
    public partial class HRMF0201 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private string mMessageError = string.Empty;

        #endregion;

        #region ----- UpLoad / DownLoad Variables -----

        private InfoSummit.Win.ControlAdv.ISFileTransferAdv mFileTransferAdv;
        private ItemImageInfomationFTP mImageFTP;

        private string mFTP_Source_Directory = string.Empty;            // ftp 소스 디렉토리.
        private string mClient_Base_Path = System.Windows.Forms.Application.StartupPath;    // 현재 디렉토리.
        private string mClient_Target_Directory = string.Empty;         // 실제 디렉토리 
        private string mClient_ImageDirectory = string.Empty;           // 클라이언트 이미지 디렉토리.
        private string mFileExtension = string.Empty;                   // 확장자명.

        private bool mIsGetInformationFTP = false;                      // FTP 정보 상태.
        private bool mIsFormLoad = false;                               // NEWMOVE 이벤트 제어.

        #endregion;

        #region ----- initialize -----
        public HRMF0201(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.DoubleBuffered = true;
            this.Visible = false;
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mIsFormLoad = false;
        }
        #endregion
                
        #region ----- DATA FIND ------
        
        private void SEARCH_DB()
        {// 데이터 조회.
            idaPERSON.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idaPERSON.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            idaPERSON.Fill();
        
            igrPERSON_INFO.Focus();
        }

        private void isSearch_Sub_DB()
        {// 서브 tab 조회.
            if (iedPERSON_ID.EditValue == null)
            {
                return;
            }
            idaBODY.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaBODY.Fill();

            idaARMY.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaARMY.Fill();

            idaFAMILY.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idaFAMILY.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
            idaFAMILY.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaFAMILY.Fill();

            idaHISTORY.SetSelectParamValue("W_HISTORY_HEADER_ID", DBNull.Value);
            idaHISTORY.SetSelectParamValue("W_DEPT_ID", DBNull.Value);
            idaHISTORY.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaHISTORY.Fill();

            idaCAREER.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaCAREER.Fill();

            idaSCHOLARSHIP.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaSCHOLARSHIP.Fill();

            idaEDUCATION.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaEDUCATION.Fill();

            idaRESULT.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaRESULT.Fill();

            idaLICENSE.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaLICENSE.Fill();

            idaFOREIGN_LANGUAGE.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaFOREIGN_LANGUAGE.Fill();

            idaREWARD_PUNISHMENT.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaREWARD_PUNISHMENT.Fill();

            idaREFERENCE.SetSelectParamValue("W_PERSON_ID", iedPERSON_ID.EditValue);
            idaREFERENCE.Fill();

        }
        #endregion

        #region ----- Data validate -----
        private bool isPerson_ID_Validate()
        {// 사원번호 존재 여부 체크.
            bool ibReturn_Value = false;
            if (iedPERSON_ID.EditValue == null)
            {
                ibReturn_Value = false;
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);  // 사원정보는 필수.
            }
            else
            {
                ibReturn_Value = true;
            }
            return ibReturn_Value;
        }

        #endregion

        #region ----- 생년월일 생성 -----

        private DateTime BIRTHDAY(object pREPRE_NUM)
        {
            DateTime mBIRTHDAY;

            string mSex_Type = pREPRE_NUM.ToString().Substring(7, 1);
            if (mSex_Type == "1".ToString() || mSex_Type == "2".ToString() || mSex_Type == "5".ToString() || mSex_Type == "6".ToString())
            {
                mBIRTHDAY = DateTime.Parse("19" + pREPRE_NUM.ToString().Substring(0, 2)
                                                    + "-".ToString()
                                                    + pREPRE_NUM.ToString().Substring(2, 2)
                                                    + "-".ToString()
                                                    + pREPRE_NUM.ToString().Substring(4, 2));
            }
            else
            {
                mBIRTHDAY = DateTime.Parse("20" + pREPRE_NUM.ToString().Substring(0, 2)
                                                    + "-".ToString()
                                                    + pREPRE_NUM.ToString().Substring(2, 2)
                                                    + "-".ToString()
                                                    + pREPRE_NUM.ToString().Substring(4, 2));
            }
            return mBIRTHDAY;
        }

        #endregion

        #region ----- 주민번호 체크 ------

        private void iedREPRE_NUM_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (string.IsNullOrEmpty(iedREPRE_NUM.EditValue.ToString()))
            {
                return;
            }
            // 전호수 주석 : '-' 입력 체크 안함. 단, DB에서 자릿수 검증후 '-' 자동 입력 처리.
            //if (iedREPRE_NUM.EditValue.ToString().IndexOf("-") == -1)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10092"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //}

            string isReturnValue = null;
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", iedREPRE_NUM.EditValue);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            iedSEX_TYPE.EditValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_SEX_TYPE");
            if (isReturnValue == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
            if (string.IsNullOrEmpty(iedSEX_TYPE.EditValue.ToString()))
            {
                iedSEX_NAME.EditValue = null;
                iedSEX_TYPE.EditValue = null;
                return;
            }
            idcSEX_TYPE.OraProcedure = "CODE_NAME";
            idcSEX_TYPE.SetCommandParamValue("W_GROUP_CODE", "SEX_TYPE");
            idcSEX_TYPE.SetCommandParamValue("W_CODE", iedSEX_TYPE.EditValue);
            idcSEX_TYPE.ExecuteNonQuery();
            iedSEX_NAME.EditValue = idcSEX_TYPE.GetCommandParamValue("O_RETURN_VALUE").ToString();

            if (iString.ISNull(iedBIRTHDAY.EditValue) == string.Empty)
            {// 생년월일이 기존에 없을 경우 자동 설정.                
                string mSex_Type = iedREPRE_NUM.EditValue.ToString().Replace("-", "").Substring(6, 1);
                if (mSex_Type == "1".ToString() || mSex_Type == "2".ToString() || mSex_Type == "5".ToString() || mSex_Type == "6".ToString())
                {
                    iedBIRTHDAY.EditValue = DateTime.Parse("19" + iedREPRE_NUM.EditValue.ToString().Substring(0, 2)
                                                        + "-".ToString()
                                                        + iedREPRE_NUM.EditValue.ToString().Substring(2, 2)
                                                        + "-".ToString()
                                                        + iedREPRE_NUM.EditValue.ToString().Substring(4, 2));
                }
                else
                {
                    iedBIRTHDAY.EditValue = DateTime.Parse("20" + iedREPRE_NUM.EditValue.ToString().Substring(0, 2)
                                                        + "-".ToString()
                                                        + iedREPRE_NUM.EditValue.ToString().Substring(2, 2)
                                                        + "-".ToString()
                                                        + iedREPRE_NUM.EditValue.ToString().Substring(4, 2));
                }
                // 음양구분.
                idcCOMMON_W.SetCommandParamValue("W_GROUP_CODE", "BIRTHDAY_TYPE");
                idcCOMMON_W.SetCommandParamValue("W_WHERE", " 1 = 1 ");
                idcCOMMON_W.ExecuteNonQuery();
                iedBIRTHDAY_TYPE_NAME.EditValue = idcCOMMON_W.GetCommandParamValue("O_CODE_NAME");
                iedBIRTHDAY_TYPE.EditValue = idcCOMMON_W.GetCommandParamValue("O_CODE");
            }
        }

        private string FAMILY_REPRE_NUM_CHECK(object pREPRE_NUM)
        {
            string isReturnValue = "N".ToString();
            if (iString.ISNull(pREPRE_NUM) == String.Empty)
            {
                return isReturnValue;
            }
            // 전호수 주석 : '-' 입력 체크 안함. 단, DB에서 자릿수 검증후 '-' 자동 입력 처리.
            //if (pREPRE_NUM.ToString().IndexOf("-") == -1)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10092"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return isReturnValue;
            //}
                        
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", pREPRE_NUM);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            return isReturnValue;            
        }

        private void iedR_GUAR_REPRE_NUM1_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            string isReturnValue = null;
            if (iString.ISNull(iedR_GUAR_REPRE_NUM1.EditValue) == String.Empty)
            {
                return;
            }
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", iedR_GUAR_REPRE_NUM1.EditValue);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            if (isReturnValue == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
        }

        private void iedR_GUAR_REPRE_NUM2_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            string isReturnValue = null;
            if (iString.ISNull(iedR_GUAR_REPRE_NUM2.EditValue) == String.Empty)
            {
                return;
            }
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", iedR_GUAR_REPRE_NUM2.EditValue);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            if (isReturnValue == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
        }
        
        #endregion
        
        #region  ------ Property / Method -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            iedCORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            iedCORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, string P_CODE_NAME, String P_USABLE_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", P_CODE_NAME);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        private void isSetAddressParameter(object pAddress)
        {
            ildADDRESS.SetLookupParamValue("W_ADDRESS", pAddress);
        }

        private void Init_Person_Insert()
        {// 인사정보 insert.
            //iedORI_JOIN_DATE.EditValue = iDate.ISGetDate();
            //iedJOIN_DATE.EditValue = iDate.ISGetDate();
            iedNAME.Focus();
        }

        #endregion

        #region --- Application_MainButtonClick ---

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaPERSON.IsFocused)
                    {// 기본정보
                        idaPERSON.AddOver();
                        Init_Person_Insert();
                    }
                    else if (idaBODY.IsFocused)
                    {// 신체사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaBODY.AddOver();
                        iedB_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                    else if (idaARMY.IsFocused)
                    {// 병역사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaARMY.AddOver();
                        iedA_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                    else if (idaFAMILY.IsFocused)
                    {// 가족사항
                        if (isPerson_ID_Validate() == false)
                        {   
                            return;
                        }
                        idaFAMILY.AddOver();
                        igrFAMILY.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaCAREER.IsFocused)
                    {// 경력사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaCAREER.AddOver();
                        igrCAREER.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaSCHOLARSHIP.IsFocused)
                    {// 학력사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaSCHOLARSHIP.AddOver();
                        igrSCHOLARSHIP.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaEDUCATION.IsFocused)
                    {// 교육사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaEDUCATION.AddOver();
                        igrEDUCATION.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaRESULT.IsFocused)
                    {// 평가사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaRESULT.AddOver();
                        igrRESULT.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaLICENSE.IsFocused)
                    {// 자격사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaLICENSE.AddOver();
                        igrLICENSE.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaFOREIGN_LANGUAGE.IsFocused)
                    {// 어학사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaFOREIGN_LANGUAGE.AddOver();
                        igrFOREIGN_LANGUAGE.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaREWARD_PUNISHMENT.IsFocused)
                    {// 상벌사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaREWARD_PUNISHMENT.AddOver();
                        igrREWARD_PUNISHMENT.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaREFERENCE.IsFocused)
                    {// 신원보증
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaREFERENCE.AddOver();
                        iedR_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaPERSON.IsFocused)
                    {// 기본정보
                        idaPERSON.AddUnder();
                        Init_Person_Insert();
                    }
                    else if (idaBODY.IsFocused)
                    {// 신체사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaBODY.AddUnder();
                        iedB_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                    else if (idaARMY.IsFocused)
                    {// 병역사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaARMY.AddUnder();
                        iedA_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                    else if (idaFAMILY.IsFocused)
                    {// 가족사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaFAMILY.AddUnder();
                        igrFAMILY.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaCAREER.IsFocused)
                    {// 경력사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaCAREER.AddUnder();
                        igrCAREER.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaSCHOLARSHIP.IsFocused)
                    {// 학력사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaSCHOLARSHIP.AddUnder();
                        igrSCHOLARSHIP.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaEDUCATION.IsFocused)
                    {// 교육사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaEDUCATION.AddUnder();
                        igrEDUCATION.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaRESULT.IsFocused)
                    {// 평가사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaRESULT.AddUnder();
                        igrRESULT.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaLICENSE.IsFocused)
                    {// 자격사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaLICENSE.AddUnder();
                        igrLICENSE.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaFOREIGN_LANGUAGE.IsFocused)
                    {// 어학사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaFOREIGN_LANGUAGE.AddUnder();
                        igrFOREIGN_LANGUAGE.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaREWARD_PUNISHMENT.IsFocused)
                    {// 상벌사항
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaREWARD_PUNISHMENT.AddUnder();
                        igrREWARD_PUNISHMENT.SetCellValue("PERSON_ID", iedPERSON_ID.EditValue);      //사원id copy
                    }
                    else if (idaREFERENCE.IsFocused)
                    {// 신원보증
                        if (isPerson_ID_Validate() == false)
                        {
                            return;
                        }
                        idaREFERENCE.AddUnder();
                        iedR_PERSON_ID.EditValue = iedPERSON_ID.EditValue;      //사원id copy
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    try
                    {
                        idaPERSON.Update();
                    }
                    catch
                    {

                    }
                    //if (idaPERSON.IsFocused)
                    //{// 기본정보
                    //    idaPERSON.Update();
                    //}
                    //else if (idaBODY.IsFocused)
                    //{// 신체사항
                    //    idaBODY.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaBODY.Update();
                    //}
                    //else if (idaARMY.IsFocused)
                    //{// 병역사항
                    //    idaARMY.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaARMY.Update();
                    //}
                    //else if (idaFAMILY.IsFocused)
                    //{// 가족사항
                    //    idaFAMILY.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaFAMILY.Update();
                    //}
                    //else if (idaCAREER.IsFocused)
                    //{// 경력사항
                    //    idaCAREER.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaCAREER.Update();
                    //}
                    //else if (idaSCHOLARSHIP.IsFocused)
                    //{// 학력사항
                    //    idaSCHOLARSHIP.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaSCHOLARSHIP.Update();
                    //}
                    //else if (idaEDUCATION.IsFocused)
                    //{// 교육사항
                    //    idaEDUCATION.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaEDUCATION.Update();
                    //}
                    //else if (idaRESULT.IsFocused)
                    //{// 평가사항
                    //    idaRESULT.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaRESULT.Update();
                    //}
                    //else if (idaLICENSE.IsFocused)
                    //{// 자격사항
                    //    idaLICENSE.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaLICENSE.Update();
                    //}
                    //else if (idaFOREIGN_LANGUAGE.IsFocused)
                    //{// 어학사항
                    //    idaFOREIGN_LANGUAGE.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaFOREIGN_LANGUAGE.Update();
                    //}
                    //else if (idaREWARD_PUNISHMENT.IsFocused)
                    //{// 상벌사항
                    //    idaREWARD_PUNISHMENT.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaREWARD_PUNISHMENT.Update();
                    //}
                    //else if (idaREFERENCE.IsFocused)
                    //{// 신원보증
                    //    idaREFERENCE.SetInsertParamValue("P_PERSON_ID", iedPERSON_ID.EditValue);
                    //    idaREFERENCE.Update();
                    //}
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPERSON.IsFocused)
                    {// 기본정보
                        idaPERSON.Cancel();
                    }
                    else if (idaBODY.IsFocused)
                    {// 신체사항
                        idaBODY.Cancel();
                    }
                    else if (idaARMY.IsFocused)
                    {// 병역사항
                        idaARMY.Cancel();
                    }
                    else if (idaFAMILY.IsFocused)
                    {// 가족사항
                        idaFAMILY.Cancel();
                    }
                    else if (idaCAREER.IsFocused)
                    {// 경력사항
                        idaCAREER.Cancel();
                    }
                    else if (idaSCHOLARSHIP.IsFocused)
                    {// 학력사항
                        idaSCHOLARSHIP.Cancel();
                    }
                    else if (idaEDUCATION.IsFocused)
                    {// 교육사항
                        idaEDUCATION.Cancel();
                    }
                    else if (idaRESULT.IsFocused)
                    {// 평가사항
                        idaRESULT.Cancel();
                    }
                    else if (idaLICENSE.IsFocused)
                    {// 자격사항
                        idaLICENSE.Cancel();
                    }
                    else if (idaFOREIGN_LANGUAGE.IsFocused)
                    {// 어학사항
                        idaFOREIGN_LANGUAGE.Cancel();
                    }
                    else if (idaREWARD_PUNISHMENT.IsFocused)
                    {// 상벌사항
                        idaREWARD_PUNISHMENT.Cancel();
                    }
                    else if (idaREFERENCE.IsFocused)
                    {// 신원보증
                        idaREFERENCE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPERSON.IsFocused)
                    {// 기본정보
                        idaPERSON.Delete();
                    }
                    else if (idaBODY.IsFocused)
                    {// 신체사항
                        idaBODY.Delete();
                    }
                    else if (idaARMY.IsFocused)
                    {// 병역사항
                        idaARMY.Delete();
                    }
                    else if (idaFAMILY.IsFocused)
                    {// 가족사항
                        idaFAMILY.Delete();
                    }
                    else if (idaCAREER.IsFocused)
                    {// 경력사항
                        idaCAREER.Delete();
                    }
                    else if (idaSCHOLARSHIP.IsFocused)
                    {// 학력사항
                        idaSCHOLARSHIP.Delete();
                    }
                    else if (idaEDUCATION.IsFocused)
                    {// 교육사항
                        idaEDUCATION.Delete();
                    }
                    else if (idaRESULT.IsFocused)
                    {// 평가사항
                        idaRESULT.Delete();
                    }
                    else if (idaLICENSE.IsFocused)
                    {// 자격사항
                        idaLICENSE.Delete();
                    }
                    else if (idaFOREIGN_LANGUAGE.IsFocused)
                    {// 어학사항
                        idaFOREIGN_LANGUAGE.Delete();
                    }
                    else if (idaREWARD_PUNISHMENT.IsFocused)
                    {// 상벌사항
                        idaREWARD_PUNISHMENT.Delete();
                    }
                    else if (idaREFERENCE.IsFocused)
                    {// 신원보증
                        idaREFERENCE.Delete();
                    }
                }
            }
        }

        #endregion

        #region ----- Form Event -----
        private void HRMF0201_Load(object sender, EventArgs e)
        {
            this.Visible = true;
            mIsFormLoad = true;

            idaPERSON.FillSchema();            
        }

        private void HRMF0201_Shown(object sender, EventArgs e)
        {
            DefaultCorporation();
            mIsGetInformationFTP = GetInfomationFTP();
            if (mIsGetInformationFTP == true)
            {
                MakeDirectory();
                FTPInitializtion();
            }
            mIsFormLoad = false;
        }
        
        private void HRMF0201_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (mIsGetInformationFTP == true)
            {
                System.IO.DirectoryInfo vClient_ImageDirectory = new System.IO.DirectoryInfo(mClient_ImageDirectory);
                if (vClient_ImageDirectory.Exists == true)
                {
                    try
                    {
                        vClient_ImageDirectory.Delete(true);
                    }
                    catch
                    {
                    }
                }
            }
        }

        private void iedORI_JOIN_DATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(iedJOIN_DATE.EditValue) == string.Empty)
            {
                iedJOIN_DATE.EditValue = iedORI_JOIN_DATE.EditValue;
            }
            if (iString.ISNull(iedPAY_DATE.EditValue) == string.Empty)
            {
                iedPAY_DATE.EditValue = iedORI_JOIN_DATE.EditValue;
            }
        }

        private void iedJOIN_DATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(iedPAY_DATE.EditValue) == string.Empty)
            {
                iedPAY_DATE.EditValue = iedJOIN_DATE.EditValue;
            }
        }

        #endregion

        #region ----- Adapter Event -----

        private bool isDelete_Validate(string pTabPage)
        {
            bool ibReturn_Value = false;
            if (pTabPage == "itpPERSON_MASTER")
            {
                ibReturn_Value = false;
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);   // 사원정보 삭제 불가.
            }
            return ibReturn_Value;
        }

// 인사기본 검증---------------------------------------------------------------
        private void idaPERSON_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {// Added 상태가 아닐경우 체크.
                if (e.Row["PERSON_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (string.IsNullOrEmpty(e.Row["PERSON_NUM"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (string.IsNullOrEmpty(e.Row["NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Name(성명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["OPERATING_UNIT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Operating Unit(사업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["DEPT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["NATION_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=국가"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_CLASS_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Class(직군)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job(직종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["POST_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Post(직위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["OCPT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ocpt(직무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ABIL_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Abil(직책)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["REPRE_NUM"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Repre Num(주민번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["SEX_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Sex Type(성별)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOIN_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=입사구분"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ORI_JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ori Join Date(그룹입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join Date(입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) != string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10170"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) == string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) != string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10171"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["DIR_INDIR_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Dir/InDir Type(직간접 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["EMPLOYE_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Employee Status(재직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_CATEGORY_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Category(직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["FLOOR_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Floor(작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPERSON_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Person Infomation(인사정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 신체사항 검증---------------------------------------------------------------
        private void idaBODY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBODY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }


// 병역사항 검증---------------------------------------------------------------
        private void idaARMY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_KIND_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Kind(군별)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_STATUS_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Status(역종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_GRADE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Grade(계급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaARMY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 가족사항 검증---------------------------------------------------------------
        private void idaFAMILY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["FAMILY_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Family Name(성명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RELATION_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Family Relation(가족 관계)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REPRE_NUM"]) != string.Empty)
            {
                if (FAMILY_REPRE_NUM_CHECK(e.Row["REPRE_NUM"]) == "N".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaFAMILY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 경력사항 검증---------------------------------------------------------------
        private void idaCAREE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["COMPANY_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(회사명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (String.IsNullOrEmpty(e.Row["DEPT_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join Date(입사일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Retire Date(퇴사일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaCAREE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 학력사항 검증---------------------------------------------------------------
        private void idaSCHOLARSHIP_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SCHOLARSHIP_TYPE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Scholarship Type(학력타입)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["GRADUATION_TYPE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Graduation Type(졸업구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ADMISSION_YYYYMM"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Admission Date(입학일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
            if (string.IsNullOrEmpty(e.Row["SCHOOL_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=School Name(학교명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaSCHOLARSHIP_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 교육사항 검증---------------------------------------------------------------
        private void idaEDUCATION_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Education Start Date(교육 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["EDU_CURRICULUM"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Education Curriculum(교육명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaEDUCATION_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 평가사항 검증---------------------------------------------------------------
        private void idaRESULT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["RESULT_YYYY"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Result Year Month(평가 년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaRESULT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        
// 자격사항 검증---------------------------------------------------------------
        private void idaLICENSE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["LICENSE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=License Kind(자격증 종류)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["LICENSE_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=License Get Date(취득일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaLICENSE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 어학사항 검증---------------------------------------------------------------
        private void idaFOREIGN_LANGUAGE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["EXAM_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Exam Date(응시 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["EXAM_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Exam Kind(검정 종류)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFOREIGN_LANGUAGE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 상벌사항 검증---------------------------------------------------------------
        private void idaREWARD_PUNISHMENT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["RP_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Type(상벌구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Kind(상벌 항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Date(상벌 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_ORG"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Organization(시행처"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaREWARD_PUNISHMENT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 신원보증 검증---------------------------------------------------------------
        private void idaREFERENCE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {// 신원보증
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFERENCE_TYPE"].ToString() == "I".ToString())
            {
                if (string.IsNullOrEmpty(e.Row["INSUR_NAME"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Insurance Name(보험명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["INSUR_START_DATE"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Insurance Start Date(보험시작일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            else if (e.Row["REFERENCE_TYPE"].ToString() == "P".ToString())
            {
                if (string.IsNullOrEmpty(e.Row["GUAR_NAME1"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Name(보증인)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (string.IsNullOrEmpty(e.Row["GUAR_REPRE_NUM1"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Repre Num(주민번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["GUAR_RELATION_ID1"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Relation(보증인 관계)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Kind(보증유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
        }

        private void idaREFERENCE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ----- idaPERSON NewRowMoved Event -----

        private void idaPERSON_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (mIsFormLoad == true)
            {
                return;
            }

            isViewItemImage();
        }

        #endregion

        #region ----- lookup adapter event -----

        private void ilaYEAR_STR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string Start_YEAR = "2000";
            string End_YEAR = DateTime.Today.AddYears(1).Year.ToString();

            ildYEAR_STR.SetLookupParamValue("W_START_YEAR", Start_YEAR);
            ildYEAR_STR.SetLookupParamValue("W_END_YEAR", End_YEAR);
        }

        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaCORP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedCORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            ildDEPT.SetLookupParamValue("W_CORP_ID", iedCORP_ID_0.EditValue);
            ildDEPT.SetLookupParamValue("W_DEPT_LEVEL", DBNull.Value);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EMPLOYE_TYPE", null, "N");
        }

        private void ilaEMPLOYE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EMPLOYE_TYPE", null, "Y");
        }

        private void ilaOPERATING_UNIT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedCORP_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10011"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            ildOPERATING_UNIT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedCORP_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            ildDEPT.SetLookupParamValue("W_CORP_ID", iedCORP_ID.EditValue);
            ildDEPT.SetLookupParamValue("W_DEPT_LEVEL", DBNull.Value);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaARMY_KIND_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ARMY_KIND", null, "Y");
        }

        private void ilaARMY_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ARMY_STATUS", null, "Y");
        }

        private void ilaARMY_GRADE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ARMY_GRADE", null, "Y");
        }

        private void ilaARMY_END_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ARMY_END_TYPE", null, "Y");
        }

        private void ilaEXCEPTION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EXCEPTION", null, "Y");
        }

        private void ilaEXCEPTION_LICENSE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("LICENSE", null, "Y");
        }

        private void ilaEXCEPTION_GRADE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("LICENSE_GRADE", null, "Y");
        }
                
        private void ilaDIR_INDIR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("DIR_INDIR_TYPE", null, "Y");
        }

        private void ilaOCPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("OCPT", null, "Y");
        }

        private void ilaJOB_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB_CLASS", null, "Y");
        }

        private void ilaJOB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB", null, "Y");
        }

        private void ilaABIL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ABIL", null, "Y");
        }

        private void ilaPOST_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("POST", null, "Y");
        }

        private void ilaPAY_GRADE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("PAY_GRADE", null, "Y");
        }

        private void ilaBIRTHDAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("BIRTHDAY_TYPE", null, "Y");
        }

        private void ilaNATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("NATION", null, "Y");
        }

        private void ilaWORK_AREA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("WORK_AREA", null, "Y");
        }

        private void ilaEND_SCH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("END_SCH", null, "Y");
        }

        private void ilaJOIN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOIN", null, "Y");
        }

        private void ilaJOIN_ROUTE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOIN_ROUTE", null, "Y");
        }

        private void ilaRETIRE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RETIRE", null, "Y");
        }

        private void ilaJOB_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOB_CATEGORY", null, "Y");
        }

        private void ilaWORK_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("WORK_TYPE", null, "Y");
        }

        private void ilaFLOOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("FLOOR", null, "Y");
        }

        private void ilaLEGAL_ADDRESS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(iedLEGAL_ZIP_CODE.EditValue);
        }

        private void ilaLEGAL_ADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaPRSN_ADDRESS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(iedPRSN_ZIP_CODE.EditValue);
        }

        private void ilaPRSN_ADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaLIVE_ADDRESS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(iedLIVE_ZIP_CODE.EditValue);
        }

        private void ilaLIVE_ADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaRELIGION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RELIGION", null, "Y");
        }

        private void ilaBLOOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("BLOOD_TYPE", null, "Y");
        }

        private void ilaACHRO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("ACHRO", null, "Y");
        }

        private void ilaDISABLED_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("DISABLED", null, "Y");
        }

        private void ilaBOHUN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("BOHUN", null, "Y");
        }

        private void ilaF_RELATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RELATION", null, "Y");
        }

        private void ilaF_BIRTHDAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("BIRTHDAY_TYPE", null, "Y");
        }

        private void ilaF_END_SCH_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("END_SCH", null, "Y");
        }

        private void ilaCAREER_ADDRESS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(igrCAREER.GetCellValue("ZIP_CODE"));
        }

        private void ilaCAREER_ADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaSCHOLARSHIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("SCHOLARSHIP_TYPE", null, "Y");
        }

        private void ilaGRADUATION_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("GRADUATION_TYPE", null, "Y");
        }

        private void ilaDEGREE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("DEGREE", null, "Y");
        }

        private void ilaLICENSE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("LICENSE", null, "Y");
        }

        private void ilaLICENSE_GRADE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("LICENSE_GRADE", null, "Y");
        }

        private void ilaEXAM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EXAM", null, "Y");
        }

        private void ilaLANGUAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("LANGUAGE", null, "Y");
        }

        private void ilaRP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RP_TYPE", null, "Y");
        }

        private void ilaRP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string W_WHERE = Convert.ToString(igrREWARD_PUNISHMENT.GetCellValue("RP_TYPE"));
            W_WHERE = String.Format("{0}{1}{2}", "HC.VALUE1 = '", W_WHERE, "' ");
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "RP");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", W_WHERE);
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaREFERENCE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("REFERENCE_TYPE", null, "Y");
        }

        private void ilaGUAR_RELATION_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RELATION", null, "Y");
        }

        private void ilaGUAR_RELATION_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("RELATION", null, "Y");
        }

        private void ilaREFERENCE_ADDRESS1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(iedR_GUAR_ZIP_CODE1.EditValue);
        }

        private void ilaREFERENCE_ADDRESS1_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaREFERENCE_ADDRESS2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetAddressParameter(iedR_GUAR_ZIP_CODE2.EditValue);
        }

        private void ilaREFERENCE_ADDRESS2_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }

        private void ilaADMISSION_YYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Add(DateTime.Today, 1000)));
        }

        private void ilaGRADUATION_YYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Add(DateTime.Today, 1000)));
        }

        private void ilaCOST_CENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOST_CENTER.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        #endregion

        #region ----- is View Item Image Method -----

        private void isViewItemImage()
        {
            if (mIsFormLoad == true)
            {
                return;
            }

            bool isView = false;
            string vDownLoadFile = string.Empty;

            string vPersonNumber = iedPERSON_NUM.EditValue as string;
            string vTargetFileName = string.Format("{0}{1}", vPersonNumber.ToUpper(), mFileExtension);

            bool isDown = DownLoadItem(vTargetFileName);
            if (isDown == true)
            {
                vDownLoadFile = string.Format("{0}\\{1}", mClient_ImageDirectory, vTargetFileName);
                isView = ImageView(vDownLoadFile);
            }
            else
            {
                ipbPERSON.ImageLocation = string.Empty;
            }
        }

        #endregion;

        #region ----- Make Directory ----

        private void MakeDirectory()
        {
            System.IO.DirectoryInfo vClient_ImageDirectory = new System.IO.DirectoryInfo(mClient_ImageDirectory);
            if (vClient_ImageDirectory.Exists == false) //있으면 True, 없으면 False
            {
                vClient_ImageDirectory.Create();
            }
        }

        #endregion;

        #region ----- Image View ----

        private bool ImageView(string pFileName)
        {
            bool isView = false;

            bool isExist = System.IO.File.Exists(pFileName);
            if (isExist == true)
            {
                ipbPERSON.ImageLocation = pFileName;
                isView = true;
            }

            return isView;
        }

        #endregion;

        #region ----- Get Information FTP Methods -----

        private bool GetInfomationFTP()
        {
            bool isGet = false;
            try
            {
                idcFTP_INFO.SetCommandParamValue("W_FTP_INFO_CODE", "101");
                idcFTP_INFO.ExecuteNonQuery();
                mImageFTP = new ItemImageInfomationFTP();

                mImageFTP.Host = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_IP"));
                mImageFTP.Port = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_PORT"));
                mImageFTP.UserID = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_USER_ID"));
                mImageFTP.Password = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_PASSWORD"));

                mFTP_Source_Directory = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_SOURCEPATH"));
                mClient_Target_Directory = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_CLIENT_TARGETPATH"));
                mFileExtension = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FILE_EXTENSION"));
                mClient_ImageDirectory = string.Format("{0}\\{1}", mClient_Base_Path, mClient_Target_Directory);

                Application.DoEvents();

                if (mImageFTP.Host != string.Empty)
                {
                    isGet = true;
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return isGet;
        }

        #endregion;

        #region ----- FTP Initialize -----

        private void FTPInitializtion()
        {
            mFileTransferAdv = new ISFileTransferAdv();
            mFileTransferAdv.Host = mImageFTP.Host;
            mFileTransferAdv.Port = mImageFTP.Port;
            mFileTransferAdv.UserId = mImageFTP.UserID;
            mFileTransferAdv.Password = mImageFTP.Password;
        }

        #endregion;

        #region ----- Image Upload Methods -----

        private bool UpLoadItem()
        {
            bool isUp = false;

            openFileDialog1.FileName = string.Format("*{0}", mFileExtension);
            openFileDialog1.Filter = string.Format("Image Files (*{0})|*{1}", mFileExtension, mFileExtension);
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    string vChoiceFileFullPath = openFileDialog1.FileName;
                    string vChoiceFilePath = vChoiceFileFullPath.Substring(0, vChoiceFileFullPath.LastIndexOf(@"\"));
                    string vChoiceFileName = vChoiceFileFullPath.Substring(vChoiceFileFullPath.LastIndexOf(@"\") + 1);

                    mFileTransferAdv.ShowProgress = true;
                    //--------------------------------------------------------------------------------

                    string vSourceFileName = vChoiceFileName;

                    string vTargetFileName = iedPERSON_NUM.EditValue as string;
                    vTargetFileName = string.Format("{0}{1}", vTargetFileName.ToUpper(), mFileExtension);

                    mFileTransferAdv.SourceDirectory = vChoiceFilePath;
                    mFileTransferAdv.SourceFileName = vSourceFileName;
                    mFileTransferAdv.TargetDirectory = mFTP_Source_Directory;
                    mFileTransferAdv.TargetFileName = vTargetFileName;

                    bool isUpLoad = mFileTransferAdv.Upload();

                    if (isUpLoad == true)
                    {
                        isUp = true;
                        bool isView = ImageView(vChoiceFileFullPath);
                    }
                    else
                    {
                    }
                }
                catch
                {
                }
            }
            System.IO.Directory.SetCurrentDirectory(mClient_Base_Path);
            return isUp;
        }

        private void ibtPERSON_PICTURE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (mIsGetInformationFTP == true)
            {
                UpLoadItem();
            }
        }

        #endregion;

        #region ----- Image Download Methods -----

        private bool DownLoadItem(string pFileName)
        {
            bool isDown = false;

            string vSourceDownLoadFile = string.Format("{0}\\{1}", mClient_ImageDirectory, pFileName);
            string vTargetDownLoadFile = string.Format("{0}\\_{1}", mClient_ImageDirectory, pFileName);

            string vBeforeSourceFileName = string.Format("{0}", pFileName);
            string vBeforeTargetFileName = string.Format("_{0}", pFileName);

            mFileTransferAdv.ShowProgress = false;
            //--------------------------------------------------------------------------------

            mFileTransferAdv.SourceDirectory = mFTP_Source_Directory;
            mFileTransferAdv.SourceFileName = vBeforeSourceFileName;
            mFileTransferAdv.TargetDirectory = mClient_ImageDirectory;
            mFileTransferAdv.TargetFileName = vBeforeTargetFileName;

            isDown = mFileTransferAdv.Download();

            if (isDown == true)
            {
                try
                {
                    System.IO.File.Delete(vSourceDownLoadFile);
                    System.IO.File.Move(vTargetDownLoadFile, vSourceDownLoadFile);

                    isDown = true;
                }
                catch
                {
                    try
                    {
                        System.IO.FileInfo vDownFileInfo = new System.IO.FileInfo(vTargetDownLoadFile);
                        if (vDownFileInfo.Exists == true)
                        {
                            try
                            {
                                System.IO.File.Delete(vTargetDownLoadFile);
                            }
                            catch
                            {
                                // ignore
                            }
                        }
                    }
                    catch
                    {
                        //ignore
                    }
                }
            }
            else
            {
                try
                {
                    System.IO.FileInfo vDownFileInfo = new System.IO.FileInfo(vTargetDownLoadFile);
                    if (vDownFileInfo.Exists == true)
                    {
                        try
                        {
                            System.IO.File.Delete(vTargetDownLoadFile);
                        }
                        catch
                        {
                            // ignore
                        }
                    }
                }
                catch
                {
                    //ignore
                }
            }

            return isDown;
        }

        #endregion;

        private void igrFAMILY_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrFAMILY.GetColumnToIndex("REPRE_NUM"))
            {
                object vRepre_Num;
                vRepre_Num = e.NewValue;
                if (iString.ISNull(vRepre_Num) == string.Empty)
                {
                    return;
                }
                if (FAMILY_REPRE_NUM_CHECK(vRepre_Num) == "N".ToString())
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10026"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);                    
                    return;
                }

                if (iString.ISNull(igrFAMILY.GetCellValue("BIRTHDAY")) == string.Empty)
                {
                    igrFAMILY.SetCellValue("BIRTHDAY", BIRTHDAY(vRepre_Num));
                }

                if (iString.ISNull(igrFAMILY.GetCellValue("BIRTHDAY_TYPE")) == string.Empty)
                {
                    // 음양구분.
                    idcCOMMON_W.SetCommandParamValue("W_GROUP_CODE", "BIRTHDAY_TYPE");
                    idcCOMMON_W.SetCommandParamValue("W_WHERE", " 1 = 1 ");
                    idcCOMMON_W.ExecuteNonQuery();
                    igrFAMILY.SetCellValue("BIRTHDAY_TYPE_NAME", idcCOMMON_W.GetCommandParamValue("O_CODE_NAME"));
                    igrFAMILY.SetCellValue("BIRTHDAY_TYPE", idcCOMMON_W.GetCommandParamValue("O_CODE"));
                }
            }
        }

        private void iedNAME_0_KeyUp(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                SEARCH_DB();
            }
        }

        //#region ----- Get Registry Customer Methods ----

        //private string GetRegistryCustomer()
        //{
        //    string vMessage = string.Empty;
        //    string vCustomer = "BH";

        //    //C:\Program Files\Flex_ERP_BH\Kor
        //    //string vWorkDirectory = "C:\\Program Files\\Flex_ERP_BH\\Kor";
        //    //string vWorkDirectory = "C:\\Program Files\\Flex_ERP_FC\\Kor";

        //    //-------------------------------------------------------------------
        //    string vWorkDirectory = System.Windows.Forms.Application.StartupPath;
        //    //-------------------------------------------------------------------

        //    int vCutLast1 = vWorkDirectory.LastIndexOf("\\");
        //    string vCutString = vWorkDirectory.Substring(0, vCutLast1);
        //    int vCutLast2 = vCutString.LastIndexOf("\\") + 1;
        //    int vLength = vCutLast1 - vCutLast2;
        //    string vCustomerString = vCutString.Substring(vCutLast2, vLength);

        //    string vFTPKey = string.Format(@"Software\{0}\{1}\{2}", "InfoSummit", vCustomerString, "FTP");
        //    Microsoft.Win32.RegistryKey vKey = Microsoft.Win32.Registry.LocalMachine;

        //    try
        //    {
        //        vKey = vKey.OpenSubKey(vFTPKey, true);

        //        vCustomer = vKey.GetValue("Customer").ToString();

        //        vKey.Close();
        //    }
        //    catch (System.Exception ex)
        //    {
        //        vMessage = ex.Message;
        //    }

        //    return vCustomer;
        //}

        //#endregion;
        
    }

    #region ----- User Make Class -----

    public class ItemImageInfomationFTP
    {
        #region ----- Variables -----

        private string mHost = string.Empty;
        private string mPort = string.Empty;
        private string mUserID = string.Empty;
        private string mPassword = string.Empty;

        #endregion;

        #region ----- Constructor -----

        public ItemImageInfomationFTP()
        {
        }

        public ItemImageInfomationFTP(string pHost, string pPort, string pUserID, string pPassword)
        {
            mHost = pHost;
            mPort = pPort;
            mUserID = pUserID;
            mPassword = pPassword;
        }

        #endregion;

        #region ----- Property -----

        public string Host
        {
            get
            {
                return mHost;
            }
            set
            {
                mHost = value;
            }
        }

        public string Port
        {
            get
            {
                return mPort;
            }
            set
            {
                mPort = value;
            }
        }

        public string UserID
        {
            get
            {
                return mUserID;
            }
            set
            {
                mUserID = value;
            }
        }

        public string Password
        {
            get
            {
                return mPassword;
            }
            set
            {
                mPassword = value;
            }
        }

        #endregion;
    }

    #endregion;
}