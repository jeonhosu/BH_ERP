EAPP_COMMON_G                                     -- 
EAPP_LOOKUP_DATA_G
EAPP_CALENDAR_G
EAPP_USER_G
EAPP_CURRENCY_G                                   -- ��ȭ����.
EAPP_EXCHANGE_RATE_G
ISGETDATE                                         -- ��¥����.
EAPP_NUM_DIGIT_CHECKER_G                          -- �ֹι�ȣ/���ι�ȣ/����ڹ�ȣ ����.

-------------------------------------------------------------------------------
FI_DOCUMENT_NUM_G                                 -- ��ǥ��ȣ ä��.
FI_ACCOUNT_BOOK_G                                 -- ȸ�����.
FI_COMMON_G                                       -- �����ڵ� ����.

GL_FISCAL_CALENDAR_G                              -- ȸ��޷�.
GL_FISCAL_YEAR_G                                  -- ȸ��⵵.
GL_FISCAL_PERIOD_G                                -- ȸ��Ⱓ.
FI_ACCOUNT_SET_G                                  -- ��������.
FI_ACCOUNT_GROUP_G                                -- �����׷����.
FI_ACCOUNT_CONTROL_G                              -- �������� ����.
--FI_ACCOUNT_CONTROL_ITEM_G                         -- ���������׸� ����.
FI_ACCOUNT_CONTROL_BT                             -- �������� Ʈ����.

FI_CORPORATE_MASTER_G                             -- ���ΰ���.

AP_SUPPLIER_G                                     -- ���޻� ����.
AR_CUSTOMER_SITE_G                                -- ���� ����.

FI_BANK_G                                         -- �������(����)������.
FI_BANK_ACCOUNT_G                                 -- �ŷ� ���¹�ȣ.
FI_DEPT_MASTER_G                                  -- �μ�����.
FI_CREDIT_CARD_G                                  -- �ſ�ī�� ����.
FI_AUTO_JOURNAL_G                                 -- �ڵ��а��������.
FI_FORM_G                                         -- �繫��ǥ�������.
FI_DEPT_CC_MAPPING_G                              -- ���Ǻμ�/�����ڵ� ����.

-------------------------------------------------------------------------------
-- ��ǥ ����. --
FI_SLIP_LINE_BT                                   -- ��ǥ���� BEFORE Ʈ���� ó��.
FI_SLIP_HEADER_INTERFACE_T                        -- ��ǥ ��� �������̽� ���̺� Ʈ����.
FI_SLIP_LINE_INTERFACE_BT                         -- ��ǥ ���� �������̽� ���̺� BEFORE Ʈ����.
FI_SLIP_LINE_INTERFACE_T                          -- ��ǥ ���� �������̽� ���̺� Ʈ����.
FI_SLIP_HEADER_T                                  -- ��ǥ ��� Ʈ����.
FI_SLIP_LINE_T                                    -- ��ǥ���� AFTER Ʈ���� ó��.
FI_SLIP_LINE_P                                    -- ��ǥ ���� Ʈ���� ó�� ���ν���.
FI_MANAGEMENT_BALANCE_BT                          -- �����׸� �ܾװ��� Ʈ����.
FI_MANAGEMENT_BALANCE_G                           -- 
FI_CUSTOMER_BALANCE_DAILY_P                       -- ���ں�/������/�ŷ�ó�� �ݾ�.
FI_VAT_SUM_P                                      -- �ΰ��� ����.

FI_SLIP_BL_G                                      -- ���� �ܾ� ���ε� ��ǥ.
FI_SLIP_G                                         -- ��ǥ ���� ��Ű��.
FI_SLIP_INTERFACE_G                               -- ��ǥ �������̽� ����.
FI_SLIP_AUTO_INTERFACE_G                          -- �ڵ���ǥ ���� ��Ű��.
FI_SLIP_GS_G                                      -- ��ǥ ���� ��Ű��(�����-FCMF0205).
FI_SLIP_PAYABLE_RECEIPT_G                         -- �Ա�/���� ��ǥ ����.
FI_BILL_MASTER_G                                  -- ���� ���� ����.
FI_UNLIQUIDATE_G                                  -- �̹������� ���� ó��.
FI_SLIP_EXCEL_UPLOAD_G                            -- ��ǥ ���� ���ε�.

