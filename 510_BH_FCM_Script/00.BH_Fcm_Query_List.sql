EAPP_COMMON_G                                     -- 
EAPP_LOOKUP_DATA_G
EAPP_CALENDAR_G
EAPP_USER_G
EAPP_CURRENCY_G                                   -- 통화관리.
EAPP_EXCHANGE_RATE_G
ISGETDATE                                         -- 날짜여부.
EAPP_NUM_DIGIT_CHECKER_G                          -- 주민번호/법인번호/사업자번호 검증.

-------------------------------------------------------------------------------
FI_DOCUMENT_NUM_G                                 -- 전표번호 채번.
FI_ACCOUNT_BOOK_G                                 -- 회계장부.
FI_COMMON_G                                       -- 공통코드 관리.

GL_FISCAL_CALENDAR_G                              -- 회계달력.
GL_FISCAL_YEAR_G                                  -- 회계년도.
GL_FISCAL_PERIOD_G                                -- 회계기간.
FI_ACCOUNT_SET_G                                  -- 계정관리.
FI_ACCOUNT_GROUP_G                                -- 계정그룹관리.
FI_ACCOUNT_CONTROL_G                              -- 계정통제 관리.
--FI_ACCOUNT_CONTROL_ITEM_G                         -- 계정통제항목 관리.
FI_ACCOUNT_CONTROL_BT                             -- 계정통제 트리거.

FI_CORPORATE_MASTER_G                             -- 법인관리.

AP_SUPPLIER_G                                     -- 공급사 관리.
AR_CUSTOMER_SITE_G                                -- 고객사 관리.

FI_BANK_G                                         -- 금융기관(은행)마스터.
FI_BANK_ACCOUNT_G                                 -- 거래 계좌번호.
FI_DEPT_MASTER_G                                  -- 부서관리.
FI_CREDIT_CARD_G                                  -- 신용카드 관리.
FI_AUTO_JOURNAL_G                                 -- 자동분개유형등록.
FI_FORM_G                                         -- 재무제표보고서양식.
FI_DEPT_CC_MAPPING_G                              -- 발의부서/원가코드 맵핑.

-------------------------------------------------------------------------------
-- 전표 관리. --
FI_SLIP_LINE_BT                                   -- 전표관련 BEFORE 트리거 처리.
FI_SLIP_HEADER_INTERFACE_T                        -- 전표 헤더 인터페이스 테이블 트리거.
FI_SLIP_LINE_INTERFACE_BT                         -- 전표 라인 인터페이스 테이블 BEFORE 트리거.
FI_SLIP_LINE_INTERFACE_T                          -- 전표 라인 인터페이스 테이블 트리거.
FI_SLIP_HEADER_T                                  -- 전표 헤더 트리거.
FI_SLIP_LINE_T                                    -- 전표관련 AFTER 트리거 처리.
FI_SLIP_LINE_P                                    -- 전표 관련 트리거 처리 프로시져.
FI_MANAGEMENT_BALANCE_BT                          -- 관리항목 잔액관리 트리거.
FI_MANAGEMENT_BALANCE_G                           -- 
FI_CUSTOMER_BALANCE_DAILY_P                       -- 일자별/계정별/거래처별 금액.
FI_VAT_SUM_P                                      -- 부가세 관리.

FI_SLIP_BL_G                                      -- 기초 잔액 업로드 전표.
FI_SLIP_G                                         -- 전표 관리 패키지.
FI_SLIP_INTERFACE_G                               -- 전표 인터페이스 관리.
FI_SLIP_AUTO_INTERFACE_G                          -- 자동전표 관리 패키지.
FI_SLIP_GS_G                                      -- 전표 관리 패키지(백업용-FCMF0205).
FI_SLIP_PAYABLE_RECEIPT_G                         -- 입금/수금 전표 관리.
FI_BILL_MASTER_G                                  -- 받을 어음 관리.
FI_UNLIQUIDATE_G                                  -- 미반제내역 반제 처리.
FI_SLIP_EXCEL_UPLOAD_G                            -- 전표 엑셀 업로드.

