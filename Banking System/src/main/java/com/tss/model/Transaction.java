package com.tss.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaction {
    private Integer transactionId;
    private Integer accountId;
    private String type; // DEPOSIT, WITHDRAW, TRANSFER
    private BigDecimal amount;
    private Timestamp transactionDate;
    private String status; // SUCCESS, FAILED, PENDING
    private String referenceAccount; // for transfer

    public Integer getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Integer transactionId) {
        this.transactionId = transactionId;
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReferenceAccount() {
        return referenceAccount;
    }

    public void setReferenceAccount(String referenceAccount) {
        this.referenceAccount = referenceAccount;
    }
}

