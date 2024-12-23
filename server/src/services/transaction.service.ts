import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { TransactionResponseDto, CreateTransactionDto, UpdateTransactionDto } from 'src/dtos/transaction.dto';
import { TransactionRepository } from 'src/repositories/transaction.repository';

export class TransactionService {

  @Inject(TransactionRepository) protected transactionRepository: TransactionRepository;

  async getAll(): Promise<TransactionResponseDto[]> {
    const transaction = await this.transactionRepository.findAll();
    if (!transaction) {
      throw new BadRequestException('Transaction not found');
    }
    return transaction;
  }

  async create(dto: CreateTransactionDto): Promise<TransactionResponseDto> {
    const transaction = await this.transactionRepository.create(dto);
    return transaction;    
  }

  async update(id: number, dto: UpdateTransactionDto): Promise<TransactionResponseDto> {
    const transaction = await this.findOrFail(id);
    const updatedTransaction = await this.transactionRepository.update({
      id: transaction.id,
      ...dto
    });
    return updatedTransaction;
  }

  async delete(id: number): Promise<void> {
    const transaction = await this.findOrFail(id);
    await this.transactionRepository.remove(transaction.id);
  }

  private async findOrFail(id: number) {
    const transaction = await this.transactionRepository.getById(id);
    if (!transaction) {
      throw new BadRequestException('Transaction not found');
    }
    return transaction;
  }
}