FI_SLIP_BUDGET_G                                  -- 예산전표 관리.
FI_SLIP_PRINT_G                                   -- 전표 인쇄.
FI_SLIP_IF_PRINT_G                                -- 일반경비전표 인쇄.
FI_LC_MASTER_G                                    -- L/C 관리.
FI_DPR_SPEC_G                                     -- 감가상각자산 취득내역.

-------------------------------------------------------------------------------
--- 원장관리. ---
FI_BILL_MASTER_G                                  -- 받을어음 원장.
FI_BANKING_ACCOUNT_SUM_LIST_G                     -- 금융기관별 계좌별 예적금현황.
FI_DAILY_BANK_ACC_SUM_LIST_G                      -- 금융기관별 예적금 현황.
FI_BANK_CHECK_LIST_G                              -- 제예금은행별체크리스트.
FI_LOAN_REPORT_G                                  -- 차입기간별차입금현황
FI_LOAN_DUE_DATE_REPORT_G                         -- 만기일자별 차입금현황.
FI_FOREIGN_CURR_SPEND_LIST_G                      -- 외화지출장 
FI_CUSTOMER_BALANCE_LIST_G                        -- 거래처별 원장조회.
FI_MANAGEMENT_BALANCE_G                           -- 보조부원장조회.
FI_LOAN_MASTER_G                                  -- 차입금 원장관리.
FI_TR_DAILY_SUM_G                                 -- 자금일보.
FI_DEPOSIT_MASTER_G                               -- 예적금 마스터.
FI_FOREIGN_CURR_SPEND_LIST_G                      -- 외화 지출장.
FI_MANAGEMENT_LEDGER_G                            -- 관리항목별원장.

FI_BALANCE_ACCOUNTS_G                             -- 계정잔액명세 계정관리.
FI_BALANCE_STATEMENT_G                            -- 계정잔액명세 잔액관리.
FI_BALANCE_STATEMENT_SET_G                        -- 계정잔액명세 잔액생성.

-------------------------------------------------------------------------------
--- 장부관리. ---
FI_NOTES_PAYABLE_LEDGER_LIST_G                    -- 지급어음 (발행/만기) 일자별 조회.
FI_SLIP_LINE_LIST_G                               -- 보조부원장. 
FI_CASHIER_CASHBOOK_G                             -- 현금출납장 관리.
FI_ACCOUNT_STATEMENT_G
FI_DAILY_ACCOUNT_SUM_LIST_G                       -- 일계표.
FI_MONTH_ACCOUNT_SUM_LIST_G                       -- 월계표.
FI_ACCOUNT_LEDGER_G                               -- 계정별원장.
FI_FINAL_SETTLEMENT_SUM_LIST_G                    -- 총계정원장.

-------------------------------------------------------------------------------
--- 재무제표관리. ---
FI_TRIAL_BALANCE_G                                -- 시산표.
FI_BALANCE_BS_G                                   -- 대차대조표 생성.
FI_BALANCE_IS_G                                   -- 손익계산서 생성.
FI_BALANCE_MS_G                                   -- 제조원가명세서 생성.

FI_FS_BS_G                                        -- 재무상태표.
FI_FS_IS_PARADE_G                                 -- 손익계산서.

-------------------------------------------------------------------------------
--- 세무관리. ---
FI_VAT_ACCOUNTS_G                                 -- 부가세관리 계정.
FI_VAT_TAX_STANDARD_G                             -- 부가세관세표준.

