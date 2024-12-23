import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { AccountResponseDto, CreateAccountDto, UpdateAccountDto } from 'src/dtos/account.dto';
import { AccountRepository } from 'src/repositories/account.repository';

@Injectable()
export class AccountService {
  
  @Inject(AccountRepository) protected accountRepository: AccountRepository;

  async getAll(): Promise<AccountResponseDto[]> {
    const account = await this.accountRepository.findAll();
    if (!account) {
      throw new BadRequestException('Account not found');
    }
    return account;
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

}