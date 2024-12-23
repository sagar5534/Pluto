import { Injectable } from "@nestjs/common"
import { InjectRepository } from "@nestjs/typeorm"
import { Account } from "src/entities/account.entity"
import { Repository } from "typeorm"


@Injectable()
export class AccountRepository {
  constructor(
    @InjectRepository(Account) 
    private accountRepository: Repository<Account>,
  ) {}

  async create(accountData: Partial<Account>): Promise<Account> {
    const account = this.accountRepository.create(accountData);
    return this.accountRepository.save(account);
  }

  async getById(id: number): Promise<Account> {
    return this.accountRepository.findOneOrFail({ where: { id } });
  }

  async findAll(): Promise<Account[]> {
    return this.accountRepository.find();
  }

  async update(account: Partial<Account>): Promise<Account> {
    const { id } = await this.accountRepository.save(account);
    return this.accountRepository.findOneOrFail({where: { id }});
  }
  
  async remove(id: number): Promise<void> {
    await this.accountRepository.delete(id);
  }

}