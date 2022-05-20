namespace FCMF0901
{
    partial class FCMF0901
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
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement2 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISOraColElement isOraColElement1 = new InfoSummit.Win.ControlAdv.ISOraColElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement1 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement2 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement3 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo oraConnectionInfo1 = new InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement4 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement5 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement6 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement7 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement8 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement1 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            this.PERIOD_NAME = new InfoSummit.Win.ControlAdv.ISEditAdv();
            this.isAppInterfaceAdv1 = new InfoSummit.Win.ControlAdv.ISAppInterfaceAdv(this.components);
            this.ilaPERIOD_NAME = new InfoSummit.Win.ControlAdv.ISLookupAdapter(this.components);
            this.ildPERIOD_NAME = new InfoSummit.Win.ControlAdv.ISLookupData(this.components);
            this.isOraConnection1 = new InfoSummit.Win.ControlAdv.ISOraConnection(this.components);
            this.isMessageAdapter1 = new InfoSummit.Win.ControlAdv.ISMessageAdapter(this.components);
            this.idcCLOSED_PERIOD = new InfoSummit.Win.ControlAdv.ISDataCommand(this.components);
            this.ibtCLOSED_PERIOD = new InfoSummit.Win.ControlAdv.ISButton();
            this.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ilaPERIOD_NAME.PropSourceDataTable)).BeginInit();
            // 
            // PERIOD_NAME
            // 
            this.PERIOD_NAME.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.PERIOD_NAME.ComboBoxValue = "";
            this.PERIOD_NAME.ComboData = null;
            this.PERIOD_NAME.CurrencyValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.PERIOD_NAME.DataAdapter = null;
            this.PERIOD_NAME.DataColumn = null;
            this.PERIOD_NAME.DateTimeValue = new System.DateTime(2010, 3, 17, 0, 0, 0, 0);
            this.PERIOD_NAME.DoubleValue = 0;
            this.PERIOD_NAME.EditValue = "";
            // 
            // FCMF0901
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(244)))), ((int)(((byte)(254)))));
            this.ClientSize = new System.Drawing.Size(482, 145);
            this.Controls.Add(this.ibtCLOSED_PERIOD);
            this.Controls.Add(this.PERIOD_NAME);
            this.Cursor = System.Windows.Forms.Cursors.Default;
            this.Name = "FCMF0901";
            this.Padding = new System.Windows.Forms.Padding(5);
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "월마감 및 잔액 이월";
            this.Load += new System.EventHandler(this.FCMF0901_Load);
            this.Shown += new System.EventHandler(this.FCMF0901_Shown);
            this.PERIOD_NAME.Location = new System.Drawing.Point(76, 36);
            this.PERIOD_NAME.LookupAdapter = this.ilaPERIOD_NAME;
            this.PERIOD_NAME.Name = "PERIOD_NAME";
            this.PERIOD_NAME.NumberValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.PERIOD_NAME.PercentValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.PERIOD_NAME.PromptText = "마감년월";
            isLanguageElement2.Default = "Closed Period";
            isLanguageElement2.SiteName = null;
            isLanguageElement2.TL1_KR = "마감년월";
            isLanguageElement2.TL2_CN = null;
            isLanguageElement2.TL3_VN = null;
            isLanguageElement2.TL4_JP = null;
            isLanguageElement2.TL5_XAA = null;
            this.PERIOD_NAME.PromptTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement2});
            this.PERIOD_NAME.PromptWidth = 150;
            this.PERIOD_NAME.Size = new System.Drawing.Size(300, 21);
            this.PERIOD_NAME.TabIndex = 0;
            this.PERIOD_NAME.TerritoryLanguage = InfoSummit.Win.ControlAdv.ISUtil.Enum.TerritoryLanguage.TL1_KR;
            this.PERIOD_NAME.TextValue = "";
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
            isOraColElement1.MemberControl = this.PERIOD_NAME;
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
            // idcCLOSED_PERIOD
            // 
            isOraParamElement4.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement4.MemberControl = this.PERIOD_NAME;
            isOraParamElement4.MemberValue = "EditValue";
            isOraParamElement4.OraDbTypeString = "VARCHAR2";
            isOraParamElement4.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement4.ParamName = "P_PERIOD_NAME";
            isOraParamElement4.Size = 0;
            isOraParamElement4.SourceColumn = null;
            isOraParamElement5.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement5.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement5.MemberValue = "SOB_ID";
            isOraParamElement5.OraDbTypeString = "NUMBER";
            isOraParamElement5.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement5.ParamName = "P_SOB_ID";
            isOraParamElement5.Size = 22;
            isOraParamElement5.SourceColumn = null;
            isOraParamElement6.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement6.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement6.MemberValue = "ORG_ID";
            isOraParamElement6.OraDbTypeString = "NUMBER";
            isOraParamElement6.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement6.ParamName = "P_ORG_ID";
            isOraParamElement6.Size = 22;
            isOraParamElement6.SourceColumn = null;
            isOraParamElement7.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement7.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement7.MemberValue = "USER_ID";
            isOraParamElement7.OraDbTypeString = "NUMBER";
            isOraParamElement7.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement7.ParamName = "P_USER_ID";
            isOraParamElement7.Size = 22;
            isOraParamElement7.SourceColumn = null;
            isOraParamElement8.Direction = System.Data.ParameterDirection.Output;
            isOraParamElement8.MemberControl = null;
            isOraParamElement8.MemberValue = null;
            isOraParamElement8.OraDbTypeString = "VARCHAR2";
            isOraParamElement8.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement8.ParamName = "O_MESSAGE";
            isOraParamElement8.Size = 0;
            isOraParamElement8.SourceColumn = null;
            this.idcCLOSED_PERIOD.CommandParamElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraParamElement[] {
            isOraParamElement4,
            isOraParamElement5,
            isOraParamElement6,
            isOraParamElement7,
            isOraParamElement8});
            this.idcCLOSED_PERIOD.DataTransaction = null;
            this.idcCLOSED_PERIOD.OraConnection = this.isOraConnection1;
            this.idcCLOSED_PERIOD.OraOwner = "APPS";
            this.idcCLOSED_PERIOD.OraPackage = "FI_MONTH_CLOSE_G";
            this.idcCLOSED_PERIOD.OraProcedure = "MONTHLY_CLOSE";
            // 
            // ibtCLOSED_PERIOD
            // 
            this.ibtCLOSED_PERIOD.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.ibtCLOSED_PERIOD.ButtonText = "Closed Period";
            isLanguageElement1.Default = "Closed Period";
            isLanguageElement1.SiteName = null;
            isLanguageElement1.TL1_KR = "마감 처리";
            isLanguageElement1.TL2_CN = null;
            isLanguageElement1.TL3_VN = null;
            isLanguageElement1.TL4_JP = null;
            isLanguageElement1.TL5_XAA = null;
            this.ibtCLOSED_PERIOD.ButtonTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement1});
            this.ibtCLOSED_PERIOD.Location = new System.Drawing.Point(329, 90);
            this.ibtCLOSED_PERIOD.Name = "ibtCLOSED_PERIOD";
            this.ibtCLOSED_PERIOD.Size = new System.Drawing.Size(122, 35);
            this.ibtCLOSED_PERIOD.TabIndex = 1;
            this.ibtCLOSED_PERIOD.ButtonClick += new InfoSummit.Win.ControlAdv.ISButton.ClickEventHandler(this.ibtCLOSED_PERIOD_ButtonClick);
            this.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ilaPERIOD_NAME.PropSourceDataTable)).EndInit();

        }

        #endregion

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv isAppInterfaceAdv1;
        private InfoSummit.Win.ControlAdv.ISOraConnection isOraConnection1;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter isMessageAdapter1;
        private InfoSummit.Win.ControlAdv.ISEditAdv PERIOD_NAME;
        private InfoSummit.Win.ControlAdv.ISDataCommand idcCLOSED_PERIOD;
        private InfoSummit.Win.ControlAdv.ISButton ibtCLOSED_PERIOD;
        private InfoSummit.Win.ControlAdv.ISLookupData ildPERIOD_NAME;
        private InfoSummit.Win.ControlAdv.ISLookupAdapter ilaPERIOD_NAME;
    }
}