FI_SLIP_BUDGET_G                                  -- ������ǥ ����.
FI_SLIP_PRINT_G                                   -- ��ǥ �μ�.
FI_SLIP_IF_PRINT_G                                -- �Ϲݰ����ǥ �μ�.
FI_LC_MASTER_G                                    -- L/C ����.
FI_DPR_SPEC_G                                     -- �������ڻ� ��泻��.

-------------------------------------------------------------------------------
--- �������. ---
FI_BILL_MASTER_G                                  -- �������� ����.
FI_BANKING_ACCOUNT_SUM_LIST_G                     -- ��������� ���º� ��������Ȳ.
FI_DAILY_BANK_ACC_SUM_LIST_G                      -- ��������� ������ ��Ȳ.
FI_BANK_CHECK_LIST_G                              -- ���������ະüũ����Ʈ.
FI_LOAN_REPORT_G                                  -- ���ԱⰣ�����Ա���Ȳ
FI_LOAN_DUE_DATE_REPORT_G                         -- �������ں� ���Ա���Ȳ.
FI_FOREIGN_CURR_SPEND_LIST_G                      -- ��ȭ������ 
FI_CUSTOMER_BALANCE_LIST_G                        -- �ŷ�ó�� ������ȸ.
FI_MANAGEMENT_BALANCE_G                           -- �����ο�����ȸ.
FI_LOAN_MASTER_G                                  -- ���Ա� �������.
FI_TR_DAILY_SUM_G                                 -- �ڱ��Ϻ�.
FI_DEPOSIT_MASTER_G                               -- ������ ������.
FI_FOREIGN_CURR_SPEND_LIST_G                      -- ��ȭ ������.
FI_MANAGEMENT_LEDGER_G                            -- �����׸񺰿���.

FI_BALANCE_ACCOUNTS_G                             -- �����ܾ׸� ��������.
FI_BALANCE_STATEMENT_G                            -- �����ܾ׸� �ܾװ���.
FI_BALANCE_STATEMENT_SET_G                        -- �����ܾ׸� �ܾ׻���.

-------------------------------------------------------------------------------
--- ��ΰ���. ---
FI_NOTES_PAYABLE_LEDGER_LIST_G                    -- ���޾��� (����/����) ���ں� ��ȸ.
FI_SLIP_LINE_LIST_G                               -- �����ο���. 
FI_CASHIER_CASHBOOK_G                             -- �����ⳳ�� ����.
FI_ACCOUNT_STATEMENT_G
FI_DAILY_ACCOUNT_SUM_LIST_G                       -- �ϰ�ǥ.
FI_MONTH_ACCOUNT_SUM_LIST_G                       -- ����ǥ.
FI_ACCOUNT_LEDGER_G                               -- ����������.
FI_FINAL_SETTLEMENT_SUM_LIST_G                    -- �Ѱ�������.

-------------------------------------------------------------------------------
--- �繫��ǥ����. ---
FI_TRIAL_BALANCE_G                                -- �û�ǥ.
FI_BALANCE_BS_G                                   -- ��������ǥ ����.
FI_BALANCE_IS_G                                   -- ���Ͱ�꼭 ����.
FI_BALANCE_MS_G                                   -- ������������ ����.

FI_FS_BS_G                                        -- �繫����ǥ.
FI_FS_IS_PARADE_G                                 -- ���Ͱ�꼭.

-------------------------------------------------------------------------------
--- ��������. ---
FI_VAT_ACCOUNTS_G                                 -- �ΰ������� ����.
FI_VAT_TAX_STANDARD_G                             -- �ΰ�������ǥ��.

