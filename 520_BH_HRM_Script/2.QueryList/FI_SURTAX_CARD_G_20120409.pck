CREATE OR REPLACE PACKAGE FI_SURTAX_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SURTAX_CARD_G
Description  : 부가세신고서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 부가세신고서
Program History :
    -.부가가치세 관련 모든 자료들을 생성 후 작업한다. 작업순서상 제일 마지막에 한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-05   Leem Dong Ern(임동언)
*****************************************************************************/





--신고서생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --사업부아이디
    --, W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_OPERATING_UNIT_ID   IN  VARCHAR2                            --사업장아이디(예>110)     
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호
    
    --참조>수정신고는 처리할 수 있도록 틀만 만들고 실제 작업은 진행하지 않았다.
    --, W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
    
    , W_TITLE_1_1           IN  FI_SURTAX_CARD.TITLE_1_1%TYPE           --신고기간_시작
    , W_TITLE_1_2           IN  FI_SURTAX_CARD.TITLE_1_2%TYPE           --신고기간_종료     
    , W_CREATED_BY          IN  FI_SURTAX_CARD.CREATED_BY%TYPE          --생성자   
);





--조회 및 출력
PROCEDURE LIST_SURTAX_CARD(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
);






--UPDATE
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , P_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호    
    , P_VAT_MAKE_GB	        IN	FI_SURTAX_CARD.VAT_MAKE_GB%TYPE	        --신고구분
    
    , P_GUBUN_1	            IN	FI_SURTAX_CARD.GUBUN_1%TYPE	    --신고서구분_예정
    , P_GUBUN_2	            IN	FI_SURTAX_CARD.GUBUN_2%TYPE	    --신고서구분_확정
    , P_GUBUN_3	            IN	FI_SURTAX_CARD.GUBUN_3%TYPE	    --신고서구분_기한후과세표준
    , P_GUBUN_4	            IN	FI_SURTAX_CARD.GUBUN_4%TYPE	    --신고서구분_영세율등조기환급
    , P_TITLE_1_1	        IN	FI_SURTAX_CARD.TITLE_1_1%TYPE	--신고기간_시작
    , P_TITLE_1_2	        IN	FI_SURTAX_CARD.TITLE_1_2%TYPE	--신고기간_종료
    , P_TITLE_2	            IN	FI_SURTAX_CARD.TITLE_2%TYPE	    --상호
    , P_TITLE_3	            IN	FI_SURTAX_CARD.TITLE_3%TYPE	    --성명
    , P_TITLE_4	            IN	FI_SURTAX_CARD.TITLE_4%TYPE	    --사업자등록번호
    , P_TITLE_5	            IN	FI_SURTAX_CARD.TITLE_5%TYPE	    --법인등록번호
    , P_TITLE_6	            IN	FI_SURTAX_CARD.TITLE_6%TYPE	    --사업장전화
    , P_TITLE_7	            IN	FI_SURTAX_CARD.TITLE_7%TYPE	    --주소지전화
    , P_TITLE_8	            IN	FI_SURTAX_CARD.TITLE_8%TYPE	    --휴대전화
    , P_TITLE_9	            IN	FI_SURTAX_CARD.TITLE_9%TYPE	    --사업장주소
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	--전자우편주소
    , P_TITLE_11	        IN	FI_SURTAX_CARD.TITLE_11%TYPE	--업태
    , P_TITLE_12	        IN	FI_SURTAX_CARD.TITLE_12%TYPE	--종목
    , P_TITLE_13	        IN	FI_SURTAX_CARD.TITLE_13%TYPE	--업종코드
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	--작성일자
    , P_TITLE_15	        IN	FI_SURTAX_CARD.TITLE_15%TYPE	--신고인
    , P_TITLE_16	        IN	FI_SURTAX_CARD.TITLE_16%TYPE	--세무서
    , P_COL1_1	            IN	FI_SURTAX_CARD.COL1_1%TYPE	--과세_세금계산서발급분_금액
    , P_COL1_2	            IN	FI_SURTAX_CARD.COL1_2%TYPE	--과세_세금계산서발급분_세액
    , P_COL2_1	            IN	FI_SURTAX_CARD.COL2_1%TYPE	--과세_매입자발행세금계산서_금액
    , P_COL2_2	            IN	FI_SURTAX_CARD.COL2_2%TYPE	--과세_매입자발행세금계산서_세액
    , P_COL3_1	            IN	FI_SURTAX_CARD.COL3_1%TYPE	--과세_신용카드_현금영수증발행분_금액
    , P_COL3_2	            IN	FI_SURTAX_CARD.COL3_2%TYPE	--과세_신용카드_현금영수증발행분_세액
    , P_COL4_1	            IN	FI_SURTAX_CARD.COL4_1%TYPE	--과세_기타_금액
    , P_COL4_2	            IN	FI_SURTAX_CARD.COL4_2%TYPE	--과세_기타_세액
    , P_COL5_1	            IN	FI_SURTAX_CARD.COL5_1%TYPE	--영세율_세금계산서발급분_금액
    , P_COL6_1	            IN	FI_SURTAX_CARD.COL6_1%TYPE	--영세율_기타_금액
    , P_COL7_1	            IN	FI_SURTAX_CARD.COL7_1%TYPE	--예정신고누락분_금액
    , P_COL7_2	            IN	FI_SURTAX_CARD.COL7_2%TYPE	--예정신고누락분_세액
    , P_COL8_2	            IN	FI_SURTAX_CARD.COL8_2%TYPE	--대손세액가감_세액
    , P_COL9_1	            IN	FI_SURTAX_CARD.COL9_1%TYPE	--합계_금액
    , P_COL9_2	            IN	FI_SURTAX_CARD.COL9_2%TYPE	--합계_세액
    , P_COL10_1	            IN	FI_SURTAX_CARD.COL10_1%TYPE	--매입_일반매입_금액
    , P_COL10_2	            IN	FI_SURTAX_CARD.COL10_2%TYPE	--매입_일반매입_세액
    , P_COL11_1	            IN	FI_SURTAX_CARD.COL11_1%TYPE	--매입_고정자산매입_금액
    , P_COL11_2	            IN	FI_SURTAX_CARD.COL11_2%TYPE	--매입_고장자산매입_세액
    , P_COL12_1	            IN	FI_SURTAX_CARD.COL12_1%TYPE	--매입_예정신고누락분_금액
    , P_COL12_2	            IN	FI_SURTAX_CARD.COL12_2%TYPE	--매입_예정신고누락분_세액
    , P_COL13_1	            IN	FI_SURTAX_CARD.COL13_1%TYPE	--매입_매입자발행세금계산서_금액
    , P_COL13_2	            IN	FI_SURTAX_CARD.COL13_2%TYPE	--매입_매입자발행세금계산서_세액
    , P_COL14_1	            IN	FI_SURTAX_CARD.COL14_1%TYPE	--매입_기타공제매입세액_금액
    , P_COL14_2	            IN	FI_SURTAX_CARD.COL14_2%TYPE	--매입_기타공제매입세액_세액
    , P_COL15_1	            IN	FI_SURTAX_CARD.COL15_1%TYPE	--매입_합계_금액
    , P_COL15_2	            IN	FI_SURTAX_CARD.COL15_2%TYPE	--매입_합계_세액
    , P_COL16_1	            IN	FI_SURTAX_CARD.COL16_1%TYPE	--매입_공제받지못할매입세액_금액
    , P_COL16_2	            IN	FI_SURTAX_CARD.COL16_2%TYPE	--매입_공제받지못할매입세액_세액
    , P_COL17_1	            IN	FI_SURTAX_CARD.COL17_1%TYPE	--매입_차감계_금액
    , P_COL17_2	            IN	FI_SURTAX_CARD.COL17_2%TYPE	--매입_차감계_세액
    , P_COL_DA	            IN	FI_SURTAX_CARD.COL_DA%TYPE	--납부세액
    , P_COL18_2	            IN	FI_SURTAX_CARD.COL18_2%TYPE	--기타경감공제세액
    , P_COL19_2	            IN	FI_SURTAX_CARD.COL19_2%TYPE	--신용카드매출전표등발행공제등
    , P_COL20_2	            IN	FI_SURTAX_CARD.COL20_2%TYPE	--경감공제_합계
    , P_COL21_2	            IN	FI_SURTAX_CARD.COL21_2%TYPE	--예정신고미환급세액
    , P_COL22_2	            IN	FI_SURTAX_CARD.COL22_2%TYPE	--예정고지세액
    , P_COL23_2	            IN	FI_SURTAX_CARD.COL23_2%TYPE	--금지금_매입자_납부특례_기납부세액
    , P_COL24_2	            IN	FI_SURTAX_CARD.COL24_2%TYPE	--가산세액계
    , P_COL25	            IN	FI_SURTAX_CARD.COL25%TYPE	--차가감하여납부할세액
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	    --거래은행
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	--거래은행코드
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	    --거래지점
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	--거래지점코드
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	        --계좌번호
    , P_CLOSURE_DATE	    IN	FI_SURTAX_CARD.CLOSURE_DATE%TYPE	--폐업일
    , P_CLOSURE_REASON	    IN	FI_SURTAX_CARD.CLOSURE_REASON%TYPE	--폐업사유
    , P_COL26_1	            IN	FI_SURTAX_CARD.COL26_1%TYPE	--과세표준_업태1
    , P_COL26_2	            IN	FI_SURTAX_CARD.COL26_2%TYPE	--과세표준_종목1
    , P_COL26_3	            IN	FI_SURTAX_CARD.COL26_3%TYPE	--과세표준_금액1
    , P_COL27_1	            IN	FI_SURTAX_CARD.COL27_1%TYPE	--과세표준_업태2
    , P_COL27_2	            IN	FI_SURTAX_CARD.COL27_2%TYPE	--과세표준_종목2
    , P_COL27_3	            IN	FI_SURTAX_CARD.COL27_3%TYPE	--과세표준_금액2
    , P_COL28_1	            IN	FI_SURTAX_CARD.COL28_1%TYPE	--과세표준_업태3
    , P_COL28_2	            IN	FI_SURTAX_CARD.COL28_2%TYPE	--과세표준_종목3
    , P_COL28_3	            IN	FI_SURTAX_CARD.COL28_3%TYPE	--과세표준_금액3
    , P_COL29_1	            IN	FI_SURTAX_CARD.COL29_1%TYPE	--과세표준_업태4
    , P_COL29_2	            IN	FI_SURTAX_CARD.COL29_2%TYPE	--과세표준_종목4
    , P_COL29_3	            IN	FI_SURTAX_CARD.COL29_3%TYPE	--과세표준_금액4
    , P_COL30	            IN	FI_SURTAX_CARD.COL30%TYPE	--과세표준_합계
    , P_COL31_1	            IN	FI_SURTAX_CARD.COL31_1%TYPE	--예정신고_매출_과세_세금계산서_금액
    , P_COL31_2	            IN	FI_SURTAX_CARD.COL31_2%TYPE	--예정신고_매출_과세_세금계산서_세액
    , P_COL32_1	            IN	FI_SURTAX_CARD.COL32_1%TYPE	--예정신고_매출_과세_기타_금액
    , P_COL32_2	            IN	FI_SURTAX_CARD.COL32_2%TYPE	--예정신고_매출_과세_기타_세액
    , P_COL33_1	            IN	FI_SURTAX_CARD.COL33_1%TYPE	--예정신고_매출_영세율_세금계산서
    , P_COL34_1	            IN	FI_SURTAX_CARD.COL34_1%TYPE	--예정신고_매출_영세율_기타
    , P_COL35_1	            IN	FI_SURTAX_CARD.COL35_1%TYPE	--예정신고_매출_합계_금액
    , P_COL35_2	            IN	FI_SURTAX_CARD.COL35_2%TYPE	--예정신고_매출_합계_세액
    , P_COL36_1	            IN	FI_SURTAX_CARD.COL36_1%TYPE	--예정신고_매입_세금계산서_금액
    , P_COL36_2	            IN	FI_SURTAX_CARD.COL36_2%TYPE	--예정신고_매입_세금계산서_세액
    , P_COL37_1	            IN	FI_SURTAX_CARD.COL37_1%TYPE	--예정신고_매입_기타공제매입세액_금액
    , P_COL37_2	            IN	FI_SURTAX_CARD.COL37_2%TYPE	--예정신고_매입_기타공제매입세액_세액
    , P_COL38_1	            IN	FI_SURTAX_CARD.COL38_1%TYPE	--예정신고_매입_합계_금액
    , P_COL38_2	            IN	FI_SURTAX_CARD.COL38_2%TYPE	--예정신고_매입_합계_세액
    , P_COL39_1	            IN	FI_SURTAX_CARD.COL39_1%TYPE	--기타공제_신용카드_일반매입_금액
    , P_COL39_2	            IN	FI_SURTAX_CARD.COL39_2%TYPE	--기타공제_신용카드_일반매입_세액
    , P_COL40_1	            IN	FI_SURTAX_CARD.COL40_1%TYPE	--기타공제_신용카드_고정자산매입_금액
    , P_COL40_2	            IN	FI_SURTAX_CARD.COL40_2%TYPE	--기타공제_신용카드_고정자산매입_세액
    , P_COL41_1	            IN	FI_SURTAX_CARD.COL41_1%TYPE	--기타공제_의제매입세액_금액
    , P_COL41_2	            IN	FI_SURTAX_CARD.COL41_2%TYPE	--기타공제_의제매입세액_세액
    , P_COL42_1	            IN	FI_SURTAX_CARD.COL42_1%TYPE	--기타공제_재활용폐자원등매입세액_금액
    , P_COL42_2	            IN	FI_SURTAX_CARD.COL42_2%TYPE	--기타공제_재활용폐자원등매입세액_세액
    , P_COL43_1	            IN	FI_SURTAX_CARD.COL43_1%TYPE	--기타공제_고금의제매입세액_금액
    , P_COL43_2	            IN	FI_SURTAX_CARD.COL43_2%TYPE	--기타공제_고금의제매입세액_세액
    , P_COL44_2	            IN	FI_SURTAX_CARD.COL44_2%TYPE	--기타공제_과세사업전환매입세액_세액
    , P_COL45_2	            IN	FI_SURTAX_CARD.COL45_2%TYPE	--기타공제_재고매입세액_세액
    , P_COL46_2	            IN	FI_SURTAX_CARD.COL46_2%TYPE	--기타공제_변제대손세액_세액
    , P_COL47_1	            IN	FI_SURTAX_CARD.COL47_1%TYPE	--기타공제_합계_금액
    , P_COL47_2	            IN	FI_SURTAX_CARD.COL47_2%TYPE	--기타공제_헙계_세액
    , P_COL48_1	            IN	FI_SURTAX_CARD.COL48_1%TYPE	--공제받지못할매입세액_공제받지못할_금액
    , P_COL48_2	            IN	FI_SURTAX_CARD.COL48_2%TYPE	--공제받지못할매입세액_공제받지못할_세액
    , P_COL49_1	            IN	FI_SURTAX_CARD.COL49_1%TYPE	--공제받지못할매입세액_공통매입세액면세_금액
    , P_COL49_2	            IN	FI_SURTAX_CARD.COL49_2%TYPE	--공제받지못할매입세액_공통매입세액면세_세액
    , P_COL50_1	            IN	FI_SURTAX_CARD.COL50_1%TYPE	--공제받지못할매입세액_대손처분받은세액_금액
    , P_COL50_2	            IN	FI_SURTAX_CARD.COL50_2%TYPE	--공제받지못할매입세액_대손처분받은세액_세액
    , P_COL51_1	            IN	FI_SURTAX_CARD.COL51_1%TYPE	--공제받지못할매입세액_합계_금액
    , P_COL51_2	            IN	FI_SURTAX_CARD.COL51_2%TYPE	--공제받지못할매입세액_합계_세액
    , P_COL52_2	            IN	FI_SURTAX_CARD.COL52_2%TYPE	--기탁경감공제세액_전자신고세액공제_세액
    , P_COL53_2	            IN	FI_SURTAX_CARD.COL53_2%TYPE	--기타경감공제세액_전자세금계산서발급세액공제_세액
    , P_COL54_2	            IN	FI_SURTAX_CARD.COL54_2%TYPE	--기타경감공제세액_택시운송사업자경감세액_세액
    , P_COL55_2	            IN	FI_SURTAX_CARD.COL55_2%TYPE	--기타경감공제세액_현금영수증사업자세액공제_세액
    , P_COL56_2	            IN	FI_SURTAX_CARD.COL56_2%TYPE	--기타경감공제세액_기타_세액
    , P_COL57_2	            IN	FI_SURTAX_CARD.COL57_2%TYPE	--기타경감공제세액_합계_세액
    , P_COL58_1	            IN	FI_SURTAX_CARD.COL58_1%TYPE	--가산세명세_사업자미등록등_금액
    , P_COL58_2	            IN	FI_SURTAX_CARD.COL58_2%TYPE	--가산세명세_사업자미등록등_세액
    , P_COL59_1 	        IN	FI_SURTAX_CARD.COL59_1%TYPE	--가산세명세_지연발급등_금액
    , P_COL59_2	            IN	FI_SURTAX_CARD.COL59_2%TYPE	--가산세명세_지연발급등_세액
    , P_COL60_1	            IN	FI_SURTAX_CARD.COL60_1%TYPE	--가산세명세_미발급등_금액
    , P_COL60_2	            IN	FI_SURTAX_CARD.COL60_2%TYPE	--가산세명세_미발급등_세액
    , P_COL61_1	            IN	FI_SURTAX_CARD.COL61_1%TYPE	--가산세명세_다음달15일이후_금액
    , P_COL61_2	            IN	FI_SURTAX_CARD.COL61_2%TYPE	--가산세명세_다음달15일이후_세액
    , P_COL62_1	            IN	FI_SURTAX_CARD.COL62_1%TYPE	--가산세명세_과세기간다음달15일이후_금액
    , P_COL62_2	            IN	FI_SURTAX_CARD.COL62_2%TYPE	--가산세명세_과세기간다음달15일이후_세액
    , P_COL63_1	            IN	FI_SURTAX_CARD.COL63_1%TYPE	--가산세명세_세금계산서합계표제출불성실_금액
    , P_COL63_2	            IN	FI_SURTAX_CARD.COL63_2%TYPE	--가산세명세_세금계산서합계표제출불성실_세액
    , P_COL64_1	            IN	FI_SURTAX_CARD.COL64_1%TYPE	--가산세명세_신고불성실_금액
    , P_COL64_2	            IN	FI_SURTAX_CARD.COL64_2%TYPE	--가산세명세_신고불성실_세액
    , P_COL65_1	            IN	FI_SURTAX_CARD.COL65_1%TYPE	--가산세명세_납부불성싱_금액
    , P_COL65_2	            IN	FI_SURTAX_CARD.COL65_2%TYPE	--가산세명세_납부불성실_세액
    , P_COL66_1	            IN	FI_SURTAX_CARD.COL66_1%TYPE	--가산세명세_영세율과세표준신고불성실_금액
    , P_COL66_2	            IN	FI_SURTAX_CARD.COL66_2%TYPE	--가산세명세_영세율과세표준신고불성실_세액
    , P_COL67_1	            IN	FI_SURTAX_CARD.COL67_1%TYPE	--가산세명세_현금매출명세서미제출등_금액
    , P_COL67_2	            IN	FI_SURTAX_CARD.COL67_2%TYPE	--가산세명세_현금매출명세서미제출등_세액
    , P_COL68_2	            IN	FI_SURTAX_CARD.COL68_2%TYPE	--가산세명세_합계_세액
    , P_COL69_1	            IN	FI_SURTAX_CARD.COL69_1%TYPE	--면세사업수입금액_업태1
    , P_COL69_2	            IN	FI_SURTAX_CARD.COL69_2%TYPE	--면세사업수입금액_종목1
    , P_COL69_3	            IN	FI_SURTAX_CARD.COL69_3%TYPE	--면세사업수입금액_금액1
    , P_COL70_1	            IN	FI_SURTAX_CARD.COL70_1%TYPE	--면세사업수입금액_업태2
    , P_COL70_2	            IN	FI_SURTAX_CARD.COL70_2%TYPE	--면세사업수입금액_종목2
    , P_COL70_3	            IN	FI_SURTAX_CARD.COL70_3%TYPE	--면세사업수입금액_금액2
    , P_COL71_1	            IN	FI_SURTAX_CARD.COL71_1%TYPE	--면세사업수입금액_업태3
    , P_COL71_2	            IN	FI_SURTAX_CARD.COL71_2%TYPE	--면세사업수입금액_종목3
    , P_COL71_3	            IN	FI_SURTAX_CARD.COL71_3%TYPE	--면세사업수입금액_금액3
    , P_COL72	            IN	FI_SURTAX_CARD.COL72%TYPE	--면세사업수입금액_합계
    , P_COL73	            IN	FI_SURTAX_CARD.COL73%TYPE	--계산서발급금액
    , P_COL74	            IN	FI_SURTAX_CARD.COL74%TYPE	--계산서수취금액
    
    , P_R_ORIGIN_PLACE_VAT      IN  FI_SURTAX_CARD.R_ORIGIN_PLACE_VAT%TYPE  -- 원산지확인서 발급공제세액.
    , P_A_TAX_RECEIVE_DELAY_AMT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- 세금계산서지연수취금액.
    , P_A_TAX_RECEIVE_DELAY_VAT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- 세금계산서지연수취세액.
    
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --수정자
);







