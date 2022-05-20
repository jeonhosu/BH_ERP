using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace FX_Main
{
    static class Program
    {
        /// <summary>
        /// 해당 응용 프로그램의 주 진입점입니다.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string[] vSplit = new string[25];

            //SOB - 10
            //BH Prod.
            vSplit[0] = "192.168.10.10";                  //Oracle_Host
            vSplit[1] = "1521";                           //Oracle_Port
            vSplit[2] = "MESORA";                          //Oracle_ServiceName
            vSplit[3] = "apps";                           //Oracle_UserId
            vSplit[4] = "erp0201";                       //Oracle_Password       

            ////BH test.
            //vSplit[0] = "192.168.10.5";                  //Oracle_Host
            //vSplit[1] = "1521";                           //Oracle_Port
            //vSplit[3] = "apps";                           //Oracle_UserId
            //vSplit[4] = "apps";                          //Oracle_Password      

            vSplit[5] = "211.168.59.132";                 //FTP_Host;
            vSplit[6] = "21";                             //FTP_Port;
            vSplit[7] = "flexftp";                        //FTP_Id;
            vSplit[8] = "infoflex";                       //FTP_Password;

            vSplit[9] = "10";   //SOB_ID
            vSplit[10] = "101"; //ORG_ID

            vSplit[11] = "3122"; //LoginId;
            vSplit[12] = "조선미"; //LoginDescription;
            vSplit[13] = "조선미(B11031)"; //LoginDisplayName;

            vSplit[20] = "14811"; //PersonID
            vSplit[21] = "B13286"; //PersonNumber
            vSplit[22] = "213"; //DepartmentID
            vSplit[23] = "인사총무팀"; //DepartmentName
            

            vSplit[14] = DateTime.Now.ToShortDateString(); //LoginDate;
            vSplit[15] = DateTime.Now.ToString("HH:mm:ss", null); //LoginTime;
            vSplit[16] = "KOR"; //TerritoryLanguage
            //vSplit[16] = "ENG"; //TerritoryLanguage
            vSplit[17] = "S"; //UserType - 사용자구분(A.기본USER/B.제한된USER/S.시스템USER)
            vSplit[18] = "S"; //UserAuthorityType - 권한구분 (A.별도정의/S.SUPERUSER)
            vSplit[19] = "B10011"; //LoginNo

            vSplit[24] = "Flex_ERP\\Kor"; //mBaseWorkingDirectory
            //---------------------------------------------------------------------

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new APPF0020(vSplit[0], vSplit[1], vSplit[2], vSplit[3], vSplit[4],
                                         vSplit[5], vSplit[6], vSplit[7], vSplit[8],
                                         vSplit[9], vSplit[10],
                                         vSplit[11], vSplit[12], vSplit[13], vSplit[14], vSplit[15],
                                         vSplit[16], vSplit[17], vSplit[18], vSplit[19],
                                         vSplit[20], vSplit[21], vSplit[22], vSplit[23],
                                         vSplit[24]));
        }
    }
}