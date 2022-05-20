namespace FCMF0902
{
    partial class FCMF0902
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
            InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo oraConnectionInfo1 = new InfoSummit.Win.ControlAdv.ISDataUtil.OraConnectionInfo();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement1 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISLanguageElement isLanguageElement2 = new InfoSummit.Win.ControlAdv.ISLanguageElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement1 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement2 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement3 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement4 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            InfoSummit.Win.ControlAdv.ISOraParamElement isOraParamElement5 = new InfoSummit.Win.ControlAdv.ISOraParamElement();
            this.isAppInterfaceAdv1 = new InfoSummit.Win.ControlAdv.ISAppInterfaceAdv(this.components);
            this.isOraConnection1 = new InfoSummit.Win.ControlAdv.ISOraConnection(this.components);
            this.isMessageAdapter1 = new InfoSummit.Win.ControlAdv.ISMessageAdapter(this.components);
            this.ibtSLIP_SUM = new InfoSummit.Win.ControlAdv.ISButton();
            this.STD_DATE = new InfoSummit.Win.ControlAdv.ISEditAdv();
            this.idcSLIP_AGGREGATE = new InfoSummit.Win.ControlAdv.ISDataCommand(this.components);
            this.SuspendLayout();
            // 
            // isAppInterfaceAdv1
            // 
            this.isAppInterfaceAdv1.AppMainButtonClick += new InfoSummit.Win.ControlAdv.ISAppInterfaceAdv.ButtonEventHandler(this.isAppInterfaceAdv1_AppMainButtonClick);
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
            // ibtSLIP_SUM
            // 
            this.ibtSLIP_SUM.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.ibtSLIP_SUM.ButtonText = "Slip Aggregate";
            isLanguageElement1.Default = "Slip Aggregate";
            isLanguageElement1.SiteName = null;
            isLanguageElement1.TL1_KR = "전표 집계";
            isLanguageElement1.TL2_CN = null;
            isLanguageElement1.TL3_VN = null;
            isLanguageElement1.TL4_JP = null;
            isLanguageElement1.TL5_XAA = null;
            this.ibtSLIP_SUM.ButtonTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement1});
            // 
            // FCMF0902
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(244)))), ((int)(((byte)(254)))));
            this.ClientSize = new System.Drawing.Size(468, 268);
            this.Controls.Add(this.ibtSLIP_SUM);
            this.Controls.Add(this.STD_DATE);
            this.Name = "FCMF0902";
            this.Padding = new System.Windows.Forms.Padding(5);
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "전표 실적 집계";
            this.Load += new System.EventHandler(this.FCMF0902_Load);
            this.Shown += new System.EventHandler(this.FCMF0902_Shown);
            this.ibtSLIP_SUM.Location = new System.Drawing.Point(310, 176);
            this.ibtSLIP_SUM.Name = "ibtSLIP_SUM";
            this.ibtSLIP_SUM.Size = new System.Drawing.Size(122, 35);
            this.ibtSLIP_SUM.TabIndex = 3;
            this.ibtSLIP_SUM.ButtonClick += new InfoSummit.Win.ControlAdv.ISButton.ClickEventHandler(this.ibtSLIP_SUM_ButtonClick);
            // 
            // STD_DATE
            // 
            this.STD_DATE.AppInterfaceAdv = this.isAppInterfaceAdv1;
            this.STD_DATE.ComboBoxValue = "";
            this.STD_DATE.ComboData = null;
            this.STD_DATE.CurrencyValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.STD_DATE.DataAdapter = null;
            this.STD_DATE.DataColumn = null;
            this.STD_DATE.DateTimeValue = new System.DateTime(2011, 2, 15, 0, 0, 0, 0);
            this.STD_DATE.DoubleValue = 0;
            this.STD_DATE.EditAdvType = InfoSummit.Win.ControlAdv.ISUtil.Enum.EditAdvType.DateTimeEdit;
            this.STD_DATE.EditValue = null;
            this.STD_DATE.Location = new System.Drawing.Point(47, 64);
            this.STD_DATE.LookupAdapter = null;
            this.STD_DATE.Name = "STD_DATE";
            this.STD_DATE.Nullable = true;
            this.STD_DATE.NumberValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.STD_DATE.PercentValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.STD_DATE.PromptText = "기준일자";
            isLanguageElement2.Default = "Standard Date";
            isLanguageElement2.SiteName = null;
            isLanguageElement2.TL1_KR = "기준일자";
            isLanguageElement2.TL2_CN = null;
            isLanguageElement2.TL3_VN = null;
            isLanguageElement2.TL4_JP = null;
            isLanguageElement2.TL5_XAA = null;
            this.STD_DATE.PromptTextElement.AddRange(new InfoSummit.Win.ControlAdv.ISLanguageElement[] {
            isLanguageElement2});
            this.STD_DATE.PromptWidth = 150;
            this.STD_DATE.Size = new System.Drawing.Size(300, 21);
            this.STD_DATE.TabIndex = 2;
            this.STD_DATE.TerritoryLanguage = InfoSummit.Win.ControlAdv.ISUtil.Enum.TerritoryLanguage.TL1_KR;
            this.STD_DATE.TextValue = "";
            // 
            // idcSLIP_AGGREGATE
            // 
            isOraParamElement1.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement1.MemberControl = this.STD_DATE;
            isOraParamElement1.MemberValue = "EditValue";
            isOraParamElement1.OraDbTypeString = "DATE";
            isOraParamElement1.OraType = System.Data.OracleClient.OracleType.DateTime;
            isOraParamElement1.ParamName = "P_STD_DATE";
            isOraParamElement1.Size = 0;
            isOraParamElement1.SourceColumn = null;
            isOraParamElement2.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement2.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement2.MemberValue = "SOB_ID";
            isOraParamElement2.OraDbTypeString = "NUMBER";
            isOraParamElement2.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement2.ParamName = "P_SOB_ID";
            isOraParamElement2.Size = 22;
            isOraParamElement2.SourceColumn = null;
            isOraParamElement3.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement3.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement3.MemberValue = "ORG_ID";
            isOraParamElement3.OraDbTypeString = "NUMBER";
            isOraParamElement3.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement3.ParamName = "P_ORG_ID";
            isOraParamElement3.Size = 22;
            isOraParamElement3.SourceColumn = null;
            isOraParamElement4.Direction = System.Data.ParameterDirection.Input;
            isOraParamElement4.MemberControl = this.isAppInterfaceAdv1;
            isOraParamElement4.MemberValue = "USER_ID";
            isOraParamElement4.OraDbTypeString = "NUMBER";
            isOraParamElement4.OraType = System.Data.OracleClient.OracleType.Number;
            isOraParamElement4.ParamName = "P_USER_ID";
            isOraParamElement4.Size = 22;
            isOraParamElement4.SourceColumn = null;
            isOraParamElement5.Direction = System.Data.ParameterDirection.Output;
            isOraParamElement5.MemberControl = null;
            isOraParamElement5.MemberValue = null;
            isOraParamElement5.OraDbTypeString = "VARCHAR2";
            isOraParamElement5.OraType = System.Data.OracleClient.OracleType.VarChar;
            isOraParamElement5.ParamName = "O_MESSAGE";
            isOraParamElement5.Size = 0;
            isOraParamElement5.SourceColumn = null;
            this.idcSLIP_AGGREGATE.CommandParamElement.AddRange(new InfoSummit.Win.ControlAdv.ISOraParamElement[] {
            isOraParamElement1,
            isOraParamElement2,
            isOraParamElement3,
            isOraParamElement4,
            isOraParamElement5});
            this.idcSLIP_AGGREGATE.DataTransaction = null;
            this.idcSLIP_AGGREGATE.OraConnection = this.isOraConnection1;
            this.idcSLIP_AGGREGATE.OraOwner = "APPS";
            this.idcSLIP_AGGREGATE.OraPackage = "FI_AGGREGATE_G";
            this.idcSLIP_AGGREGATE.OraProcedure = "ACCOUNT_AGGREGATE_SET";
            this.ResumeLayout(false);

        }

        #endregion

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv isAppInterfaceAdv1;
        private InfoSummit.Win.ControlAdv.ISOraConnection isOraConnection1;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter isMessageAdapter1;
        private InfoSummit.Win.ControlAdv.ISButton ibtSLIP_SUM;
        private InfoSummit.Win.ControlAdv.ISEditAdv STD_DATE;
        private InfoSummit.Win.ControlAdv.ISDataCommand idcSLIP_AGGREGATE;
    }
}