--거래은행 POPUP
PROCEDURE POPUP_BANK(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_BANK.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID  IN  FI_BANK.ORG_ID%TYPE  --사업부아이디
);






--거래은행지점 POPUP
PROCEDURE POPUP_BANK_BRANCH(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE     --사업부아이디
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE  --금융기관코드
);




--계좌번호 POPUP
PROCEDURE POPUP_ACCOUNT_NO(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE       --사업부아이디
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE    --금융기관코드
    , W_BANK_ID     IN  FI_BANK.BANK_ID%TYPE      --금융기관아이디
);





   PROCEDURE ROUND_TAX
           ( O_NUMBER  OUT  NUMBER
           , P_NUMBER  IN   NUMBER
           );



END FI_SURTAX_CARD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SURTAX_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SURTAX_CARD_G
Description  : 부가세신고서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 부가세신고서
Program History :
    -.부가가치세 관련 모든 자료들을 생성 후 작업한다. 작업순서상 제일 마지막에 한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-05   Leem Dong Ern(임동언)
*****************************************************************************/






--신고서생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --사업부아이디
    --, W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_OPERATING_UNIT_ID   IN  VARCHAR2                            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호; 사용안한다. 프로그램이 이미 끝난상태라 지우지지 않았을 뿐이다.
    
    --참조>수정신고는 처리할 수 있도록 틀만 만들고 실제 작업은 진행하지 않았다.
    --, W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)    
    
    , W_TITLE_1_1           IN  FI_SURTAX_CARD.TITLE_1_1%TYPE           --신고기간_시작
    , W_TITLE_1_2           IN  FI_SURTAX_CARD.TITLE_1_2%TYPE           --신고기간_종료     
    , W_CREATED_BY          IN  FI_SURTAX_CARD.CREATED_BY%TYPE          --생성자     
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부
t_SPEC_SERIAL   FI_SURTAX_CARD.SPEC_SERIAL%TYPE;  --일련번호
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);

