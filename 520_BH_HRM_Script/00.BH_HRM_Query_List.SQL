-- HUMAN RESOURCE QUERY LIST --
TAX_RATE_F                                                    -- 세율관리.
DECIMAL_F                                                     -- 소숫점 관리.
EAPP_NUM_DIGIT_CHECKER_G                                      -- 번호 체크.
EAPP_REGISTER_AGE_F                                           -- 나이 (주민번호).
EAPP_BIRTH_AGE_F                                              -- 나이(생일)
HRM_WEB_G                                                     -- 웹 관리.
EAPP_CALENDAR_G

HRM_MANAGER_G                                                 -- 인사시스템 모듈 담당자.
HRM_FOOD_MANAGER_G                                            -- 식당별 담당자 지정.
HRM_VISITOR_CARD_G                                            -- 방문카드관리.
                                                              
HRM_COMMON_G                                                  -- 공통코드 관리.
HRM_COMMON_DATE_G                                             -- 날짜 관련 패키지.

HRM_CORP_MASTER_G                                             -- 업체정보 관리.
HRM_OPERATING_UNIT_G                                          -- 사업부 관리.
HRM_DEPT_MASTER_G                                             -- 부서정보 관리.
HRM_DEPT_MAPPING_G                                            -- 부서마스터 맵핑관리.
HRP_TAX_STANDARD_G                                            -- 갑근세 조견표.
HRA_TAX_RATE_G                                                -- 종합소득세액관리.
HRM_CLOSING_G                                                 -- 마감정보 관리.
HRM_PERSON_CC_G                                               -- 원가코드 맵핑.

HRM_PERSON_MASTER_G                                           -- 인사정보관리.
HRM_PERSON_MASTER_T                                           -- 인사정보 트리거.
HRM_BODY_G                                                    -- 신체사항.
HRM_ARMY_G                                                    -- 병역사항.
HRM_FAMILY_G                                                  -- 가족사항관리.
HRM_CAREER_G                                                  -- 경력사항.
HRM_SCHOLARSHIP_G                                             -- 학력사항.
HRM_EDUCATION_G                                               -- 교육사항.
HRM_RESULT_G                                                  -- 평가사항.
HRM_LICENSE_G                                                 -- 자격사항.
HRM_FOREIGN_LANGUAGE_G                                        -- 외국어 사항.
HRM_REWARD_PUNISHMENT_G                                       -- 상벌사항.
HRM_REFERENCE_G                                               -- 신원보증.
HRM_HISTORY_HEADER_G                                          -- 인사발령사항 HEADER.
HRM_HISTORY_LINE_G                                            -- 인사발령사항 LINE 조회.
HRM_ADMINISTRATIVE_LEAVE_G                                    -- 휴직자관리.
HRM_CERTIFICATE_G                                             -- 증명서 관리.
HRM_PERSON_DISPATCH_G                                         -- 파견직 인사정보 관리.
--
HRM_DEPT_FLOOR_CNT_G                                          -- 부서별인원현황.

--
HRD_PERSON_HISTORY_G                                          -- 근태 작업장, 교대유형 관리.
HRD_HOLIDAY_CALENDAR_G                                        -- 휴일관리.
HRD_DUTY_MANAGER_G                                            -- 근태 담당자.
HRD_WORK_CALENDAR_G                                           -- 근무계획표.
HRD_HOLY_TYPE_G                                               -- 근무신청서.
HRD_HOLY_TYPE_T_A                                             -- 근무신청서 트리거(AFTER).
HRD_DUTY_PERIOD_G                                             -- 고정근태 신청.
HRD_DUTY_PERIOD_INTERFACE_T                                   -- 고정근태 INTERFACE TRIGGER.
HRD_OT_HEADER_G                                               -- 연장근무 HEADER.
HRD_OT_LINE_G                                                 -- 연장근무 LINE.
HRD_DUTY
HRD_MAIL_SEND                                                 -- 근태 메일 발송.
--
HRD_SECOM_HISTORY_G                                           -- 세콤 근태/식수 동기화.
HRD_DAY_INTERFACE_G                                           -- 출퇴근조회(현업).
HRD_DAY_INTERFACE_G_SET                                       -- 출퇴근 집계.
HRD_DAY_INTERFACE_TRANS_G                                     -- 출퇴근 이첩처리.
HRD_DAY_INTERFACE_PRINT_G                                     -- 출퇴근 인쇄.
HRD_DAY_LEAVE_G                                               -- 일근태 관리.
HRD_DAY_LEAVE_G_SET                                           -- 일근태 계산.
HRD_MONTH_TOTAL_G                                             -- 월근태 조회.
HRD_MONTH_TOTAL_G_SET                                         -- 월근태 집계.
HRD_HOLIDAY_MANAGEMENT_G                                      -- 휴가사항관리.
HRD_HOLIDAY_MANAGEMENT_G_SET                                  -- 휴가사항 처리.

