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


namespace FX_Main
{
    public partial class APPF0020 : Office2007Form
    {
        #region ----- Enums -----



        #endregion;

        #region ----- Variables -----

        private ISAppInterface mAppInterface;
        private APPF0030 mAPPF0030 = null;
        
        #endregion;

        #region ----- Constructor -----

        public APPF0020(string pOraHost, string pOraPort, string pOraServiceName, string pOraUserId, string pOraPassword,
                        string pAppHost, string pAppPort, string pAppUserId, string pAppPassword,
                        string pSOBID, string pORGID,
                        string pLoginId, string pLoginDescription, string pUserDisplayName, string pLoginDate, string pLoginTime,
                        string pTerritoryLanguage, string pUserType, string pUserAuthorityType)
        {
            InitializeComponent();

            string vDateTime = string.Format("{0} {1}", pLoginDate, pLoginTime);
            DateTime vLoginDateTime = Convert.ToDateTime(vDateTime);
            int vSOBID = Convert.ToInt32(pSOBID);
            int vORGID = Convert.ToInt32(pORGID);

            ISUtil.Enum.TerritoryLanguage vTerritoryLanguage = ISUtil.Enum.TerritoryLanguage.Design;
            if (pTerritoryLanguage == "ENG")
            {
                vTerritoryLanguage = ISUtil.Enum.TerritoryLanguage.Design;
            }
            else if (pTerritoryLanguage == "KOR")
            {
                vTerritoryLanguage = ISUtil.Enum.TerritoryLanguage.TL1_KR;
            }

            ISDataUtil.AppHostInfo vAppHostInfo = new ISDataUtil.AppHostInfo(pAppHost, pAppPort, pAppUserId, pAppPassword);
            ISDataUtil.OraConnectionInfo vOraConnectionInfo = new ISDataUtil.OraConnectionInfo(pOraHost, pOraPort, pOraServiceName, pOraUserId, pOraPassword, vTerritoryLanguage);
            mAppInterface = new ISAppInterface(vAppHostInfo, vOraConnectionInfo, Convert.ToInt32(pLoginId), pLoginDescription, vLoginDateTime, vSOBID, vORGID);
            mAppInterface.OnAppMessage += Application_OnAppMessage;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Navigator()
        {
            mAPPF0030 = new APPF0030(this, mAppInterface);
            mAPPF0030.Show();
        }

        private void Application_OnAppMessage(string pMessageText)
        {
            appStatusText.Text = pMessageText; //Status Bar
        }

        private void f_Screen_Center_Location()
        {
            //작업표시 1줄 Pixel Size = 34
            //작업표시 2줄 Pixel Size = 64

            int v_Scrren_Count = System.Windows.Forms.Screen.AllScreens.Length;

            int v_Screen_Width = 0;
            int v_Screen_Height = 0;
            int v_Task_Bar = 0;
            int v_this_Location_X = 0;
            int v_this_Location_Y = 0;

            if (v_Scrren_Count > 1)
            {
                v_Screen_Width = System.Windows.Forms.Screen.AllScreens[1].Bounds.Width;
                v_Screen_Height = System.Windows.Forms.Screen.AllScreens[1].Bounds.Height;

                this.Width = v_Screen_Width - 300;
                this.Height = v_Screen_Height - 130;
            }
            else
            {
                v_Task_Bar = 64;

                v_Screen_Width = System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width;
                v_Screen_Height = System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height;
            }

            int v_PrimaryScreen_Width = System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width;

            int v_Task_Bar_Cut_Screen_Height = v_Screen_Height - v_Task_Bar;

            int v_this_Form_Width = this.Width;
            int v_this_Form_Height = this.Height;

            if (v_Scrren_Count > 1)
            {
                v_this_Location_X = v_Screen_Width - v_this_Form_Width + v_PrimaryScreen_Width;
            }
            else
            {
                v_this_Location_X = v_Screen_Width - v_this_Form_Width;
            }
            v_this_Location_Y = v_Task_Bar_Cut_Screen_Height - v_this_Form_Height;

            if (v_this_Location_X < 0)
            {
                v_this_Location_X = 0;
            }
            if (v_this_Location_Y < 0)
            {
                v_this_Location_Y = 0;
            }

            this.Location = new System.Drawing.Point(v_this_Location_X, v_this_Location_Y);
        }

        #endregion;

        #region ----- FormLoading Methods -----

        private bool FormLoading1(string psPathTemp, string psLoadFile)
        {
            try
            {
                string vDllFilePathString = string.Format("{0}\\{1}\\bin\\Debug\\{2}.dll", psPathTemp, psLoadFile, psLoadFile);
                string vNameSpaceClass = string.Format("{0}.{1}", psLoadFile, psLoadFile);

                System.Reflection.Assembly vAssembly = System.Reflection.Assembly.LoadFrom(vDllFilePathString);
                System.Type vType = vAssembly.GetType(vNameSpaceClass);

                if (vType != null)
                {
                    object[] voParam = new object[2];
                    voParam[0] = this;
                    voParam[1] = mAppInterface;

                    object vObject = Activator.CreateInstance(vType, voParam);
                    System.Windows.Forms.Form vForm = vObject as System.Windows.Forms.Form;
                    vForm.Show();

                    return true;
                }
                else
                {
                    MessageBoxAdv.Show("Longing Assembly is Null");
                    return false;
                }
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
        }

        #endregion;

        #region ----- Events -----

        private void barItem3_Click(object sender, EventArgs e)
        {
            //어플리케이션 종료
            System.Windows.Forms.Application.Exit();
        }

        private void APPF0020_FormClosed(object sender, FormClosedEventArgs e)
        {
            foreach (System.Windows.Forms.Form OpenForm in this.MdiChildren)
            {
                if (OpenForm != null)
                {
                    OpenForm.Close();
                }
            }
        }

        private void MdiBackColor()
        {
            foreach (Control control in this.Controls)
            {
                MdiClient client = control as MdiClient;
                if (client != null)
                {
                    client.BackColor = System.Drawing.Color.White;
                }
            }
        }

        private void APPF0020_Load(object sender, EventArgs e)
        {
            //int vCount = this.Controls.Count - 1;
            //this.Controls[this.Controls.Count - vCount].BackColor = System.Drawing.Color.White;

            //MdiBackColor();

            //f_Screen_Center_Location();

            Navigator();
        }

        private void barItem22_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Search);
        }