t_COL1_1    FI_SURTAX_CARD.COL1_1%TYPE;     --과세_세금계산서발급분_금액
t_COL1_2    FI_SURTAX_CARD.COL1_2%TYPE;     --과세_세금계산서발급분_세액
t_COL4_1    FI_SURTAX_CARD.COL4_1%TYPE;     --과세_기타_금액
t_COL4_2    FI_SURTAX_CARD.COL4_2%TYPE;     --과세_기타_세액
t_COL5_1    FI_SURTAX_CARD.COL5_1%TYPE;     --영세율_세금계산서발급분_금액
t_COL6_1    FI_SURTAX_CARD.COL6_1%TYPE;     --영세율_기타_금액
t_COL10_1   FI_SURTAX_CARD.COL10_1%TYPE;    --매입_일반매입_금액
t_COL10_2   FI_SURTAX_CARD.COL10_2%TYPE;    --매입_일반매입_세액
t_COL11_1   FI_SURTAX_CARD.COL11_1%TYPE;    --매입_고정자산매입_금액
t_COL11_2   FI_SURTAX_CARD.COL11_2%TYPE;    --매입_고장자산매입_세액

t_COL14_1   FI_SURTAX_CARD.COL14_1%TYPE;    --매입_기타공제매입세액_금액
t_COL14_2   FI_SURTAX_CARD.COL14_2%TYPE;    --매입_기타공제매입세액_세액
t_COL39_1   FI_SURTAX_CARD.COL39_1%TYPE;    --기타공제_신용카드_일반매입_금액
t_COL39_2   FI_SURTAX_CARD.COL39_2%TYPE;    --기타공제_신용카드_일반매입_세액

t_COL40_1   FI_SURTAX_CARD.COL40_1%TYPE;    --기타공제_신용카드_고정자산매입_금액
t_COL40_2   FI_SURTAX_CARD.COL40_2%TYPE;    --기타공제_신용카드_고정자산매입_세액

t_COL47_1   FI_SURTAX_CARD.COL47_1%TYPE;    --기타공제_합계_금액
t_COL47_2   FI_SURTAX_CARD.COL47_2%TYPE;    --기타공제_헙계_세액

t_COL15_1   FI_SURTAX_CARD.COL15_1%TYPE;    --매입_합계_금액
t_COL15_2   FI_SURTAX_CARD.COL15_2%TYPE;    --매입_합계_세액

t_COL16_1   FI_SURTAX_CARD.COL16_1%TYPE;    --매입_공제받지못할매입세액_금액
t_COL16_2   FI_SURTAX_CARD.COL16_2%TYPE;    --매입_공제받지못할매입세액_세액
t_COL48_1   FI_SURTAX_CARD.COL48_1%TYPE;    --공제받지못할매입세액_공제받지못할_금액
t_COL48_2   FI_SURTAX_CARD.COL48_2%TYPE;    --공제받지못할매입세액_공제받지못할_세액
t_COL51_1   FI_SURTAX_CARD.COL51_1%TYPE;    --공제받지못할매입세액_합계_금액
t_COL51_2   FI_SURTAX_CARD.COL51_2%TYPE;    --공제받지못할매입세액_합계_세액

t_COL17_1   FI_SURTAX_CARD.COL17_1%TYPE;    --매입_차감계_금액
t_COL17_2   FI_SURTAX_CARD.COL17_2%TYPE;    --매입_차감계_세액
t_COL29_3   FI_SURTAX_CARD.COL29_3%TYPE;    --과세표준_금액4

t_COL74     FI_SURTAX_CARD.COL74%TYPE;    --계산서수취금액

BEGIN


    --해당 신고기간의 마감여부를 파악한다.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND OPERATING_UNIT_ID = 42                  --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    
    
    --FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_SURTAX_CARD
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND OPERATING_UNIT_ID   = W_OPERATING_UNIT_ID   --사업장아이디
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --부가세신고기간구분번호
        --AND SPEC_SERIAL         = W_SPEC_SERIAL         --일련번호
        AND VAT_MAKE_GB  = '01' --신고구분(01 : 정기신고)
    ;
    
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_SURTAX_CARD;

    --일단, 기초자료를 생성 한 후 하단에서 설정 가능한 칼럼들에 대해 UPDATE한다.
    INSERT INTO FI_SURTAX_CARD(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        , VAT_MAKE_GB   --신고구분(01 : 정기신고)
        , TITLE_1_1   --신고기간_시작
        , TITLE_1_2   --신고기간_종료
        , TITLE_2       --상호(법인명)
        , TITLE_3       --성명(대표자)
        , TITLE_4       --사업자등록번호
        , TITLE_5       --주민(법인)등록번호
        , TITLE_6       --사업장전화
        , TITLE_7       --주소지전화
        , TITLE_9       --사업장주소
        , TITLE_11      --업태
        , TITLE_12      --종목
        , TITLE_13      --업종코드    
        , TITLE_14      --작성일자
        , TITLE_15      --신고인      
        , TITLE_16      --세무서

        , COL26_1 --과세표준_업태1
        , COL26_2 --과세표준_종목1        
        , COL69_1 --면세사업수입금액_업태1
        , COL69_2 --면세사업수입금액_종목1
        , COL71_1 --면세사업수입금액_업태3
        , COL71_2 --면세사업수입금액_종목3
        , COL29_1 --과세표준_업태4
        , COL29_2 --과세표준_종목4
        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_OPERATING_UNIT_ID       --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , t_SPEC_SERIAL             --일련번호 
        
        , '01'              --신고구분(01 : 정기신고)
        , W_TITLE_1_1       --신고기간_시작
        , W_TITLE_1_2       --신고기간_종료
        , A.CORP_NAME       --상호(법인명)
        , A.PRESIDENT_NAME  --성명(대표자)
        , B.VAT_NUMBER      --사업자등록번호
        , A.LEGAL_NUMBER    --주민(법인)등록번호
        , A.TEL_NUMBER      --사업장전화
        , A.TEL_NUMBER      --주소지전화
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --사업장주소
        , B.BUSINESS_ITEM   --업태
        , B.BUSINESS_TYPE   --종목
        , B.ATTRIBUTE1      --업종코드    
        , SYSDATE           --작성일자
        , A.CORP_NAME       --신고인      
        , B.TAX_OFFICE_NAME --세무서

        , B.BUSINESS_ITEM AS COL26_1 --과세표준_업태1
        , B.BUSINESS_TYPE AS COL26_2 --과세표준_종목1        
        , B.BUSINESS_ITEM AS COL69_1 --면세사업수입금액_업태1
        , B.BUSINESS_TYPE AS COL69_2 --면세사업수입금액_종목1 
        , '수입금액제외'             --면세사업수입금액_업태3
        , B.BUSINESS_TYPE AS COL71_2 --면세사업수입금액_종목3 
        , '수입금액제외'  --과세표준_업태4
        , '관세환급외'    --과세표준_종목4
        
        , V_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , V_SYSDATE     --수정일
        , W_CREATED_BY  --수정자         
    FROM HRM_CORP_MASTER A, HRM_OPERATING_UNIT B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.CORP_ID = 65  --법인아이디
        AND A.CORP_ID = B.CORP_ID
        --AND B.OPERATING_UNIT_ID = W_OPERATING_UNIT_ID   ;
        AND B.OPERATING_UNIT_ID = 42   ;






--[과세표준및매출세액]영역의 제 값을 구한다.
--하기의 QUERY는 사실상 모두 같으며, 세무유형만 달라질 뿐이다.
--라인수만 길 뿐이지 동일한 QUERY가 반복된다.


    --(1)과세_세금계산서발급분_금액, 과세_세금계산서발급분_세액

    SELECT
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액              
    INTO t_COL1_1, t_COL1_2
    FROM FI_SLIP_LINE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND REFER11 = W_OPERATING_UNIT_ID
        AND MANAGEMENT2 = '1'   --세무유형(과세매출)    
        
        --AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
        AND ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
            )  --거래구분(매입/매출)             
        
        AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자  
    ;
        

    --(4)과세_세금계산서발급분_금액, 과세_세금계산서발급분_세액
    
    SELECT 
          NVL(SUM(DEEMED_RENT), 0)
        , NVL(ROUND(SUM(DEEMED_RENT) * 0.1), 0)
    INTO t_COL4_1, t_COL4_2
    FROM FI_BLD_AMT_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = 42
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;    
    
  

    --(5)영세율_세금계산서발급분_금액

    SELECT
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액            
    INTO t_COL5_1
    FROM FI_SLIP_LINE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND REFER11 = W_OPERATING_UNIT_ID
        AND MANAGEMENT2 = '2'   --세무유형(영세매출) 
        
        --AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
        AND ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
            )  --거래구분(매입/매출)             
        
        AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자  
    ; 


    --(6)영세율_기타_금액

    SELECT
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액            
    INTO t_COL6_1
    FROM FI_SLIP_LINE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND REFER11 = W_OPERATING_UNIT_ID
        AND MANAGEMENT2 = '3'   --세무유형(수출) 
        
        --AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
        AND ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
            )  --거래구분(매입/매출)             
        
        AND TO_DATE(REFER1) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자  
    ;
    
    

