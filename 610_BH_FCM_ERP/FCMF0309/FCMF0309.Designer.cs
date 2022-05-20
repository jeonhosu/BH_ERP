namespace FCMF0309
{
    partial class FCMF0309
    {
        /// <summary>
        /// 필수 디자이너 변수입니다.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 사용 중인 모든 리소스를 정리합니다.
        /// </summary>
        /// <param name="disposing">관리되는 리소스를 삭제해야 하면 true이고, 그렇지 않으면 false입니다.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 디자이너에서 생성한 코드

        /// <summary>
        /// 디자이너 지원에 필요한 메서드입니다.
        /// 이 메서드의 내용을 코드 편집기로 수정하지 마십시오.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement3 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISOraColElement isOraColElement1 = new InfoSummit.Win.ControlAdv.ISOraColElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement1 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement2 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement3 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo oraConnectionInfo1 = new InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement2 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement1 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement4 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement5 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement6 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement7 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement8 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement9 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement10 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement11 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            this.DPR_PERIOD = new InfoSummit.Win.ControlAdv.ISEditAdv();
            this.isAppInterfaceAdv1 = new InfoSummit.Win.ControlAdv.ISAppInterfaceAdv(this.components);
            this.ilaPERIOD_NAME = new InfoSummit.Win.ControlAdv.ISLookupAdapter(this.components);
            this.ildPERIOD_NAME = new InfoSummit.Win.ControlAdv.ISLookupData(this.components);
            this.isOraConnection1 = new InfoSummit.Win.ControlAdv.ISOraConnection(this.components);
            this.isMessageAdapter1 = new InfoSummit.Win.ControlAdv.ISMessageAdapter(this.components);
            this.ibtSET_DPR = new InfoSummit.Win.ControlAdv.ISButton();
            this.ibtCANCEL_DPR = new InfoSummit.Win.ControlAdv.ISButton();
            this.idcDEPRECIATION_SET = new InfoSummit.Win.ControlAdv.ISDataCommand(this.components);
            this.idcDEPRECIATION_SET_CANCEL = new InfoSummit.Win.ControlAdv.ISDataCommand(this.components);
            this.SuspendLayout();
            // 
            // DPR_PERIOD
            // 
            this.DPR_PERIOD.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.DPR_PERIOD.ComboBoxValue = "";
            this.DPR_PERIOD.ComboData = null;
            this.DPR_PERIOD.CurrencyValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.DPR_PERIOD.DataAdapter = null;
            this.DPR_PERIOD.DataColumn = null;
            this.DPR_PERIOD.DateTimeValue = new System.DateTime(2011, 2, 22, 0, 0, 0, 0);
            this.DPR_PERIOD.DoubleValue = 0;
            this.DPR_PERIOD.EditValue = "";
            // 
            // FCMF0309
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(244)))), ((int)(((byte)(254)))));
            this.ClientSize = new System.Drawing.Size(448, 149);
            this.Controls.Add(this.ibtCANCEL_DPR);
            this.Controls.Add(this.ibtSET_DPR);
            this.Controls.Add(this.DPR_PERIOD);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "FCMF0309";
            this.Padding = new System.Windows.Forms.Padding(5);
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "감가상각비 계산";
            this.Load += new System.EventHandler(this.FCMF0309_Load);
            this.Shown += new System.EventHandler(this.FCMF0309_Shown);
            this.DPR_PERIOD.Location = new System.Drawing.Point(36, 41);
            this.DPR_PERIOD.LookupAdapter = this.ilaPERIOD_NAME;
            this.DPR_PERIOD.Name = "DPR_PERIOD";
            this.DPR_PERIOD.Nullable = true;
            this.DPR_PERIOD.NumberValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.DPR_PERIOD.PercentValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.DPR_PERIOD.PromptText = "감가상각 년월";
            isLanguageElement3.Default = "Period Name";
            isLanguageElement3.SiteName = null;
            isLanguageElement3.TL1_KR = "감가상각 년월";
            isLanguageElement3.TL2_CN = null;
            isLanguageElement3.TL3_VN = null;
            isLanguageElement3.TL4_JP = null;
            isLanguageElement3.TL5_XAA = null;
            this.DPR_PERIOD.PromptTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement3});
            this.DPR_PERIOD.PromptWidth = 150;
            this.DPR_PERIOD.Size = new System.Drawing.Size(300, 21);
            this.DPR_PERIOD.TabIndex = 0;
            this.DPR_PERIOD.TerritoryLanguage = InfoSummit.Win.ControlAdv.ISUtil.Enum.TerritoryLanguage.TL1_KR;
            this.DPR_PERIOD.TextValue = "";
            // 
            // isAppInterfaceAdv1
            // 
            this.isAppInterfaceAdv1.AppMainButtonClick += new InfoSummit.Win.ControlAdv.ISAppInterfaceAdv.ButtonEventHandler(this.isAppInterfaceAdv1_AppMainButtonClick);
            // 
            // ilaPERIOD_NAME
            // 
            isOraColElement1.DataColumn = "YYYYMM";
            isOraColElement1.DataOrdinal = 0;
            isOraColElement1.DataType = "System.String";
            isOraColElement1.HeaderPrompt = "Period Name";
            isOraColElement1.LastValue = null;
            isOraColElement1.MemberControl = this.DPR_PERIOD;
            isOraColElement1.MemberValue = "EditValue";
            isOraColElement1.Nullable = null;
            isOraColElement1.Ordinal = 0;
            isOraColElement1.RelationKeyColumn = null;
            isOraColElement1.ReturnParameter = null;
            isOraColElement1.TL1_KR = "년월";
            isOraColElement1.TL2_CN = null;
            isOraColElement1.TL3_VN = null;
            isOraColElement1.TL4_JP = null;
            isOraColElement1.TL5_XAA = null;
            isOraColElement1.Visible = 1;
            isOraColElement1.Width = 100;
            this.ilaPERIOD_NAME.LookupColElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraColElement[] {
            isOraColElement1});
            this.ilaPERIOD_NAME.LookupData = this.ildPERIOD_NAME;
            this.ilaPERIOD_NAME.LookupSize = new System.Drawing.Size(175, 340);
            this.ilaPERIOD_NAME.SelectLookupSize = InfoSummit.Win.ControlAdv.ISUtil.Enum.SelectLookupSize.Custom;
            this.ilaPERIOD_NAME.PrePopupShow += new InfoSummit.Win.ControlAdv.ISLookupAdapter.PopupShowHandler(this.ilaPERIOD_NAME_PrePopupShow);
            // 
            // ildPERIOD_NAME
            // 
            isOraParamElement1.Direction = System.Data.ParameterDirection.Output;
            isOraParamElement1.MemberControl = null;
            isOraParamElement1.MemberValue = null;
            isOraParamElement1.OraDbTypeString = "REF CURSOR";
            isOraParamElement1.OraType = System.Data.OracleClient.OracleType.Cursor;
            isOraParamElement1.ParamName = "P_CURSOR";
            isOraParamElement1.Size = 0;
            isOraParamElement1.SourceColumn = null;
            isOraParamElement2.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement2.MemberControl = null;
            isOraParamElement2.MemberValue = null;
            isOraParamElement2.OraDbTypeString = "VARCHAR2";
            isOraParamElement2.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement2.ParamName = "W_START_YYYYMM";
            isOraParamElement2.Size = 7;
            isOraParamElement2.SourceColumn = null;
            isOraParamElement3.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement3.MemberControl = null;
            isOraParamElement3.MemberValue = null;
            isOraParamElement3.OraDbTypeString = "VARCHAR2";
            isOraParamElement3.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement3.ParamName = "W_END_YYYYMM";
            isOraParamElement3.Size = 7;
            isOraParamElement3.SourceColumn = null;
            this.ildPERIOD_NAME.LookupParamElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraParamElement[] {
            isOraParamElement1,
            isOraParamElement2,
            isOraParamElement3});
            this.ildPERIOD_NAME.OraConnection = this.isOraConnection1;
            this.ildPERIOD_NAME.OraOwner = "APPS";
            this.ildPERIOD_NAME.OraPackage = "EAPP_CALENDAR_G";
            this.ildPERIOD_NAME.OraProcedure = "LU_CALENDAR_YYYYMM";
            // 
            // isOraConnection1
            // 
            this.isOraConnection1.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.isOraConnection1.OraConnectionInfo = oraConnectionInfo1;
            this.isOraConnection1.OraHost = "211.168.59.26";
            this.isOraConnection1.OraPassword = "infoflex";
            this.isOraConnection1.OraPort = "1521";
            this.isOraConnection1.OraServiceName = "FXCDB";
            this.isOraConnection1.OraUserId = "APPS";
            // 
            // isMessageAdapter1
            // 
            this.isMessageAdapter1.OraConnection = this.isOraConnection1;
            // 
            // ibtSET_DPR
            // 
            this.ibtSET_DPR.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.ibtSET_DPR.ButtonText = "Set Depreciation";
            isLanguageElement2.Default = "Set Depreciation";
            isLanguageElement2.SiteName = null;
            isLanguageElement2.TL1_KR = "감가상각 계산";
            isLanguageElement2.TL2_CN = null;
            isLanguageElement2.TL3_VN = null;
            isLanguageElement2.TL4_JP = null;
            isLanguageElement2.TL5_XAA = null;
            this.ibtSET_DPR.ButtonTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement2});
            this.ibtSET_DPR.Location = new System.Drawing.Point(160, 94);
            this.ibtSET_DPR.Name = "ibtSET_DPR";
            this.ibtSET_DPR.Size = new System.Drawing.Size(131, 34);
            this.ibtSET_DPR.TabIndex = 1;
            this.ibtSET_DPR.ButtonClick += new InfoSummit.Win.ControlAdv.ISButton.ClickEventHandler(this.ibtSET_DPR_ButtonClick);
            // 
            // ibtCANCEL_DPR
            // 
            this.ibtCANCEL_DPR.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.ibtCANCEL_DPR.ButtonText = "Cancel Depreciation";
            isLanguageElement1.Default = "Cancel Depreciation";
            isLanguageElement1.SiteName = null;
            isLanguageElement1.TL1_KR = "감가상각 취소";
            isLanguageElement1.TL2_CN = null;
            isLanguageElement1.TL3_VN = null;
            isLanguageElement1.TL4_JP = null;
            isLanguageElement1.TL5_XAA = null;
            this.ibtCANCEL_DPR.ButtonTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement1});
            this.ibtCANCEL_DPR.Location = new System.Drawing.Point(297, 94);
            this.ibtCANCEL_DPR.Name = "ibtCANCEL_DPR";
            this.ibtCANCEL_DPR.Size = new System.Drawing.Size(131, 34);
            this.ibtCANCEL_DPR.TabIndex = 2;
            this.ibtCANCEL_DPR.ButtonClick += new InfoSummit.Win.ControlAdv.ISButton.ClickEventHandler(this.ibtCANCEL_DPR_ButtonClick);
            // 
            // idcDEPRECIATION_SET
            // 
            isOraParamElement4.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement4.MemberControl = this.DPR_PERIOD;
            isOraParamElement4.MemberValue = "EditValue";
            isOraParamElement4.OraDbTypeString = "VARCHAR2";
            isOraParamElement4.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement4.ParamName = "P_PERIOD_NAME";
            isOraParamElement4.Size = 0;
            isOraParamElement4.SourceColumn = null;
            isOraParamElement5.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement5.MemberControl = null;
            isOraParamElement5.MemberValue = null;
            isOraParamElement5.OraDbTypeString = "NUMBER";
            isOraParamElement5.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement5.ParamName = "P_ASSET_ID";
            isOraParamElement5.Size = 22;
            isOraParamElement5.SourceColumn = null;
            isOraParamElement6.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement6.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement6.MemberValue = "SOB_ID";
            isOraParamElement6.OraDbTypeString = "NUMBER";
            isOraParamElement6.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement6.ParamName = "P_SOB_ID";
            isOraParamElement6.Size = 22;
            isOraParamElement6.SourceColumn = null;
            isOraParamElement7.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement7.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement7.MemberValue = "ORG_ID";
            isOraParamElement7.OraDbTypeString = "NUMBER";
            isOraParamElement7.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement7.ParamName = "P_USER_ID";
            isOraParamElement7.Size = 22;
            isOraParamElement7.SourceColumn = null;
            this.idcDEPRECIATION_SET.CommandParamElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraParamElement[] {
            isOraParamElement4,
            isOraParamElement5,
            isOraParamElement6,
            isOraParamElement7});
            this.idcDEPRECIATION_SET.DataTransaction = null;
            this.idcDEPRECIATION_SET.OraConnection = this.isOraConnection1;
            this.idcDEPRECIATION_SET.OraOwner = "APPS";
            this.idcDEPRECIATION_SET.OraPackage = "FI_ASSET_DPR_HISTORY_SET_G";
            this.idcDEPRECIATION_SET.OraProcedure = "DEPRECIATION_SET";
            // 
            // idcDEPRECIATION_SET_CANCEL
            // 
            isOraParamElement8.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement8.MemberControl = this.DPR_PERIOD;
            isOraParamElement8.MemberValue = "EditValue";
            isOraParamElement8.OraDbTypeString = "VARCHAR2";
            isOraParamElement8.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement8.ParamName = "P_PERIOD_NAME";
            isOraParamElement8.Size = 0;
            isOraParamElement8.SourceColumn = null;
            isOraParamElement9.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement9.MemberControl = null;
            isOraParamElement9.MemberValue = null;
            isOraParamElement9.OraDbTypeString = "NUMBER";
            isOraParamElement9.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement9.ParamName = "P_ASSET_ID";
            isOraParamElement9.Size = 22;
            isOraParamElement9.SourceColumn = null;
            isOraParamElement10.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement10.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement10.MemberValue = "SOB_ID";
            isOraParamElement10.OraDbTypeString = "NUMBER";
            isOraParamElement10.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement10.ParamName = "P_SOB_ID";
            isOraParamElement10.Size = 22;
            isOraParamElement10.SourceColumn = null;
            isOraParamElement11.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement11.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement11.MemberValue = "ORG_ID";
            isOraParamElement11.OraDbTypeString = "NUMBER";
            isOraParamElement11.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement11.ParamName = "P_USER_ID";
            isOraParamElement11.Size = 22;
            isOraParamElement11.SourceColumn = null;
            this.idcDEPRECIATION_SET_CANCEL.CommandParamElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraParamElement[] {
            isOraParamElement8,
            isOraParamElement9,
            isOraParamElement10,
            isOraParamElement11});
            this.idcDEPRECIATION_SET_CANCEL.DataTransaction = null;
            this.idcDEPRECIATION_SET_CANCEL.OraConnection = this.isOraConnection1;
            this.idcDEPRECIATION_SET_CANCEL.OraOwner = "APPS";
            this.idcDEPRECIATION_SET_CANCEL.OraPackage = "FI_ASSET_DPR_HISTORY_SET_G";
            this.idcDEPRECIATION_SET_CANCEL.OraProcedure = "DEPRECIATION_SET_CANCEL";
            this.ResumeLayout(false);

        }

        #endregion

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv isAppInterfaceAdv1;
        private InfoSummit.Win.ControlAdv.ISOraConnection isOraConnection1;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter isMessageAdapter1;
        private InfoSummit.Win.ControlAdv.ISButton ibtCANCEL_DPR;
        private InfoSummit.Win.ControlAdv.ISButton ibtSET_DPR;
        private InfoSummit.Win.ControlAdv.ISEditAdv DPR_PERIOD;
        private InfoSummit.Win.ControlAdv.ISDataCommand idcDEPRECIATION_SET;
        private InfoSummit.Win.ControlAdv.ISLookupAdapter ilaPERIOD_NAME;
        private InfoSummit.Win.ControlAdv.ISLookupData ildPERIOD_NAME;
        private InfoSummit.Win.ControlAdv.ISDataCommand idcDEPRECIATION_SET_CANCEL;
    }
}