        private void barItem1_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.AddOver);
        }

        private void barItem16_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.AddUnder);
        }

        private void barItem6_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Update);
        }

        private void barItem10_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Cancel);
        }

        private void barItem14_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Delete);
        }

        private void barItem4_Click(object sender, EventArgs e)
        {
            mAppInterface.MainButtonEvent(ISUtil.Enum.AppMainButtonType.Print);
        }

        private void barItem7_Click(object sender, EventArgs e)
        {
            //계단식
            this.LayoutMdi(MdiLayout.Cascade);
        }

        private void barItem8_Click(object sender, EventArgs e)
        {
            //수평
            this.LayoutMdi(MdiLayout.TileHorizontal);
        }

        private void barItem9_Click(object sender, EventArgs e)
        {
            //수직
            this.LayoutMdi(MdiLayout.TileVertical);
        }

        private void barItem11_Click(object sender, EventArgs e)
        {
            mAPPF0030.Activate();
        }

        private void barItem18_Click(object sender, EventArgs e)
        {
            string vPath = string.Format("{0}", @"..\..\..");
            FormLoading1(vPath, "AppAssemblyEntry");
        }

        private void barItem21_Click(object sender, EventArgs e)
        {
            string vPath = string.Format("{0}", @"..\..\..");
            FormLoading1(vPath, "AppMenuEntry");
        }

        #endregion;
    }
}