--[매입세액]영역의 제 값을 구한다.
--하기의 QUERY는 사실상 모두 같으며, 세무유형만 달라질 뿐이다.
--라인수만 길 뿐이지 동일한 QUERY가 반복된다.

    --(10), (11) ; 매입_일반매입_금액, 매입_일반매입_세액, 매입_고정자산매입_금액, 매입_고장자산매입_세액

    SELECT                
        --공급가액 - 고정자산과표
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) - 
          NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))), 0) AS COL10_1  --매입_일반매입_금액
        --세액 - 고정자산세액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) - 
          NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))), 0) AS COL10_2  --매입_일반매입_세액
        , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))), 0) AS COL11_1   --매입_고정자산매입_금액
        , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))), 0) AS COL11_2    --매입_고장자산매입_세액
    INTO t_COL10_1, t_COL10_2, t_COL11_1, t_COL11_2 
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.MANAGEMENT2 = TO_CHAR(W_OPERATING_UNIT_ID)
        AND REFER1 IN ('1', '2', '3', '5', '8')    --세무유형(과세매입,영세매입,매입세액불공제,수입,의제매입세액)
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)              
        
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자 
        AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
    ;   
    
    
    --(14) : 매입_기타공제매입세액_금액, 매입_기타공제매입세액_세액
    --(39) : 기타공제_신용카드_일반매입_금액, 기타공제_신용카드_일반매입_세액
    --(47) : 기타공제_합계_금액, 기타공제_헙계_세액

    SELECT                
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE   --고정자산과표
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --고정자산세액        
    INTO t_COL14_1, t_COL14_2, t_COL40_1, t_COL40_2
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID
        AND REFER1 IN ('6', '7')    --세무유형(카드매입,현금영수증매입)
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)              
        
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자 
        AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
    ; 
    
    
    t_COL15_1 := t_COL10_1 + t_COL11_1 + t_COL14_1; --매입_합계_금액
    t_COL15_2 := t_COL10_2 + t_COL11_2 + t_COL14_2; --매입_합계_세액
    
    
    --(16) : 매입_공제받지못할매입세액_금액, 매입_공제받지못할매입세액_세액
    --(48) : 공제받지못할매입세액_공제받지못할_금액, 공제받지못할매입세액_공제받지못할_세액
    --(51) : 공제받지못할매입세액_합계_금액, 공제받지못할매입세액_합계_세액

    SELECT                
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액   
    INTO t_COL16_1, t_COL16_2
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID
        AND REFER1 = '3'    --세무유형(매입세액불공제)
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)              
        
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자 
        AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
    ;
    

    t_COL17_1 := t_COL15_1 - t_COL16_1; --매입_차감계_금액
    t_COL17_2 := t_COL15_2 - t_COL16_2; --매입_차감계_세액




    --(74) : 계산서수취금액

    SELECT                
          SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액 
    INTO t_COL74
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID
        AND REFER1 = '4'    --세무유형(면세매입)
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)              
        
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자 
        AND TO_DATE(A.REFER2) BETWEEN W_TITLE_1_1 AND W_TITLE_1_2   --신고기준일자
    ;




    --(29)과세표준명세의 관세환급외 : 관새환급등명세서의 금액 + 부동산임대공급가액명세서의 간주임대료_보증금이자

    SELECT
        (        
            SELECT NVL(SUM(SUPPLY_AMT), 0)
            FROM FI_TARIFF_SPEC
            WHERE SOB_ID = 10
                AND ORG_ID = 101
                AND OPERATING_UNIT_ID = 42
                AND VAT_MNG_SERIAL = 2
        ) +
        (
            SELECT NVL(SUM(DEEMED_RENT), 0)
            FROM FI_BLD_AMT_SPEC
            WHERE SOB_ID = 10
                AND ORG_ID = 101
                AND OPERATING_UNIT_ID = 42
                AND VAT_MNG_SERIAL = 2
        )
    INTO t_COL29_3
    FROM DUAL;




    UPDATE FI_SURTAX_CARD
    SET   COL1_1 = t_COL1_1   --과세_세금계산서발급분_금액
        , COL1_2 = t_COL1_2   --과세_세금계산서발급분_세액    
        , COL4_1 = t_COL4_1   --과세_기타_금액
        , COL4_2 = t_COL4_2   --과세_기타_세액
        , COL5_1 = t_COL5_1   --영세율_세금계산서발급분_금액
        , COL6_1 = t_COL6_1   --영세율_기타_금액
        
        , COL9_1 = t_COL1_1 + t_COL4_1 + t_COL5_1 + t_COL6_1    --합계_금액
        , COL30 = t_COL1_1 + t_COL4_1 + t_COL5_1 + t_COL6_1     --과세표준_합계
        , COL9_2 = t_COL1_2 + t_COL4_2  --합계_세액
        
        , COL10_1 = t_COL10_1   --매입_일반매입_금액
        , COL10_2 = t_COL10_2   --매입_일반매입_세액
        , COL11_1 = t_COL11_1   --매입_고정자산매입_금액
        , COL11_2 = t_COL11_2   --매입_고장자산매입_세액 
        
        , COL14_1 = t_COL14_1   --매입_기타공제매입세액_금액
        , COL14_2 = t_COL14_2   --매입_기타공제매입세액_세액
        
        , COL39_1 = t_COL14_1 - t_COL40_1   --기타공제_신용카드_일반매입_금액
        , COL39_2 = t_COL14_2 - t_COL40_2  --기타공제_신용카드_일반매입_세액
        , COL40_1 = t_COL40_1   --기타공제_신용카드_고정자산매입_금액
        , COL40_2 = t_COL40_2   --기타공제_신용카드_고정자산매입_세액                              
        
        , COL47_1 = t_COL14_1   --기타공제_합계_금액
        , COL47_2 = t_COL14_2   --기타공제_헙계_세액 
        
        , COL15_1 = t_COL15_1   --매입_합계_금액
        , COL15_2 = t_COL15_2   --매입_합계_세액        
        
        , COL16_1 = t_COL16_1   --매입_공제받지못할매입세액_금액
        , COL16_2 = t_COL16_2   --매입_공제받지못할매입세액_세액
        , COL48_1 = t_COL16_1   --공제받지못할매입세액_공제받지못할_금액
        , COL48_2 = t_COL16_2   --공제받지못할매입세액_공제받지못할_세액
        , COL51_1 = t_COL16_1   --공제받지못할매입세액_합계_금액
        , COL51_2 = t_COL16_2   --공제받지못할매입세액_합계_세액
        
        , COL17_1 = t_COL17_1   --매입_차감계_금액
        , COL17_2 = t_COL17_2   --매입_차감계_세액
        
        , COL_DA = (t_COL1_2 + t_COL4_2) - (t_COL15_2 - t_COL16_2)   --납부세액
        , COL25 = (t_COL1_2 + t_COL4_2) - (t_COL15_2 - t_COL16_2)   --차가감하여납부할세액
        
        , COL29_3 = t_COL29_3 --과세표준_금액4
        
        --COL30 = t_COL1_1 + t_COL4_1 + t_COL5_1 + t_COL6_1     --과세표준_합계
        , COL26_3 = (t_COL1_1 + t_COL4_1 + t_COL5_1 + t_COL6_1) - t_COL29_3
        
        , COL74 = t_COL74   --계산서수취금액
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND SPEC_SERIAL = t_SPEC_SERIAL
    ;


END CREATE_SURTAX_CARD;