HRF_FOOD_DAY_SUMMARY_G                                        -- 일식사 조회.
HRF_FOOD_COUPON_G                                             -- 식권관리.
HRF_FOOD_DAY_SUMMARY_G_SET                                    -- 일식사 집계.
HRF_FOOD_MISTAKE_CHECK_G                                      -- 식사 미체크 관리.
HRF_FOOD_DAY_PERSON_G                                         -- 개인별 일식사 관리.

HRM_AUTO_DOCUMENT_G                                           -- 급상여 자동분개 유형 정의.
HRP_PAY_CALCULATE_G                                           -- 급상여 계산식 관리
HRP_PAYMENT_RULE_G                                            -- 급상여 지급율 관리.
HRP_PERSON_PAYMENT_RULE_G                                     -- 급상여 개인별 지급율 관리.
HRP_GRADE_G                                                   -- 호봉관리.
HRP_INSURANCE_CHARGE_G                                        -- 보험관리.
HRP_INSURANCE_STANDARD_G                                      -- 보험료산정기준.
HRP_INSURANCE_MASTER_G                                        -- 보험마스터관리.
HRP_PAYMENT_G                                                 -- 급여관련 조회 패키지.
HRP_PAY_MASTER_G                                              -- 급여 마스터 관리.
HRP_PAYMENT_ADD_ALLOWANCE_G                                   -- 급상여 추가 지급 관리.
HRP_PAYMENT_ADD_DEDUCTION_G                                   -- 급상여 추가 공제 관리.
HRP_MONTH_PAYMENT_G                                           -- 월급여 내역.
HRP_MONTH_PAYMENT_SLIP_G                                      -- 급여 자동전표관리.
HRP_PAYMENT_G_SET                                             -- 급상여 처리 MAIN.
HRP_MONTH_PAYMENT_G_SET                                       -- 급여 계산산출.
HRP_MONTH_BONUS_G_SET                                         -- 상여 계산산출.
HRP_PAYMENT_TRANSFER_G
HRP_MONTH_PAYMENT_PRINT_G                                     -- 급상여 인쇄.
HRP_MONTH_PAYMENT_PRINT_WEB_G                                 -- 급상여 인쇄(웹).

HRR_RETIRE_STANDARD_G                                         -- 퇴직정산기준자료.
HRR_CONTINUOUS_DEDUCTION_G                                    -- 퇴직근속공제관리.
HRR_RETIRE_INSURANCE_G                                        -- 퇴직보험금 관리.
HRR_RETIRE_ADJUSTMENT_G                                       -- 퇴직정산.
HRR_RETIRE_ADJUSTMENT_SET_G                                   -- 퇴직금 산출.
HRR_RETIRE_PAYMENT_SET_G                                      -- 퇴직금 급상여 산출.
HRR_RETIRE_RESERVE_G                                          -- 퇴직보험충당금.