FI_VAT_MASTER_G                                   -- �ΰ��� ��ȸ.
FI_VAT_TAX_INVOICE_G                              -- ���Ը��� ���ݰ�꼭 �հ�ǥ.
FI_VAT_BILL_G                                     -- ���Ը��� ��꼭 �հ�ǥ.
FI_VAT_CREDITCARD_G                               -- �ſ�ī�� ������ǥ üũ����Ʈ.
FI_VAT_EXPORT_G                                   -- �����������.
FI_VAT_ZERO_TAX_RATE_G                            -- ������÷�μ���.
FI_VAT_DPR_ASSET_G                                -- ������������. 
FI_VAT_NOT_DEDUCTION_G                            -- �����������Ҹ��Լ��׸���.
FI_VAT_REALTY_LEASE_G                             -- �ε����Ӵ���ް��׸���.
FI_VAT_INTEREST_RATE_G                            -- �ε����Ӵ���� ����������.
FI_VAT_DECLARATION_G                              -- �ΰ����Ű�.
FI_VAT_REPORT_FILE_G                              -- �ΰ������ڽŰ�����.(���� �и� : fi_vat_declaration_g)

FI_PURCHASE_CHARGE_TAX_LIST_G                     -- ���Ը��� ���ݰ�꼭 ��ȸ/���.
FI_PURCHASE_CHARGE_BILL_SUM_G                     -- ���Ը��� ��꼭 �հ�ǥ
FI_VAT_VOUCH_LIST_G                               -- �ΰ��� ���� üũ����Ʈ.
FI_VAT_REPORT_MNG_G                               -- �ΰ�����������.

FI_SURTAX_CARD_G                                  -- �ΰ����Ű�.
FI_VAT_E_FILE_G                                   -- �ΰ��� �������ϻ���.

-------------------------------------------------------------------------------
--- �ڻ����. ---
FI_ASSET_CATEGORY_G                               -- �����ڻ� ī�װ�.
FI_ASSET_CLASS_G                                  -- �����ڻ� Ŭ����.
FI_ASSET_MASTER_G                                 -- �����ڻ긶����.
FI_ASSET_MASTER_BT                                -- �����ڻ� Ʈ����(Before)
FI_ASSET_MASTER_T_G                               -- �����ڻ� Ʈ���� ��Ű��.
FI_DPR_RATE_G                                     -- ���� ����.
FI_ASSET_DPR_HISTORY_SET_G                        -- ������ ���.
FI_DPR_G                                          -- �����󰢺� ����.
FI_ASSET_HISTORY_G                                -- �����ڻ� ��������.
FI_ASSET_HISTORY_BT                               -- �ڻ꺯������ BEFORE TRIGGER.
FI_DPR_EXPENSE_G                                  -- �����ڻ� ������ ����.

-------------------------------------------------------------------------------
--- �������. ---
FI_BUDGET_ADD_BT                                  -- ���� ��û Ʈ����.
--FI_BUDGET_VALIDATE_F                              -- ���� üũ �Լ�(������).
FI_BUDGET_ACCOUNT_G                               -- �����������.
FI_BUDGET_G                                       -- �����������.
FI_BUDGET_ADD_G                                   -- �����û����.
FI_BUDGET_ADD_BT                                  -- �����û ���� Ʈ����.
FI_BUDGET_MOVE_G                                  -- ���� �������.
FI_BUDGET_MOVE_BT                                 -- �������� ���� Ʈ����.
FI_BUDGET_CONTROL_G                               -- �������ڰ���.
FI_BUDGET_PLAN_G                                  -- �⿹�� å�� �� �������.

-------------------------------------------------------------------------------
--- ������. ---
FI_MONTH_CLOSE_G                                  -- ������ �� �ܾ��̿�.
FI_YEAR_CLOSE_G                                   -- �⸶�� �� �ܾ��̿�.
FI_AGGREGATE_G                                    -- �����հ� ���.

FI_CLOSING_ACCOUNT_G                              -- ������ ����.
FI_CLOSING_AUTO_JOURNAL_G                         -- ����ڵ��а� ����.
FI_CLOSING_ENDING_AMOUNT_G                        -- ��� �⸻�ݾ� ����.
FI_CLOSING_SET_G                                  -- ��� �ݾ� ���� �� ���а� ����.

FI_MONTH_SETTLEMENT_G                             -- ����ڷ� ����.