--조회 및 출력
PROCEDURE LIST_SURTAX_CARD(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        --참조>수정신고는 처리할 수 있도록 틀만 만들고 실제 작업은 진행하지 않았다.
        , VAT_MAKE_GB	    --신고구분(01 : 정기신고, 02 : 수정신고)
        
        , GUBUN_1	--신고서구분_예정
        , GUBUN_2	--신고서구분_확정
        , GUBUN_3	--신고서구분_기한후과세표준
        , GUBUN_4	--신고서구분_영세율등조기환급
        
        , TITLE_1_1	--신고기간_시작
        , TITLE_1_2	--신고기간_종료
        , TO_CHAR(TITLE_1_2, 'YYYY') || '  년   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(TITLE_1_2, 'MM')) <= 6 THEN '1  기   ( '
            ELSE '2  기   ( '
          END
          || TO_CHAR(TITLE_1_1, 'MM') || ' 월 ' || TO_CHAR(TITLE_1_1, 'DD')  || ' 일 ~ '
          || TO_CHAR(TITLE_1_2, 'MM') || ' 월 ' || TO_CHAR(TITLE_1_2, 'DD') || ' 일 )'
          AS FISCAL_YEAR   --신고기간_출력용    
            
        , TITLE_2	--상호
        , TITLE_3	--성명
        
        , TITLE_4	--사업자등록번호
        --출력용 사업자등록번호
        , SUBSTR(TITLE_4, 1, 1) AS TITLE_4_01
        , SUBSTR(TITLE_4, 2, 1) AS TITLE_4_02
        , SUBSTR(TITLE_4, 3, 1) AS TITLE_4_03
        , SUBSTR(TITLE_4, 5, 1) AS TITLE_4_04
        , SUBSTR(TITLE_4, 6, 1) AS TITLE_4_05
        , SUBSTR(TITLE_4, 8, 1) AS TITLE_4_06
        , SUBSTR(TITLE_4, 9, 1) AS TITLE_4_07
        , SUBSTR(TITLE_4, 10, 1) AS TITLE_4_08
        , SUBSTR(TITLE_4, 11, 1) AS TITLE_4_09
        , SUBSTR(TITLE_4, 12, 1) AS TITLE_4_10
        
        , TITLE_5	--법인등록번호
        , TITLE_6	--사업장전화
        , TITLE_7	--주소지전화
        , TITLE_8	--휴대전화
        , TITLE_9	--사업장주소
        , TITLE_10	--전자우편주소
        , TITLE_11	--업태
        , TITLE_12	--종목
        
        , TITLE_13	--업종코드
        --출력용 업종코드
        , SUBSTR(TITLE_13, 1, 1) AS TITLE_13_1
        , SUBSTR(TITLE_13, 2, 1) AS TITLE_13_2
        , SUBSTR(TITLE_13, 3, 1) AS TITLE_13_3
        , SUBSTR(TITLE_13, 4, 1) AS TITLE_13_4
        , SUBSTR(TITLE_13, 5, 1) AS TITLE_13_5
        , SUBSTR(TITLE_13, 6, 1) AS TITLE_13_6
        
        , TITLE_14	--작성일자
        , TO_CHAR(TITLE_14, 'YYYY') || ' 년   '
          || TO_NUMBER(TO_CHAR(TITLE_14, 'MM')) || ' 월   ' 
          || TO_NUMBER(TO_CHAR(TITLE_14, 'DD'))  || ' 일'
          AS TITLE_14_PRINT	--출력용 작성일자    
        
        , TITLE_15	--신고인
        , TITLE_16	--세무서
        
        , COL1_1	--과세_세금계산서발급분_금액
        , COL1_2	--과세_세금계산서발급분_세액
        , COL2_1	--과세_매입자발행세금계산서_금액
        , COL2_2	--과세_매입자발행세금계산서_세액
        , COL3_1	--과세_신용카드_현금영수증발행분_금액
        , COL3_2	--과세_신용카드_현금영수증발행분_세액
        , COL4_1	--과세_기타_금액
        , COL4_2	--과세_기타_세액
        , COL5_1	--영세율_세금계산서발급분_금액
        , COL6_1	--영세율_기타_금액
        , COL7_1	--예정신고누락분_금액
        , COL7_2	--예정신고누락분_세액
        , COL8_2	--대손세액가감_세액
        , COL9_1	--합계_금액
        , COL9_2	--합계_세액
        , COL10_1	--매입_일반매입_금액
        , COL10_2	--매입_일반매입_세액
        , COL11_1	--매입_고정자산매입_금액
        , COL11_2	--매입_고장자산매입_세액
        , COL12_1	--매입_예정신고누락분_금액
        , COL12_2	--매입_예정신고누락분_세액
        , COL13_1	--매입_매입자발행세금계산서_금액
        , COL13_2	--매입_매입자발행세금계산서_세액
        , COL14_1	--매입_기타공제매입세액_금액
        , COL14_2	--매입_기타공제매입세액_세액
        , COL15_1	--매입_합계_금액
        , COL15_2	--매입_합계_세액
        , COL16_1	--매입_공제받지못할매입세액_금액
        , COL16_2	--매입_공제받지못할매입세액_세액
        , COL17_1	--매입_차감계_금액
        , COL17_2	--매입_차감계_세액
        , COL_DA	--납부세액
        , COL18_2	--기타경감공제세액
        , COL19_2	--신용카드매출전표등발행공제등
        , COL20_2	--경감공제_합계
        , COL21_2	--예정신고미환급세액
        , COL22_2	--예정고지세액
        , COL23_2	--금지금_매입자_납부특례_기납부세액
        , COL24_2	--가산세액계
        , COL25	    --차가감하여납부할세액
        
        , DEAL_BANK	        --거래은행
        , DEAL_BANK_CD	    --거래은행코드
        , DEAL_BRANCH	    --거래지점
        , DEAL_BRANCH_ID	--거래지점코드
        , ACC_NO	        --계좌번호
        , CLOSURE_DATE	    --폐업일
        , DECODE(CLOSURE_DATE, NULL, NULL, '', NULL, 
              TO_CHAR(CLOSURE_DATE, 'YYYY') || '년 '
              || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'MM')) || '월   ' 
              || TO_NUMBER(TO_CHAR(CLOSURE_DATE, 'DD'))  || '일'    
          ) AS CLOSURE_DATE_PRINT	--출력용 폐업일       
        
        , CLOSURE_REASON	--폐업사유
        
        , COL26_1	--과세표준_업태1
        , COL26_2	--과세표준_종목1
        , COL26_3	--과세표준_금액1
        , COL27_1	--과세표준_업태2
        , COL27_2	--과세표준_종목2
        , COL27_3	--과세표준_금액2
        , COL28_1	--과세표준_업태3
        , COL28_2	--과세표준_종목3
        , COL28_3	--과세표준_금액3
        , COL29_1	--과세표준_업태4
        , COL29_2	--과세표준_종목4
        , COL29_3	--과세표준_금액4
        , COL30	    --과세표준_합계
        
        , COL31_1	--예정신고_매출_과세_세금계산서_금액
        , COL31_2	--예정신고_매출_과세_세금계산서_세액
        , COL32_1	--예정신고_매출_과세_기타_금액
        , COL32_2	--예정신고_매출_과세_기타_세액
        , COL33_1	--예정신고_매출_영세율_세금계산서
        , COL34_1	--예정신고_매출_영세율_기타
        , COL35_1	--예정신고_매출_합계_금액
        , COL35_2	--예정신고_매출_합계_세액
        , COL36_1	--예정신고_매입_세금계산서_금액
        , COL36_2	--예정신고_매입_세금계산서_세액
        , COL37_1	--예정신고_매입_기타공제매입세액_금액
        , COL37_2	--예정신고_매입_기타공제매입세액_세액
        , COL38_1	--예정신고_매입_합계_금액
        , COL38_2	--예정신고_매입_합계_세액
        
        , COL39_1	--기타공제_신용카드_일반매입_금액
        , COL39_2	--기타공제_신용카드_일반매입_세액
        , COL40_1	--기타공제_신용카드_고정자산매입_금액
        , COL40_2	--기타공제_신용카드_고정자산매입_세액
        , COL41_1	--기타공제_의제매입세액_금액
        , COL41_2	--기타공제_의제매입세액_세액
        , COL42_1	--기타공제_재활용폐자원등매입세액_금액
        , COL42_2	--기타공제_재활용폐자원등매입세액_세액
        , COL43_1	--기타공제_고금의제매입세액_금액
        , COL43_2	--기타공제_고금의제매입세액_세액
        , COL44_2	--기타공제_과세사업전환매입세액_세액
        , COL45_2	--기타공제_재고매입세액_세액
        , COL46_2	--기타공제_변제대손세액_세액
        , COL47_1	--기타공제_합계_금액
        , COL47_2	--기타공제_헙계_세액
        
        , COL48_1	--공제받지못할매입세액_공제받지못할_금액
        , COL48_2	--공제받지못할매입세액_공제받지못할_세액
        , COL49_1	--공제받지못할매입세액_공통매입세액면세_금액
        , COL49_2	--공제받지못할매입세액_공통매입세액면세_세액
        , COL50_1	--공제받지못할매입세액_대손처분받은세액_금액
        , COL50_2	--공제받지못할매입세액_대손처분받은세액_세액
        , COL51_1	--공제받지못할매입세액_합계_금액
        , COL51_2	--공제받지못할매입세액_합계_세액
        
        , COL52_2	--기탁경감공제세액_전자신고세액공제_세액
        , COL53_2	--기타경감공제세액_전자세금계산서발급세액공제_세액
        , COL54_2	--기타경감공제세액_택시운송사업자경감세액_세액
        , COL55_2	--기타경감공제세액_현금영수증사업자세액공제_세액
        , COL56_2	--기타경감공제세액_기타_세액
        , COL57_2	--기타경감공제세액_합계_세액
        
        , COL58_1	--가산세명세_사업자미등록등_금액
        , COL58_2	--가산세명세_사업자미등록등_세액
        , COL59_1	--가산세명세_지연발급등_금액
        , COL59_2	--가산세명세_지연발급등_세액
        , COL60_1	--가산세명세_미발급등_금액
        , COL60_2	--가산세명세_미발급등_세액
        , COL61_1	--가산세명세_다음달15일이후_금액
        , COL61_2	--가산세명세_다음달15일이후_세액
        , COL62_1	--가산세명세_과세기간다음달15일이후_금액
        , COL62_2	--가산세명세_과세기간다음달15일이후_세액
        , COL63_1	--가산세명세_세금계산서합계표제출불성실_금액
        , COL63_2	--가산세명세_세금계산서합계표제출불성실_세액
        , COL64_1	--가산세명세_신고불성실_금액
        , COL64_2	--가산세명세_신고불성실_세액
        , COL65_1	--가산세명세_납부불성싱_금액
        , COL65_2	--가산세명세_납부불성실_세액
        , COL66_1	--가산세명세_영세율과세표준신고불성실_금액
        , COL66_2	--가산세명세_영세율과세표준신고불성실_세액
        , COL67_1	--가산세명세_현금매출명세서미제출등_금액
        , COL67_2	--가산세명세_현금매출명세서미제출등_세액
        , COL68_2	--가산세명세_합계_세액
        
        , COL69_1	--면세사업수입금액_업태1
        , COL69_2	--면세사업수입금액_종목1
        , COL69_3	--면세사업수입금액_금액1
        , COL70_1	--면세사업수입금액_업태2
        , COL70_2	--면세사업수입금액_종목2
        , COL70_3	--면세사업수입금액_금액2
        , COL71_1	--면세사업수입금액_업태3
        , COL71_2	--면세사업수입금액_종목3
        , COL71_3	--면세사업수입금액_금액3
        , COL72	    --면세사업수입금액_합계
        
        , COL73	--계산서발급금액
        , COL74	--계산서수취금액
        , R_ORIGIN_PLACE_VAT  -- 경감공제세액 - 원산지확인서 발급공제세액
        , A_TAX_RECEIVE_DELAY_AMT  -- 가산세명세 - 세금계산서 지연수취금액
        , A_TAX_RECEIVE_DELAY_VAT  -- 가산세명세 - 세금계산서 지연수취세액
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = NVL(W_VAT_MAKE_GB, '01') --신고구분(01 : 정기신고)
    ;


END LIST_SURTAX_CARD;