------------------------------------------------------------------------------
HRA_INCOME_TAX_STANDARD_G                                     -- 연말정산기준자료.
HRA_PREVIOUS_WORK_G                                           -- 종전근무지.
HRA_SUPPORT_FAMILY_G                                          -- 부양가족내역.
HRA_FOUNDATION_G                                              -- 연말정산 기초자료.
HRA_DONATION_INFO_G                                           -- 기부금 명세서/기부금 조정명세.
HRA_MEDICAL_INFO_G                                            -- 의료비 명세서.
HRA_YEAR_ADJUSTMENT_G                                         -- 연말정산 조회.
HRA_YEAR_ADJUST_SET_G                                         -- 연말정산계산 MAIN.
HRA_YEAR_ADJUST_SET_G_2010                                    -- 연말정산 계산-2010.
HRA_YEAR_ADJUST_SET_G_2011                                    -- 연말정산 계산-2011.
HRA_SAVING_INFO_G                                             -- 연말정산 저축공제 관리.
HRA_SAVING_INFO_BT                                            -- 연말정산 저축공제 내역 트리거.
HRA_CERTIFICATE_G                                             -- 근로소득원천징수영수증.

------------------------------------------------------------------------------
-- 원천세.
HRW_HOMETAX_INFO_G                                            -- 홈택스 정보 관리.
HRW_EARNER_MASTER_G                                           -- 원천세 소득자 관리.
HRW_INCOME_RESIDENT_BSN_G                                     -- 소득등록(거주자사업소득).
HRW_WITHHOLDING_G                                             -- 원천징수이행상황신고서.
HRW_WITHHOLDING_SET_G                                         -- 원천징수이행상황신고서 집계 및 마감관리.
HRW_WITHHOLDING_FILE_G                                        -- 원천징수이행상황신고서 전산매체.
HRW_OFFICE_TAX_G                                              -- 지방소득세(종업원할 사업소세).
HRW_OFFICE_TAX_SET_G                                          -- 지방소득세(종업원할 사업소세) 집계 및 마감관리.
HRW_LOCAL_TAX_G                                               -- 주민세특별징수명세/납입서.
HRW_LOCAL_TAX_SET_G                                           -- 주민세특별징수명세/납입서 집계 및 마감관리.

------------------------------------------------------------------------------
ERRNUMS                                                       -- 예외정의 관리.
USERENV_G                                                     -- 사용자 로그인 환경정보.

-- EAPP.
EAPP_COMMON_G 
EAPP_USER_G                                                   -- 사용자 관리.
EAPP_ADDRESS_G                                                -- 우편번호 관리.
EAPP_NUM_DIGIT_CHECKER_G                                      -- 번호 체크(주민번호, 법인번호, 사업자번호, 외국인번호).
EAPP_CALENDAR_G                                               -- 년도/월 관리.
EAPP_MESSAGE_G                                                -- 메세지 관리.

EAPP_LOOKUP_TYPE_G                                            -- LOOKUP TYPE.
EAPP_LOOKUP_ENTRY_G                                           -- LOOKUP ENTRY.

-------------------------------------------------------------------------------
HRM_DUTY_TERM_V                                               -- 근태기간.
HRD_DAY_INTERFACE_V                                           -- 출퇴근수정 VIEW.

------------------------------------------------------------------------------
-- 파견직 관리(temporary Worker)
HRT_PAYMENT_RULE_G                                            -- 급상여 지급율 관리.
HRT_PERSON_PAYMENT_RULE_G                                     -- 개인별 급상여 지급율관리.
HRT_INSURANCE_MASTER_G                                        -- 보험마스터관리.
HRT_PAY_MST_COMMON_G                                          -- 급여마스터.
HRT_PAY_MASTER_G                                              -- 개인별 급여마스터.
HRT_PAYMENT_ADD_ALLOWANCE_G                                   -- 급상여추가공제(추가).
HRT_PAYMENT_ADD_DEDUCTION_G                                   -- 급상여추가공제(공제).
HRT_PAYMENT_G                                                 -- 급여관련 조회 패키지.
HRT_MONTH_PAYMENT_G                                           -- 월급여 내역.
HRT_MONTH_PAYMENT_SLIP_G                                      --- 급여 자동전표관리.
HRT_PAYMENT_G_SET                                             -- 급상여 처리 MAIN.
HRT_MONTH_PAYMENT_G_SET                                       -- 급여 계산산출.
HRT_MONTH_BONUS_G_SET                                         -- 상여 계산산출.
HRT_PAYMENT_TRANSFER_G                                        -- 급상여 이체내역.
HRT_MONTH_PAYMENT_SLIP_G                                      -- 급여 자동전표관리.