FI_VAT_MASTER_G                                   -- 부가세 조회.
FI_VAT_TAX_INVOICE_G                              -- 매입매출 세금계산서 합계표.
FI_VAT_BILL_G                                     -- 매입매출 계산서 합계표.
FI_VAT_CREDITCARD_G                               -- 신용카드 매입전표 체크리스트.
FI_VAT_EXPORT_G                                   -- 수출실적명세서.
FI_VAT_ZERO_TAX_RATE_G                            -- 영세율첨부서류.
FI_VAT_DPR_ASSET_G                                -- 감가상각취득명세서. 
FI_VAT_NOT_DEDUCTION_G                            -- 공제받지못할매입세액명세서.
FI_VAT_REALTY_LEASE_G                             -- 부동산임대공급가액명세서.
FI_VAT_INTEREST_RATE_G                            -- 부동산임대공급 이자율관리.
FI_VAT_DECLARATION_G                              -- 부가세신고서.
FI_VAT_REPORT_FILE_G                              -- 부가세전자신고파일.(추후 분리 : fi_vat_declaration_g)

FI_PURCHASE_CHARGE_TAX_LIST_G                     -- 매입매출 세금계산서 조회/출력.
FI_PURCHASE_CHARGE_BILL_SUM_G                     -- 매입매출 계산서 합계표
FI_VAT_VOUCH_LIST_G                               -- 부가세 증빙 체크리스트.
FI_VAT_REPORT_MNG_G                               -- 부가세마감관리.

FI_SURTAX_CARD_G                                  -- 부가세신고서.
FI_VAT_E_FILE_G                                   -- 부가세 전자파일생성.

-------------------------------------------------------------------------------
--- 자산관리. ---
FI_ASSET_CATEGORY_G                               -- 고정자산 카테고리.
FI_ASSET_CLASS_G                                  -- 고정자산 클래스.
FI_ASSET_MASTER_G                                 -- 고정자산마스터.
FI_ASSET_MASTER_BT                                -- 고정자산 트리거(Before)
FI_ASSET_MASTER_T_G                               -- 고정자산 트리거 패키지.
FI_DPR_RATE_G                                     -- 상각율 관리.
FI_ASSET_DPR_HISTORY_SET_G                        -- 감가상각 계산.
FI_DPR_G                                          -- 감가상각비 관리.
FI_ASSET_HISTORY_G                                -- 고정자산 변동내역.
FI_ASSET_HISTORY_BT                               -- 자산변동내역 BEFORE TRIGGER.
FI_DPR_EXPENSE_G                                  -- 고정자산 감가비 관련.

-------------------------------------------------------------------------------
--- 예산관리. ---
FI_BUDGET_ADD_BT                                  -- 예산 신청 트리거.
--FI_BUDGET_VALIDATE_F                              -- 예산 체크 함수(사용안함).
FI_BUDGET_ACCOUNT_G                               -- 예산계정관리.
FI_BUDGET_G                                       -- 예산수립관리.
FI_BUDGET_ADD_G                                   -- 예산신청관리.
FI_BUDGET_ADD_BT                                  -- 예산신청 승인 트리거.
FI_BUDGET_MOVE_G                                  -- 예산 전용관리.
FI_BUDGET_MOVE_BT                                 -- 예산전용 승인 트리거.
FI_BUDGET_CONTROL_G                               -- 예산사용자관리.
FI_BUDGET_PLAN_G                                  -- 년예산 책정 및 예산수립.

-------------------------------------------------------------------------------
--- 결산관리. ---
FI_MONTH_CLOSE_G                                  -- 월마감 및 잔액이월.
FI_YEAR_CLOSE_G                                   -- 년마감 및 잔액이월.
FI_AGGREGATE_G                                    -- 계정합계 계산.

FI_CLOSING_ACCOUNT_G                              -- 결산계정 관리.
FI_CLOSING_AUTO_JOURNAL_G                         -- 결산자동분개 관리.
FI_CLOSING_ENDING_AMOUNT_G                        -- 결산 기말금액 관리.
FI_CLOSING_SET_G                                  -- 결산 금액 산출 및 결산분개 생성.

FI_MONTH_SETTLEMENT_G                             -- 결산자료 생성.