--UPDATE
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , P_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호    
    , P_VAT_MAKE_GB	        IN	FI_SURTAX_CARD.VAT_MAKE_GB%TYPE	        --신고구분
    
    , P_GUBUN_1	            IN	FI_SURTAX_CARD.GUBUN_1%TYPE	    --신고서구분_예정
    , P_GUBUN_2	            IN	FI_SURTAX_CARD.GUBUN_2%TYPE	    --신고서구분_확정
    , P_GUBUN_3	            IN	FI_SURTAX_CARD.GUBUN_3%TYPE	    --신고서구분_기한후과세표준
    , P_GUBUN_4	            IN	FI_SURTAX_CARD.GUBUN_4%TYPE	    --신고서구분_영세율등조기환급
    , P_TITLE_1_1	        IN	FI_SURTAX_CARD.TITLE_1_1%TYPE	--신고기간_시작
    , P_TITLE_1_2	        IN	FI_SURTAX_CARD.TITLE_1_2%TYPE	--신고기간_종료
    , P_TITLE_2	            IN	FI_SURTAX_CARD.TITLE_2%TYPE	    --상호
    , P_TITLE_3	            IN	FI_SURTAX_CARD.TITLE_3%TYPE	    --성명
    , P_TITLE_4	            IN	FI_SURTAX_CARD.TITLE_4%TYPE	    --사업자등록번호
    , P_TITLE_5	            IN	FI_SURTAX_CARD.TITLE_5%TYPE	    --법인등록번호
    , P_TITLE_6	            IN	FI_SURTAX_CARD.TITLE_6%TYPE	    --사업장전화
    , P_TITLE_7	            IN	FI_SURTAX_CARD.TITLE_7%TYPE	    --주소지전화
    , P_TITLE_8	            IN	FI_SURTAX_CARD.TITLE_8%TYPE	    --휴대전화
    , P_TITLE_9	            IN	FI_SURTAX_CARD.TITLE_9%TYPE	    --사업장주소
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	--전자우편주소
    , P_TITLE_11	        IN	FI_SURTAX_CARD.TITLE_11%TYPE	--업태
    , P_TITLE_12	        IN	FI_SURTAX_CARD.TITLE_12%TYPE	--종목
    , P_TITLE_13	        IN	FI_SURTAX_CARD.TITLE_13%TYPE	--업종코드
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	--작성일자
    , P_TITLE_15	        IN	FI_SURTAX_CARD.TITLE_15%TYPE	--신고인
    , P_TITLE_16	        IN	FI_SURTAX_CARD.TITLE_16%TYPE	--세무서
    , P_COL1_1	            IN	FI_SURTAX_CARD.COL1_1%TYPE	--과세_세금계산서발급분_금액
    , P_COL1_2	            IN	FI_SURTAX_CARD.COL1_2%TYPE	--과세_세금계산서발급분_세액
    , P_COL2_1	            IN	FI_SURTAX_CARD.COL2_1%TYPE	--과세_매입자발행세금계산서_금액
    , P_COL2_2	            IN	FI_SURTAX_CARD.COL2_2%TYPE	--과세_매입자발행세금계산서_세액
    , P_COL3_1	            IN	FI_SURTAX_CARD.COL3_1%TYPE	--과세_신용카드_현금영수증발행분_금액
    , P_COL3_2	            IN	FI_SURTAX_CARD.COL3_2%TYPE	--과세_신용카드_현금영수증발행분_세액
    , P_COL4_1	            IN	FI_SURTAX_CARD.COL4_1%TYPE	--과세_기타_금액
    , P_COL4_2	            IN	FI_SURTAX_CARD.COL4_2%TYPE	--과세_기타_세액
    , P_COL5_1	            IN	FI_SURTAX_CARD.COL5_1%TYPE	--영세율_세금계산서발급분_금액
    , P_COL6_1	            IN	FI_SURTAX_CARD.COL6_1%TYPE	--영세율_기타_금액
    , P_COL7_1	            IN	FI_SURTAX_CARD.COL7_1%TYPE	--예정신고누락분_금액
    , P_COL7_2	            IN	FI_SURTAX_CARD.COL7_2%TYPE	--예정신고누락분_세액
    , P_COL8_2	            IN	FI_SURTAX_CARD.COL8_2%TYPE	--대손세액가감_세액
    , P_COL9_1	            IN	FI_SURTAX_CARD.COL9_1%TYPE	--합계_금액
    , P_COL9_2	            IN	FI_SURTAX_CARD.COL9_2%TYPE	--합계_세액
    , P_COL10_1	            IN	FI_SURTAX_CARD.COL10_1%TYPE	--매입_일반매입_금액
    , P_COL10_2	            IN	FI_SURTAX_CARD.COL10_2%TYPE	--매입_일반매입_세액
    , P_COL11_1	            IN	FI_SURTAX_CARD.COL11_1%TYPE	--매입_고정자산매입_금액
    , P_COL11_2	            IN	FI_SURTAX_CARD.COL11_2%TYPE	--매입_고장자산매입_세액
    , P_COL12_1	            IN	FI_SURTAX_CARD.COL12_1%TYPE	--매입_예정신고누락분_금액
    , P_COL12_2	            IN	FI_SURTAX_CARD.COL12_2%TYPE	--매입_예정신고누락분_세액
    , P_COL13_1	            IN	FI_SURTAX_CARD.COL13_1%TYPE	--매입_매입자발행세금계산서_금액
    , P_COL13_2	            IN	FI_SURTAX_CARD.COL13_2%TYPE	--매입_매입자발행세금계산서_세액
    , P_COL14_1	            IN	FI_SURTAX_CARD.COL14_1%TYPE	--매입_기타공제매입세액_금액
    , P_COL14_2	            IN	FI_SURTAX_CARD.COL14_2%TYPE	--매입_기타공제매입세액_세액
    , P_COL15_1	            IN	FI_SURTAX_CARD.COL15_1%TYPE	--매입_합계_금액
    , P_COL15_2	            IN	FI_SURTAX_CARD.COL15_2%TYPE	--매입_합계_세액
    , P_COL16_1	            IN	FI_SURTAX_CARD.COL16_1%TYPE	--매입_공제받지못할매입세액_금액
    , P_COL16_2	            IN	FI_SURTAX_CARD.COL16_2%TYPE	--매입_공제받지못할매입세액_세액
    , P_COL17_1	            IN	FI_SURTAX_CARD.COL17_1%TYPE	--매입_차감계_금액
    , P_COL17_2	            IN	FI_SURTAX_CARD.COL17_2%TYPE	--매입_차감계_세액
    , P_COL_DA	            IN	FI_SURTAX_CARD.COL_DA%TYPE	--납부세액
    , P_COL18_2	            IN	FI_SURTAX_CARD.COL18_2%TYPE	--기타경감공제세액
    , P_COL19_2	            IN	FI_SURTAX_CARD.COL19_2%TYPE	--신용카드매출전표등발행공제등
    , P_COL20_2	            IN	FI_SURTAX_CARD.COL20_2%TYPE	--경감공제_합계
    , P_COL21_2	            IN	FI_SURTAX_CARD.COL21_2%TYPE	--예정신고미환급세액
    , P_COL22_2	            IN	FI_SURTAX_CARD.COL22_2%TYPE	--예정고지세액
    , P_COL23_2	            IN	FI_SURTAX_CARD.COL23_2%TYPE	--금지금_매입자_납부특례_기납부세액
    , P_COL24_2	            IN	FI_SURTAX_CARD.COL24_2%TYPE	--가산세액계
    , P_COL25	            IN	FI_SURTAX_CARD.COL25%TYPE	--차가감하여납부할세액
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	    --거래은행
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	--거래은행코드
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	    --거래지점
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	--거래지점코드
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	        --계좌번호
    , P_CLOSURE_DATE	    IN	FI_SURTAX_CARD.CLOSURE_DATE%TYPE	--폐업일
    , P_CLOSURE_REASON	    IN	FI_SURTAX_CARD.CLOSURE_REASON%TYPE	--폐업사유
    , P_COL26_1	            IN	FI_SURTAX_CARD.COL26_1%TYPE	--과세표준_업태1
    , P_COL26_2	            IN	FI_SURTAX_CARD.COL26_2%TYPE	--과세표준_종목1
    , P_COL26_3	            IN	FI_SURTAX_CARD.COL26_3%TYPE	--과세표준_금액1
    , P_COL27_1	            IN	FI_SURTAX_CARD.COL27_1%TYPE	--과세표준_업태2
    , P_COL27_2	            IN	FI_SURTAX_CARD.COL27_2%TYPE	--과세표준_종목2
    , P_COL27_3	            IN	FI_SURTAX_CARD.COL27_3%TYPE	--과세표준_금액2
    , P_COL28_1	            IN	FI_SURTAX_CARD.COL28_1%TYPE	--과세표준_업태3
    , P_COL28_2	            IN	FI_SURTAX_CARD.COL28_2%TYPE	--과세표준_종목3
    , P_COL28_3	            IN	FI_SURTAX_CARD.COL28_3%TYPE	--과세표준_금액3
    , P_COL29_1	            IN	FI_SURTAX_CARD.COL29_1%TYPE	--과세표준_업태4
    , P_COL29_2	            IN	FI_SURTAX_CARD.COL29_2%TYPE	--과세표준_종목4
    , P_COL29_3	            IN	FI_SURTAX_CARD.COL29_3%TYPE	--과세표준_금액4
    , P_COL30	            IN	FI_SURTAX_CARD.COL30%TYPE	--과세표준_합계
    , P_COL31_1	            IN	FI_SURTAX_CARD.COL31_1%TYPE	--예정신고_매출_과세_세금계산서_금액
    , P_COL31_2	            IN	FI_SURTAX_CARD.COL31_2%TYPE	--예정신고_매출_과세_세금계산서_세액
    , P_COL32_1	            IN	FI_SURTAX_CARD.COL32_1%TYPE	--예정신고_매출_과세_기타_금액
    , P_COL32_2	            IN	FI_SURTAX_CARD.COL32_2%TYPE	--예정신고_매출_과세_기타_세액
    , P_COL33_1	            IN	FI_SURTAX_CARD.COL33_1%TYPE	--예정신고_매출_영세율_세금계산서
    , P_COL34_1	            IN	FI_SURTAX_CARD.COL34_1%TYPE	--예정신고_매출_영세율_기타
    , P_COL35_1	            IN	FI_SURTAX_CARD.COL35_1%TYPE	--예정신고_매출_합계_금액
    , P_COL35_2	            IN	FI_SURTAX_CARD.COL35_2%TYPE	--예정신고_매출_합계_세액
    , P_COL36_1	            IN	FI_SURTAX_CARD.COL36_1%TYPE	--예정신고_매입_세금계산서_금액
    , P_COL36_2	            IN	FI_SURTAX_CARD.COL36_2%TYPE	--예정신고_매입_세금계산서_세액
    , P_COL37_1	            IN	FI_SURTAX_CARD.COL37_1%TYPE	--예정신고_매입_기타공제매입세액_금액
    , P_COL37_2	            IN	FI_SURTAX_CARD.COL37_2%TYPE	--예정신고_매입_기타공제매입세액_세액
    , P_COL38_1	            IN	FI_SURTAX_CARD.COL38_1%TYPE	--예정신고_매입_합계_금액
    , P_COL38_2	            IN	FI_SURTAX_CARD.COL38_2%TYPE	--예정신고_매입_합계_세액
    , P_COL39_1	            IN	FI_SURTAX_CARD.COL39_1%TYPE	--기타공제_신용카드_일반매입_금액
    , P_COL39_2	            IN	FI_SURTAX_CARD.COL39_2%TYPE	--기타공제_신용카드_일반매입_세액
    , P_COL40_1	            IN	FI_SURTAX_CARD.COL40_1%TYPE	--기타공제_신용카드_고정자산매입_금액
    , P_COL40_2	            IN	FI_SURTAX_CARD.COL40_2%TYPE	--기타공제_신용카드_고정자산매입_세액
    , P_COL41_1	            IN	FI_SURTAX_CARD.COL41_1%TYPE	--기타공제_의제매입세액_금액
    , P_COL41_2	            IN	FI_SURTAX_CARD.COL41_2%TYPE	--기타공제_의제매입세액_세액
    , P_COL42_1	            IN	FI_SURTAX_CARD.COL42_1%TYPE	--기타공제_재활용폐자원등매입세액_금액
    , P_COL42_2	            IN	FI_SURTAX_CARD.COL42_2%TYPE	--기타공제_재활용폐자원등매입세액_세액
    , P_COL43_1	            IN	FI_SURTAX_CARD.COL43_1%TYPE	--기타공제_고금의제매입세액_금액
    , P_COL43_2	            IN	FI_SURTAX_CARD.COL43_2%TYPE	--기타공제_고금의제매입세액_세액
    , P_COL44_2	            IN	FI_SURTAX_CARD.COL44_2%TYPE	--기타공제_과세사업전환매입세액_세액
    , P_COL45_2	            IN	FI_SURTAX_CARD.COL45_2%TYPE	--기타공제_재고매입세액_세액
    , P_COL46_2	            IN	FI_SURTAX_CARD.COL46_2%TYPE	--기타공제_변제대손세액_세액
    , P_COL47_1	            IN	FI_SURTAX_CARD.COL47_1%TYPE	--기타공제_합계_금액
    , P_COL47_2	            IN	FI_SURTAX_CARD.COL47_2%TYPE	--기타공제_헙계_세액
    , P_COL48_1	            IN	FI_SURTAX_CARD.COL48_1%TYPE	--공제받지못할매입세액_공제받지못할_금액
    , P_COL48_2	            IN	FI_SURTAX_CARD.COL48_2%TYPE	--공제받지못할매입세액_공제받지못할_세액
    , P_COL49_1	            IN	FI_SURTAX_CARD.COL49_1%TYPE	--공제받지못할매입세액_공통매입세액면세_금액
    , P_COL49_2	            IN	FI_SURTAX_CARD.COL49_2%TYPE	--공제받지못할매입세액_공통매입세액면세_세액
    , P_COL50_1	            IN	FI_SURTAX_CARD.COL50_1%TYPE	--공제받지못할매입세액_대손처분받은세액_금액
    , P_COL50_2	            IN	FI_SURTAX_CARD.COL50_2%TYPE	--공제받지못할매입세액_대손처분받은세액_세액
    , P_COL51_1	            IN	FI_SURTAX_CARD.COL51_1%TYPE	--공제받지못할매입세액_합계_금액
    , P_COL51_2	            IN	FI_SURTAX_CARD.COL51_2%TYPE	--공제받지못할매입세액_합계_세액
    , P_COL52_2	            IN	FI_SURTAX_CARD.COL52_2%TYPE	--기탁경감공제세액_전자신고세액공제_세액
    , P_COL53_2	            IN	FI_SURTAX_CARD.COL53_2%TYPE	--기타경감공제세액_전자세금계산서발급세액공제_세액
    , P_COL54_2	            IN	FI_SURTAX_CARD.COL54_2%TYPE	--기타경감공제세액_택시운송사업자경감세액_세액
    , P_COL55_2	            IN	FI_SURTAX_CARD.COL55_2%TYPE	--기타경감공제세액_현금영수증사업자세액공제_세액
    , P_COL56_2	            IN	FI_SURTAX_CARD.COL56_2%TYPE	--기타경감공제세액_기타_세액
    , P_COL57_2	            IN	FI_SURTAX_CARD.COL57_2%TYPE	--기타경감공제세액_합계_세액
    , P_COL58_1	            IN	FI_SURTAX_CARD.COL58_1%TYPE	--가산세명세_사업자미등록등_금액
    , P_COL58_2	            IN	FI_SURTAX_CARD.COL58_2%TYPE	--가산세명세_사업자미등록등_세액
    , P_COL59_1 	        IN	FI_SURTAX_CARD.COL59_1%TYPE	--가산세명세_지연발급등_금액
    , P_COL59_2	            IN	FI_SURTAX_CARD.COL59_2%TYPE	--가산세명세_지연발급등_세액
    , P_COL60_1	            IN	FI_SURTAX_CARD.COL60_1%TYPE	--가산세명세_미발급등_금액
    , P_COL60_2	            IN	FI_SURTAX_CARD.COL60_2%TYPE	--가산세명세_미발급등_세액
    , P_COL61_1	            IN	FI_SURTAX_CARD.COL61_1%TYPE	--가산세명세_다음달15일이후_금액
    , P_COL61_2	            IN	FI_SURTAX_CARD.COL61_2%TYPE	--가산세명세_다음달15일이후_세액
    , P_COL62_1	            IN	FI_SURTAX_CARD.COL62_1%TYPE	--가산세명세_과세기간다음달15일이후_금액
    , P_COL62_2	            IN	FI_SURTAX_CARD.COL62_2%TYPE	--가산세명세_과세기간다음달15일이후_세액
    , P_COL63_1	            IN	FI_SURTAX_CARD.COL63_1%TYPE	--가산세명세_세금계산서합계표제출불성실_금액
    , P_COL63_2	            IN	FI_SURTAX_CARD.COL63_2%TYPE	--가산세명세_세금계산서합계표제출불성실_세액
    , P_COL64_1	            IN	FI_SURTAX_CARD.COL64_1%TYPE	--가산세명세_신고불성실_금액
    , P_COL64_2	            IN	FI_SURTAX_CARD.COL64_2%TYPE	--가산세명세_신고불성실_세액
    , P_COL65_1	            IN	FI_SURTAX_CARD.COL65_1%TYPE	--가산세명세_납부불성싱_금액
    , P_COL65_2	            IN	FI_SURTAX_CARD.COL65_2%TYPE	--가산세명세_납부불성실_세액
    , P_COL66_1	            IN	FI_SURTAX_CARD.COL66_1%TYPE	--가산세명세_영세율과세표준신고불성실_금액
    , P_COL66_2	            IN	FI_SURTAX_CARD.COL66_2%TYPE	--가산세명세_영세율과세표준신고불성실_세액
    , P_COL67_1	            IN	FI_SURTAX_CARD.COL67_1%TYPE	--가산세명세_현금매출명세서미제출등_금액
    , P_COL67_2	            IN	FI_SURTAX_CARD.COL67_2%TYPE	--가산세명세_현금매출명세서미제출등_세액
    , P_COL68_2	            IN	FI_SURTAX_CARD.COL68_2%TYPE	--가산세명세_합계_세액
    , P_COL69_1	            IN	FI_SURTAX_CARD.COL69_1%TYPE	--면세사업수입금액_업태1
    , P_COL69_2	            IN	FI_SURTAX_CARD.COL69_2%TYPE	--면세사업수입금액_종목1
    , P_COL69_3	            IN	FI_SURTAX_CARD.COL69_3%TYPE	--면세사업수입금액_금액1
    , P_COL70_1	            IN	FI_SURTAX_CARD.COL70_1%TYPE	--면세사업수입금액_업태2
    , P_COL70_2	            IN	FI_SURTAX_CARD.COL70_2%TYPE	--면세사업수입금액_종목2
    , P_COL70_3	            IN	FI_SURTAX_CARD.COL70_3%TYPE	--면세사업수입금액_금액2
    , P_COL71_1	            IN	FI_SURTAX_CARD.COL71_1%TYPE	--면세사업수입금액_업태3
    , P_COL71_2	            IN	FI_SURTAX_CARD.COL71_2%TYPE	--면세사업수입금액_종목3
    , P_COL71_3	            IN	FI_SURTAX_CARD.COL71_3%TYPE	--면세사업수입금액_금액3
    , P_COL72	            IN	FI_SURTAX_CARD.COL72%TYPE	--면세사업수입금액_합계
    , P_COL73	            IN	FI_SURTAX_CARD.COL73%TYPE	--계산서발급금액
    , P_COL74	            IN	FI_SURTAX_CARD.COL74%TYPE	--계산서수취금액
    
    , P_R_ORIGIN_PLACE_VAT      IN  FI_SURTAX_CARD.R_ORIGIN_PLACE_VAT%TYPE  -- 원산지확인서 발급공제세액.
    , P_A_TAX_RECEIVE_DELAY_AMT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- 세금계산서지연수취금액.
    , P_A_TAX_RECEIVE_DELAY_VAT IN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT%TYPE  -- 세금계산서지연수취세액.
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    UPDATE FI_SURTAX_CARD
    SET
          GUBUN_1	= P_GUBUN_1	    --신고서구분_예정
        , GUBUN_2	= P_GUBUN_2	    --신고서구분_확정
        , GUBUN_3	= P_GUBUN_3	    --신고서구분_기한후과세표준
        , GUBUN_4	= P_GUBUN_4	    --신고서구분_영세율등조기환급
        , TITLE_1_1	= P_TITLE_1_1	--신고기간_시작
        , TITLE_1_2	= P_TITLE_1_2	--신고기간_종료
        , TITLE_2	= P_TITLE_2	    --상호
        , TITLE_3	= P_TITLE_3	    --성명
        , TITLE_4	= P_TITLE_4	    --사업자등록번호
        , TITLE_5	= P_TITLE_5	    --법인등록번호
        , TITLE_6	= P_TITLE_6	    --사업장전화
        , TITLE_7	= P_TITLE_7	    --주소지전화
        , TITLE_8	= P_TITLE_8	    --휴대전화
        , TITLE_9	= P_TITLE_9	    --사업장주소
        , TITLE_10	= P_TITLE_10	--전자우편주소
        , TITLE_11	= P_TITLE_11	--업태
        , TITLE_12	= P_TITLE_12	--종목
        , TITLE_13	= P_TITLE_13	--업종코드
        , TITLE_14	= P_TITLE_14	--작성일자
        , TITLE_15	= P_TITLE_15	--신고인
        , TITLE_16	= P_TITLE_16	--세무서
        , COL1_1	= P_COL1_1	--과세_세금계산서발급분_금액
        , COL1_2	= P_COL1_2	--과세_세금계산서발급분_세액
        , COL2_1	= P_COL2_1	--과세_매입자발행세금계산서_금액
        , COL2_2	= P_COL2_2	--과세_매입자발행세금계산서_세액
        , COL3_1	= P_COL3_1	--과세_신용카드_현금영수증발행분_금액
        , COL3_2	= P_COL3_2	--과세_신용카드_현금영수증발행분_세액
        , COL4_1	= P_COL4_1	--과세_기타_금액
        , COL4_2	= P_COL4_2	--과세_기타_세액
        , COL5_1	= P_COL5_1	--영세율_세금계산서발급분_금액
        , COL6_1	= P_COL6_1	--영세율_기타_금액
        , COL7_1	= P_COL7_1	--예정신고누락분_금액
        , COL7_2	= P_COL7_2	--예정신고누락분_세액
        , COL8_2	= P_COL8_2	--대손세액가감_세액
        , COL9_1	= P_COL9_1	--합계_금액
        , COL9_2	= P_COL9_2	--합계_세액
        , COL10_1	= P_COL10_1	--매입_일반매입_금액
        , COL10_2	= P_COL10_2	--매입_일반매입_세액
        , COL11_1	= P_COL11_1	--매입_고정자산매입_금액
        , COL11_2	= P_COL11_2	--매입_고장자산매입_세액
        , COL12_1	= P_COL12_1	--매입_예정신고누락분_금액
        , COL12_2	= P_COL12_2	--매입_예정신고누락분_세액
        , COL13_1	= P_COL13_1	--매입_매입자발행세금계산서_금액
        , COL13_2	= P_COL13_2	--매입_매입자발행세금계산서_세액
        , COL14_1	= P_COL14_1	--매입_기타공제매입세액_금액
        , COL14_2	= P_COL14_2	--매입_기타공제매입세액_세액
        , COL15_1	= P_COL15_1	--매입_합계_금액
        , COL15_2	= P_COL15_2	--매입_합계_세액
        , COL16_1	= P_COL16_1	--매입_공제받지못할매입세액_금액
        , COL16_2	= P_COL16_2	--매입_공제받지못할매입세액_세액
        , COL17_1	= P_COL17_1	--매입_차감계_금액
        , COL17_2	= P_COL17_2	--매입_차감계_세액
        , COL_DA	= P_COL_DA	--납부세액
        , COL18_2	= P_COL18_2	--기타경감공제세액
        , COL19_2	= P_COL19_2	--신용카드매출전표등발행공제등
        , COL20_2	= P_COL20_2	--경감공제_합계
        , COL21_2	= P_COL21_2	--예정신고미환급세액
        , COL22_2	= P_COL22_2	--예정고지세액
        , COL23_2	= P_COL23_2	--금지금_매입자_납부특례_기납부세액
        , COL24_2	= P_COL24_2	--가산세액계
        , COL25	    = P_COL25	--차가감하여납부할세액
        
        , DEAL_BANK	        = P_DEAL_BANK	    --거래은행
        , DEAL_BANK_CD	    = P_DEAL_BANK_CD	--거래은행코드
        , DEAL_BRANCH	    = P_DEAL_BRANCH	    --거래지점
        , DEAL_BRANCH_ID	= P_DEAL_BRANCH_ID	--거래지점코드
        , ACC_NO	        = P_ACC_NO	        --계좌번호
        , CLOSURE_DATE	    = P_CLOSURE_DATE	--폐업일
        , CLOSURE_REASON	= P_CLOSURE_REASON	--폐업사유
        
        , COL26_1	= P_COL26_1	--과세표준_업태1
        , COL26_2	= P_COL26_2	--과세표준_종목1
        , COL26_3	= P_COL26_3	--과세표준_금액1
        , COL27_1	= P_COL27_1	--과세표준_업태2
        , COL27_2	= P_COL27_2	--과세표준_종목2
        , COL27_3	= P_COL27_3	--과세표준_금액2
        , COL28_1	= P_COL28_1	--과세표준_업태3
        , COL28_2	= P_COL28_2	--과세표준_종목3
        , COL28_3	= P_COL28_3	--과세표준_금액3
        , COL29_1	= P_COL29_1	--과세표준_업태4
        , COL29_2	= P_COL29_2	--과세표준_종목4
        , COL29_3	= P_COL29_3	--과세표준_금액4
        , COL30	    = P_COL30	--과세표준_합계
        , COL31_1	= P_COL31_1	--예정신고_매출_과세_세금계산서_금액
        , COL31_2	= P_COL31_2	--예정신고_매출_과세_세금계산서_세액
        , COL32_1	= P_COL32_1	--예정신고_매출_과세_기타_금액
        , COL32_2	= P_COL32_2	--예정신고_매출_과세_기타_세액
        , COL33_1	= P_COL33_1	--예정신고_매출_영세율_세금계산서
        , COL34_1	= P_COL34_1	--예정신고_매출_영세율_기타
        , COL35_1	= P_COL35_1	--예정신고_매출_합계_금액
        , COL35_2	= P_COL35_2	--예정신고_매출_합계_세액
        , COL36_1	= P_COL36_1	--예정신고_매입_세금계산서_금액
        , COL36_2	= P_COL36_2	--예정신고_매입_세금계산서_세액
        , COL37_1	= P_COL37_1	--예정신고_매입_기타공제매입세액_금액
        , COL37_2	= P_COL37_2	--예정신고_매입_기타공제매입세액_세액
        , COL38_1	= P_COL38_1	--예정신고_매입_합계_금액
        , COL38_2	= P_COL38_2	--예정신고_매입_합계_세액
        , COL39_1	= P_COL39_1	--기타공제_신용카드_일반매입_금액
        , COL39_2	= P_COL39_2	--기타공제_신용카드_일반매입_세액
        , COL40_1	= P_COL40_1	--기타공제_신용카드_고정자산매입_금액
        , COL40_2	= P_COL40_2	--기타공제_신용카드_고정자산매입_세액
        , COL41_1	= P_COL41_1	--기타공제_의제매입세액_금액
        , COL41_2	= P_COL41_2	--기타공제_의제매입세액_세액
        , COL42_1	= P_COL42_1	--기타공제_재활용폐자원등매입세액_금액
        , COL42_2	= P_COL42_2	--기타공제_재활용폐자원등매입세액_세액
        , COL43_1	= P_COL43_1	--기타공제_고금의제매입세액_금액
        , COL43_2	= P_COL43_2	--기타공제_고금의제매입세액_세액
        , COL44_2	= P_COL44_2	--기타공제_과세사업전환매입세액_세액
        , COL45_2	= P_COL45_2	--기타공제_재고매입세액_세액
        , COL46_2	= P_COL46_2	--기타공제_변제대손세액_세액
        , COL47_1	= P_COL47_1	--기타공제_합계_금액
        , COL47_2	= P_COL47_2	--기타공제_헙계_세액
        , COL48_1	= P_COL48_1	--공제받지못할매입세액_공제받지못할_금액
        , COL48_2	= P_COL48_2	--공제받지못할매입세액_공제받지못할_세액
        , COL49_1	= P_COL49_1	--공제받지못할매입세액_공통매입세액면세_금액
        , COL49_2	= P_COL49_2	--공제받지못할매입세액_공통매입세액면세_세액
        , COL50_1	= P_COL50_1	--공제받지못할매입세액_대손처분받은세액_금액
        , COL50_2	= P_COL50_2	--공제받지못할매입세액_대손처분받은세액_세액
        , COL51_1	= P_COL51_1	--공제받지못할매입세액_합계_금액
        , COL51_2	= P_COL51_2	--공제받지못할매입세액_합계_세액
        , COL52_2	= P_COL52_2	--기탁경감공제세액_전자신고세액공제_세액
        , COL53_2	= P_COL53_2	--기타경감공제세액_전자세금계산서발급세액공제_세액
        , COL54_2	= P_COL54_2	--기타경감공제세액_택시운송사업자경감세액_세액
        , COL55_2	= P_COL55_2	--기타경감공제세액_현금영수증사업자세액공제_세액
        , COL56_2	= P_COL56_2	--기타경감공제세액_기타_세액
        , COL57_2	= P_COL57_2	--기타경감공제세액_합계_세액
        , COL58_1	= P_COL58_1	--가산세명세_사업자미등록등_금액
        , COL58_2	= P_COL58_2	--가산세명세_사업자미등록등_세액
        , COL59_1	= P_COL59_1	--가산세명세_지연발급등_금액
        , COL59_2	= P_COL59_2	--가산세명세_지연발급등_세액
        , COL60_1	= P_COL60_1	--가산세명세_미발급등_금액
        , COL60_2	= P_COL60_2	--가산세명세_미발급등_세액
        , COL61_1	= P_COL61_1	--가산세명세_다음달15일이후_금액
        , COL61_2	= P_COL61_2	--가산세명세_다음달15일이후_세액
        , COL62_1	= P_COL62_1	--가산세명세_과세기간다음달15일이후_금액
        , COL62_2	= P_COL62_2	--가산세명세_과세기간다음달15일이후_세액
        , COL63_1	= P_COL63_1	--가산세명세_세금계산서합계표제출불성실_금액
        , COL63_2	= P_COL63_2	--가산세명세_세금계산서합계표제출불성실_세액
        , COL64_1	= P_COL64_1	--가산세명세_신고불성실_금액
        , COL64_2	= P_COL64_2	--가산세명세_신고불성실_세액
        , COL65_1	= P_COL65_1	--가산세명세_납부불성싱_금액
        , COL65_2	= P_COL65_2	--가산세명세_납부불성실_세액
        , COL66_1	= P_COL66_1	--가산세명세_영세율과세표준신고불성실_금액
        , COL66_2	= P_COL66_2	--가산세명세_영세율과세표준신고불성실_세액
        , COL67_1	= P_COL67_1	--가산세명세_현금매출명세서미제출등_금액
        , COL67_2	= P_COL67_2	--가산세명세_현금매출명세서미제출등_세액
        , COL68_2	= P_COL68_2	--가산세명세_합계_세액
        , COL69_1	= P_COL69_1	--면세사업수입금액_업태1
        , COL69_2	= P_COL69_2	--면세사업수입금액_종목1
        , COL69_3	= P_COL69_3	--면세사업수입금액_금액1
        , COL70_1	= P_COL70_1	--면세사업수입금액_업태2
        , COL70_2	= P_COL70_2	--면세사업수입금액_종목2
        , COL70_3	= P_COL70_3	--면세사업수입금액_금액2
        , COL71_1	= P_COL71_1	--면세사업수입금액_업태3
        , COL71_2	= P_COL71_2	--면세사업수입금액_종목3
        , COL71_3	= P_COL71_3	--면세사업수입금액_금액3
        , COL72	    = P_COL72	--면세사업수입금액_합계
        , COL73	    = P_COL73	--계산서발급금액
        , COL74	    = P_COL74	--계산서수취금액
                  
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = P_SOB_ID                  --회사아이디
        AND ORG_ID                  = P_ORG_ID                  --사업부아이디
        AND OPERATING_UNIT_ID       = P_OPERATING_UNIT_ID       --사업장아이디        
        AND VAT_MNG_SERIAL          = P_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = P_SPEC_SERIAL             --일련번호
    ;

