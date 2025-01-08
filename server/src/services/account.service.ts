import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { log } from 'console';
import { AccountResponseDto, CreateAccountDto, UpdateAccountDto } from 'src/dtos/account.dto';
import { AccountRepository } from 'src/repositories/account.repository';
import { TransactionRepository } from 'src/repositories/transaction.repository';

@Injectable()
export class AccountService {
  
  @Inject(AccountRepository) protected accountRepository: AccountRepository;
  @Inject(TransactionRepository) protected transactionRepository: TransactionRepository;

  async getAll(): Promise<AccountResponseDto[]> {
    const accounts = await this.accountRepository.findAll();
    if (!accounts) {
      throw new BadRequestException('Account not found');
    }

    const accountsWithBalance = await Promise.all(accounts.map(async (account) => {
      const totalTransactions = await this.transactionRepository.getTotalTransactionsByAccountId(account.id);
      return { ...account, currentBalance: totalTransactions };
    }));

    return accountsWithBalance;
  }

  async create(accountData: CreateAccountDto): Promise<AccountResponseDto> {
    const account = await this.accountRepository.create(accountData);
    return account;
  }

  async update(id: number, dto: UpdateAccountDto): Promise<AccountResponseDto> {
    const account = await this.findOrFail(id);
    const updatedAccount = await this.accountRepository.update({
      id: account.id,
      ...dto
    });
    return updatedAccount;
  }

  async delete(id: number): Promise<void> {
    const account = await this.findOrFail(id);
    await this.accountRepository.remove(account.id);
  }

  private async findOrFail(id: number) {
    const account = await this.accountRepository.getById(id);
    if (!account) {
      throw new BadRequestException('Account not found');
    }
    return account;
  }

  async getMonthlyBalances(): Promise<any> {

    const accounts = await this.accountRepository.findAll();
    if (!accounts || accounts.length === 0) {
      throw new BadRequestException('Accounts not found for the user');
    }

    const accountIds = accounts.map(account => account.id);
    const transactions = await this.transactionRepository.getTransactionsByAccountIds(accountIds);
    if (!transactions || transactions.length === 0) {
      throw new BadRequestException('Transactions not found for the user\'s accounts');
    }

    const monthlyBalances = {};
    let currentBalance = 0;

    transactions.forEach(transaction => {
      const date = new Date(transaction.date);
      const month = date.getMonth() + 1; // Months are zero-based
      const year = date.getFullYear();
      const firstOfMonth = `${year}-${month < 10 ? '0' + month : month}-01`;

      currentBalance += transaction.amount;

      if (!monthlyBalances[firstOfMonth]) {
        monthlyBalances[firstOfMonth] = currentBalance;
      } else {
        monthlyBalances[firstOfMonth] = currentBalance;
      }

    });

    // Fill in the missing months
    const firstTransactionDate = new Date(transactions[0].date);
    const lastTransactionDate = new Date(transactions[transactions.length - 1].date);
    const filledMonthlyBalances = [];
    let currentDate = new Date(firstTransactionDate.getFullYear(), firstTransactionDate.getMonth(), 1);

    while (currentDate <= lastTransactionDate) {
      const month = currentDate.getMonth() + 1; // Months are zero-based
      const year = currentDate.getFullYear();
      const firstOfMonth = `${year}-${month < 10 ? '0' + month : month}-01`;

      if (!monthlyBalances[firstOfMonth]) {
        monthlyBalances[firstOfMonth] = currentBalance;
      } else {
        currentBalance = monthlyBalances[firstOfMonth];
      }

      filledMonthlyBalances.push({
        month: firstOfMonth,
        balance: currentBalance
      });

      currentDate.setMonth(currentDate.getMonth() + 1);
    }

    return filledMonthlyBalances
  }

}