import { Injectable } from "@nestjs/common"
import { InjectRepository } from "@nestjs/typeorm"
import { Transaction } from "src/entities/transaction.entity";
import { Repository } from "typeorm"


@Injectable()
export class TransactionRepository {
  constructor(
    @InjectRepository(Transaction) 
    private repository: Repository<Transaction>,
  ) {}

  async create(transactionData: Partial<Transaction>): Promise<Transaction> {
    const transaction = this.repository.create(transactionData);
    return this.repository.save(transaction);
  }

  async getById(id: number): Promise<Transaction> {
    return this.repository.findOneOrFail({ where: { id } });
  }

  async findAll(): Promise<Transaction[]> {
    return this.repository.find();
  }

  async update(transactionData: Partial<Transaction>): Promise<Transaction> {
    const { id } = await this.repository.save(transactionData);
    return this.repository.findOneOrFail({where: { id }});
  }
  
  async remove(id: number): Promise<void> {
    await this.repository.delete(id);
  }

}