END UPDATE_SURTAX_CARD;









--거래은행 POPUP
PROCEDURE POPUP_BANK(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_BANK.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_BANK.ORG_ID%TYPE  --사업부아이디
)

AS

BEGIN

    OPEN P_CURSOR FOR    
    
    SELECT 
          BANK_GROUP    --은행/지점구분할 때 사용함
        , BANK_CODE     --은행코드
        , BANK_NAME     --은행명
    FROM FI_BANK
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_GROUP = '-'    ;   

END POPUP_BANK;







--거래은행지점 POPUP
PROCEDURE POPUP_BANK_BRANCH(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE     --사업부아이디
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE  --금융기관코드
)

AS

BEGIN

    OPEN P_CURSOR FOR    
    
    SELECT 
          BANK_ID   --아이디
        , BANK_CODE --코드
        , ( --선택한 은행명
            SELECT BANK_NAME 
            FROM FI_BANK
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND BANK_GROUP = '-'
                AND BANK_CODE = W_BANK_CODE    
          ) AS BANK_NAME    --은행명
        , BANK_NAME AS BANK_BRANCH  --지점명
    FROM FI_BANK
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_GROUP = W_BANK_CODE  ;   

END POPUP_BANK_BRANCH;







--계좌번호 POPUP
PROCEDURE POPUP_ACCOUNT_NO(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_BANK.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID      IN  FI_BANK.ORG_ID%TYPE       --사업부아이디
    , W_BANK_CODE   IN  FI_BANK.BANK_CODE%TYPE    --금융기관코드
    , W_BANK_ID     IN  FI_BANK.BANK_ID%TYPE      --금융기관아이디
)

AS

BEGIN

    OPEN P_CURSOR FOR    
        
    SELECT
         ( --선택한 은행명
            SELECT BANK_NAME 
            FROM FI_BANK
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND BANK_GROUP = '-'
                AND BANK_CODE = W_BANK_CODE
          ) AS BANK_NAME    --은행명
        , BANK_ACCOUNT_NAME --계좌명
        , BANK_ACCOUNT_NUM  --계좌번호
        , ACCOUNT_TYPE  --계좌구분코드
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', ACCOUNT_TYPE, SOB_ID, ORG_ID) AS VAT_REASON_NAME    --계좌구분
    FROM FI_BANK_ACCOUNT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ENABLED_FLAG = 'Y'
        AND BANK_ID = W_BANK_ID    ;  

END POPUP_ACCOUNT_NO;




   PROCEDURE ROUND_TAX
           ( O_NUMBER  OUT  NUMBER
           , P_NUMBER  IN   NUMBER
           )

   AS

   BEGIN

         O_NUMBER := ROUND(P_NUMBER);

   EXCEPTION WHEN OTHERS THEN
             O_NUMBER := 0;

   END ROUND_TAX;





END FI_SURTAX_CARD_G;
/
